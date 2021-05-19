Pub/sub and IoT context propagation
-----------------------------------
> The Hollywood principle: don't call us, we'll call you!

Publish-subscribe is one of the foundational messaging patterns of the
KITT4SME communication infrastructure. The [information model][info-model]
section introduced the basic data structures on which the KITT4SME
publish-subscribe mechanism rests. The way in which heterogeneous
software components can use the aforementioned structures to exchange
information and coordinate inter-process communication is the subject
of the present section.


### IoT context change notifications

KITT4SME platform services and external data producers (e.g., devices
at a factory) share information by means of a (possibly distributed)
NGSI entity graph referred to as the IoT context. A dedicated platform
service, Context Broker, maintains the IoT context and makes it available
as a set of Web resources, allowing both context producers to manipulate
it (e.g., create or update an entity) and context consumers to query
it through REST operations as specified by the NGSI standard.

In addition to querying the IoT context, consumers can get notified
of changes to a selected sub-graph of interest. This change notification
facility is based on HTTP call-backs and is usually more efficient than
polling the IoT context directly to detect state changes. Before it can
receive notifications, a consumer (the subscriber), has to register for
state change notifications with Context Broker. This is done by sending
an HTTP `POST` message to Context Broker carrying a `Subscription` object.
This object specifies a URL where Context Broker can send state change
notifications to the subscriber and defines a predicate on entities.
On accepting the `Subscription`, Context Broker establishes a publish-subscribe
relationship with the subscriber whereby if an entity in the IoT context
is created or modified and the predicate evaluates to true on that entity,
then Context Broker (the publisher) sends an HTTP message to the subscriber
with the changed data. Note that a subscription predicate can match more
than one entity, thus it implicitly defines a sub-graph of the IoT context.

This arrangement can be seen as a variation on the theme of the
publish-subscribe pattern found in messaging systems. In fact, context
producers do not send messages directly to context consumers but rather
use Context Broker as an intermediary to forward data to consumers as
needed. Thus direct links among producers and consumers (space coupling)
can be avoided which helps to scale the system and increase its availability.
Moreover, similar to messaging systems, subscribers can select a subset
of the data for which they would like to receive notifications. However,
there are some substantial differences with respect to messaging systems.
The NGSI standard does not mandate any message delivery guarantees and
current Context Broker implementations either offer none or weak ones,
such as HTTP retries. As a result, consumers must be running when producers
update the IoT context, otherwise notification messages may be lost.
This is a form of time coupling between producers and consumers which
most messaging systems actually avoid and which lessens overall system
resiliency and fault tolerance capability.

Although not explicitly required by the NGSI standard, most Context
Broker implementations notify subscribers asynchronously with respect
to the receipt of producer messages. This way when a producer sends
Context Broker an HTTP message to update the IoT context, it only has
to wait for Context Broker to process the NGSI entities in the message
body, rather than for all relevant subscribers to consume state change
notifications. However, it should be noted that slow notification consumers
(subscribers) can still have a dramatic impact on overall system throughput.
This is especially so where Context Broker implementations notify subscribers
in dedicated threads (most of them do, rather than using operating system
asynchronous IO facilities), since, given the synchronous nature of the
HTTP protocol, a thread would have to block until the subscriber returned
an HTTP response. The larger the number of threads blocked on IO, the
smaller the number of subscribers that can be notified per second and
the higher the Context Broker resource load which in turn affects the
rate at which producer data (e.g. new readings from the shop floor) can
be acquired. To alleviate performance bottlenecks, subscribers should
be programmed to process notifications expeditiously or to perform the
actual processing asynchronously, e.g., by enqueueing a job to a separate
work queue.
**TODO** *mention you can scale out Orion? But this is still wasteful
compared to optimising subscribers. Also this whole Orion
scalability/replication/consistency thing needs careful thinking b/c
of Orion’s semaphores & stateful update/notification procedure which
makes the lost update problem more likely the more replicated instances
you have.*

The publish-subscribe pattern described thus far is central to the
communication infrastructure that supports the Sense and Intervene
phases of the KITT4SME workflow. It allows to connect heterogeneous
services in event-based workflows where each service can function
independently and without direct knowledge of the others. In particular,
it provides the means by which AI services can keep abreast of any
change in the shop floor and possibly react with corrective actions
or recommendations as the case may be. Additionally, it enables the
construction of time series from IoT context data, as we shall see in
the Persistence section of this document. In turn, time series are
essential to training Machine Learning models, performing statistical
analysis of shop floor data and assembling KPI dashboards. Inasmuch
as publish-subscribe is a staple of the KITT4SME software infrastructure,
a detailed example is provided below to illustrate some of the finer
points of how components interact.


### A typical scenario

The UML (custom) communication diagram below depicts a typical publish-subscribe
scenario involving a data producer (a robotic arm named `foobie`) and
a consumer process (an instance of a certain `bar-monitor` AI service).
`foobie` can measure two parameters, known to the device as `f'` and
`b'`. As in the Sense-Intervene example scenario [presented in the
introduction][intro.plat.s-i], `foobie` is deployed on the Smithereens
shop floor, whereas another two devices, `foobar` and `foodev`, capable
of measuring the same parameters, operate in a separate factory owned
by another company, ManuFracture. Since the meaning of the two parameters
is the same across all these devices, a common data model shared by
the two companies has been devised which contains an NGSI entity of
type `Bot` with attributes `foo` and `bar` in correspondence of the
two parameters `f'` and `b'`, respectively.

As a service, `bar-monitor` is blissfully unwitting of the devices
producing those data and of how the IoT context acquires the data,
yet fully cognisant of the existence of the `Bot` entity and of the
meaning of its `bar` attribute. In fact, `bar-monitor` is programmed
to observe `bar` values entering the IoT context and to issue commands
to perform corrective actions within the shop floor on detecting anomalous
`bar` values.

![IoT context change propagation.][dia.ctx-change]

#### Subscribing to Bot entity changes
In order to observe changes to the IoT context, the `bar-monitor` process
needs to create a `Subscription` with the `context-broker` process, an
instance of a FIWARE Context Broker service. As is the case with NGSI
Entities, both individual `Subscription`s and the collection of all
`Subscription`s are RESTful resources on which clients can operate
through HTTP methods. Therefore, `bar-monitor` creates its subscription
by sending an HTTP `POST` message to the NGSI API `subscriptions` endpoint
exposed by `context-broker`. The message body contains a `Subscription`
object which `context-broker` adds to the collection of subscriptions
in its database as shown by steps 1 and 2 in the diagram.

The `POST` message is interpreted as follows. The type and condition
data within the `Subscription` object define a predicate `p` on NGSI
entities which evaluates to true on any given entity `e` just in case
`e`'s type is `Bot` and `e` contains a `bar` attribute with a value
greater than 8. Moreover, the URL value instructs `context-broker` to
send state change notifications to the `/mon` HTTP endpoint on the `bar`
host, which is where `bar-monitor`'s NGSI data port accepts incoming
notifications. Finally, the attribute list in the `Subscription` object
requests that only `bar` attributes be included in notification payloads.

From this point onwards, the two processes stand in a publisher-subscriber
relationship, whereby for any entity `e` in the IoT context if a change
occurs to `e` (e.g., `foobie` sends new readings) resulting in a new
entity state `e'` and `p(e')` evaluates to true, then `context-broker`
(the publisher) sends `e''` to `bar-monitor` (the subscriber), where
`e''` is the entity obtained from `e'` by removing all attributes except
for `bar`. In other words, `e''` has the same `id`, `type` and `bar`
fields as `e'` but nothing else.

#### Acquiring new device readings
Subsequent to the subscription creation, `foobie` collects new readings
and forwards them to the platform. It streams the readings to the device
data port of the FIWARE Agent which was configured to accept data from
`foobie` when the device provisioning procedure was executed. Step 3
in the diagram shows data flowing from the device to the platform boundary
where the agent sits.

`foobie` is represented by a `Device` object within the KITT4SME live
platform. This object has a device ID of 2 and belongs to the `ServiceGroup`
identified by the `5d4z` API key. Accordingly, `foobie` sends an HTTP
`POST` message to the agent using the following URL: `/iot/d?i=2&k=5d4z`.
The URL's path component routes the message to the agent's device data
endpoint, whereas the `i` and `k` query parameters identify the `Device`
and the `ServiceGroup`, respectively. The message body contains two
labelled readings, `f' 4` and `b' 9`, separated by a pipe character.

This data format is understood by the Agent too, thus on receiving the
message, the Agent is able to decode it and construct an NGSI entity
from the message data. The transformation process from device data to
NGSI entity is made possible by a translation map defined when the device
was provisioned. This map establishes a correspondence between `foobie`
data and NGSI entities as follows. First, data received from devices
in the `ServiceGroup` identified by API key `5d4z` (`foobie`'s service
group) are to be converted into entities of type `Bot`. Second, the
`Device` identified by ID 2 (`foobie`) corresponds to the `Bot` entity
with ID 2. Last, the data fields `f'` and `b'` produced by this device
are to be transformed into entity attributes `foo` and `bar`, respectively.

#### Requesting a Bot entity update
Thus, on receiving the two readings `f' 4` and `b' 9`, the agent retrieves
`foobie`'s translation map from its configuration database and uses it
to construct a `Bot` entity `β` having an ID of 2, a `foo` attribute
with a value of 4 and a `bar` attribute with a value of 9. Then the
agent sends an HTTP `POST` message to the NGSI API `entities` endpoint
exposed by `context-broker` in order to update the IoT context with
the new readings received from `foobie`. The message URL encodes that
this in an update for the `Bot` entity with ID of 2, whereas the message
body contains the actual NGSI entity `β` just assembled from the original
device readings. Step 4 in the diagram illustrates this interaction.

#### Update and notification
At this point, `context-broker` saves `β` to its database and evaluates
the predicate `p` defined by `bar-monitor`'s subscription. As `p(β)`
evaluates to true, `context-broker` proceeds to send a state change
notification to `bar-monitor`. This notification is an HTTP `POST`
message destined for the `/mon` endpoint of `bar-monitor` as requested
in the subscription. The message body contains an entity derived from
`β` by removing the `foo` attribute in accordance with `bar-monitor`'s
subscription. Steps 5 and 6 in the diagram summarise this entity update
and notification workflow.




[dia.ctx-change]: ./ctx-change-propagation.png
[info-model]: ./data.md
[intro.plat.s-i]: ../intro/platform.md#senseintervene
