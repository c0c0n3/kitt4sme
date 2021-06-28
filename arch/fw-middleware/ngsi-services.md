NGSI services
-------------
> Never Grind Sharp Instruments.


As noted in the [introduction][intro.platform], FIWARE is one of the
essential building blocks of the KITT4SME platform. FIWARE components
constitute the majority of the platform's IoT backbone through which
a digital representation of the shop floor is created, queried and
possibly manipulated to control physical devices in the factory. FIWARE
implements the [NGSI-v2][ngsi.v2] and [NGSI-LD][ngsi.ld] standards to
deliver this functionality, thus a brief analysis of how NGSI components
interact with each other to fulfil their function is in order. The
conceptual outline presented in the following is applicable to both
NGSI standards implemented by FIWARE.


### NGSI at a glance
The NGSI standards (v2, LD) define an ontology and interoperability
framework for IoT data. Grounded in REST principles and Linked Data,
NGSI sees information as a distributed (directed) graph on which RESTful
services and clients can operate by means of a RESTful API. The nodes
in the graph carry information about the system (e.g. device readings)
and the edges encode relationships (e.g. a device is in a factory).
This graph is variously referred to as "IoT context", "context information"
or simply as "the context" and can be partitioned among several RESTful
services (i.e. each service is responsible for maintaining only a part
of the graph). NGSI specifies how services cooperate to provide clients
with uniform access to the graph (location transparency) which gives
rise to several roles and responsibilities that communicating entities
can assume as well as several interaction patterns. We outline component
roles, responsibilities and interactions below.


### NGSI API
Being a RESTful API, NGSI provides operations to create, read, update
and delete Web resources. The basic mechanism through which a client
can invoke an operation on a resource maintained by an NGSI service
is the same as that explained in the previous section about RESTful
services (i.e. clients interact with NGSI services as explained earlier).

There are three kinds of resources:

* Context data. These resources are NGSI `Entity` instances that encode
  the system data. To each node and edge in the (conceptual) information
  graph corresponds an NGSI `Entity` instance. Thus, clients access and
  manipulate the graph (context) by invoking HTTP methods on `Entity`
  resources.
* Subscription data. These resources are NGSI `Subscription` instances
  that, as explained in the [information model], establish a publish-subscribe
  relationship between services whereby a subscriber service can ask an
  NGSI service (the publisher) to get notified of changes to the context
  data.
* Registration data. An NGSI service can use these resources to let other
  NGSI services know which parts of the context data it maintains. In this
  way, the information graph can be partitioned and distributed among services.


### Roles and responsibilities
The centrepiece of the NGSI architecture is the Context Broker service.
Context Broker maintains context data and implements the operations to
query and manipulate the context as required by the NGSI API specification.
Context Broker also maintains subscription data, thus it can act as a
publisher of context changes. Finally, Context Broker can manage registration
data too, assuming the role of a context registry. In this role, Context
Broker makes it possible for multiple services to maintain separate
portions of the context data.

Additional architectural roles arise from interactions that result in
producing or consuming context data. A process acts as context producer
whenever it creates, updates or deletes context data held in a context
broker. Instead of pushing data to Context Broker, a service can arrange,
through the provision of suitable registration data, for Context Broker
to pull context data from it. In this scenario, the service implements
the query facility of the NGSI API and is known as a context source.
As for consuming data, any client querying and retrieving context data
from a context broker is referred to as a context consumer. As noted
earlier, Context Broker can send context changes to subscribers. A
subscriber receiving context change notifications is also a context
consumer.


### Interaction patterns
Several interactions patterns are possible among NGSI services and
clients. NGSI services are RESTful services and, at the most basic
level, interactions follow the client-server paradigm, where clients
communicate with services over a network by exchanging request and
response messages as specified by the HTTP protocol and by the NGSI
API. However, depending on context data distribution, different service
roles are possible and, consequently, different high-level interactions
among services and clients. The interaction patterns that are most
relevant to the implementation of the KITT4SME platform infrastructure
are distilled into the two sections below.

#### Centralised context
In the centralised context pattern, a single Context Broker service
manages the entire context. The Context Broker service usually comprises
a pool of actual service processes which share the workload in order
to ensure scalability, fault-tolerance and high availability, but all
the processes in the pool operate on the same context data.

Consumers send the broker HTTP requests to query and retrieve NGSI
`Entity` data and the broker responds with data sourced from its own
database. Producers send the broker HTTP requests to create, update
or delete `Entity` data. As producers push new data to the broker or
update the existing context, the broker notifies context-change subscribers
(consumers) of state changes. Each notification is an HTTP request to
a subscriber's endpoint of choice and is typically sent asynchronously
with respect to the receipt of HTTP requests from context producers.

Centralised context is the most common arrangement in FIWARE deployments
and is also the pattern on which the initial implementation of the
KITT4SME platform infrastructure will be based. FIWARE agents in the
infrastructure layer acquire data from IoT devices or other data sources
in the factory, translate those data into NGSI entities and then forward
the entities to Context Broker. Thus, agents act as context producers
on behalf of external systems. AI services and KPI dashboards are typical
context consumers as well as time series services which subscribe to
context changes in order to track how context data varies over time.

#### Distributed context
In the distributed context pattern, multiple services maintain, each,
a separate portion of the context data. The context is divided in separate
sets of entities and each set is maintained by a dedicated context source
service. There is a context registry service where each context source
inserts entries (registry data) to indicate which part of the global
context it maintains. A Context Broker service provides consumers with
uniform access to the global context (location transparency) by fetching
and aggregating data from individual context sources. Usually, the broker
is also one of the context sources and it maintains the largest context
partition. As in the centralised context pattern, typically services
comprise a process pool to ensure scalability, fault-tolerance and
high availability.

Consumers send the broker HTTP requests to query and retrieve NGSI
`Entity` data and the broker responds with data fetched from registered
context sources. The broker first determines where to source the requested
entities by searching the registry. Then it queries these context sources
and aggregates the query results before returning them to the consumer.
Producers and context-change subscribers interact with Context Broker
as explained in the centralised context pattern.

The diagram below illustrates the concepts just introduced. It shows
a conceptual graph distributed between two sources. A broker service
maintains one of the two data partitions whereas an external system
maintains the other. The external system implements the query facility
of the NGSI API so that the broker can retrieve entities from it. A
consumer queries the broker and the broker searches the registry to
determine which sources provide the data sets on which the query should
be run. The registry indicates that two data sources maintain the
requested data sets: the broker itself and the external system. Thus,
the broker proceeds to fetch data both from its own database and from
the external system, then aggregates the results before returning them
to the consumer. The consumer is unaware of context partitions, it only
sees a uniform global context which it can query.

![Distributed context and queries.][distrib-ctx]

If the need arose to integrate on-premises, legacy IoT systems, the
distributed context pattern could offer an integration route into the
KITT4SME platform. For any such system, a context source adapter could
be developed to expose the external system data through the NGSI API.
As noted earlier, a context source only needs to implement the query
facility, not the entire NGSI API.




[distrib-ctx]: ./ngsi.distributed-ctx.png
[intro.platform]: ../intro/platform.md
[ngsi.ld]: https://www.etsi.org/deliver/etsi_gs/CIM/001_099/009/01.04.02_60/gs_CIM009v010402p.pdf
[ngsi.v2]: https://fiware.github.io/specifications/ngsiv2/stable/
