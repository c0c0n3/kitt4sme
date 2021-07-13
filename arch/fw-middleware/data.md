Information model
-----------------
> you speak NGSI?


A tenet of KITT4SME is that artificial intelligence (AI) has the potential
to increase the profitability of small and medium manufacturing enterprises
(SMEs) by improving product quality (e.g., through anomaly detection and
correction), by optimising production line configuration (e.g., rapid
reconfiguration to achieve lot-size-one production) and by levelling
up staff productivity (e.g., through stress relief suggestions and personalised
training). To enact such positive changes, the KITT4SME platform needs
to acquire heterogeneous data sets from a variety of sources and have
that information flow to AI components which can process it. Within
the platform itself, components which were not originally designed to
work together have to exchange information in order to perform KITT4SME
workflow tasks. For data to be exchanged and processed meaningfully
in a distributed system, processes have to agree on data formats and
semantics as well as on a communication mechanism. This section explains
how the KITT4SME platform achieves data interoperability through the
adoption of the NGSI standard, whereas later sections address inter-process
communication.


### Taming heterogeneous data

In relation to the Sense phase of the KITT4SME workflow, the platform
is expected to be able to acquire data from the shop floor through a
diverse range of Internet of Things (IoT) devices and cyber-physical
systems such as wearable devices, environmental sensors, cameras and
robots. Data can flow in the other direction too, i.e. from the platform
to the shop floor, as AI components issue commands to control devices
or suggest corrective actions during the Intervene phase of the KITT4SME
workflow. Additionally, part of the data held in existing information
systems in operation at the factory, typically demand & supply systems
and MES, may need to be integrated into the platform.

Each IoT device or robot typically produces raw data (e.g. a temperature
reading) in a proprietary format which may vary over time even within
the same device (e.g., think of a firmware upgrade) and a similar degree
of data format volatility can be expected of information systems (e.g.,
think of a database schema change). Thus, to acquire data from those
environments, a plethora of diverse data formats will need to be understood
by the platform, at least at its boundary where information is exchanged
with external systems. Moreover, new formats may have to be accommodated
as shop floors are connected to the platform. The same line of reasoning
applies to data semantics too as the structure and interpretation of the
data has to be known by platform components which extract information
from those data.

To avoid the engineering effort required to adapt platform components
to work directly with external, heterogeneous information models, the
KITT4SME platform adopts NSGI as a standard information model to represent
shared data within the platform, i.e. data which multiple components
need to process, not necessarily data that different owners decided
to share. Furthermore, NGSI makes provisions for components to access,
modify and exchange data in a uniform fashion. To wit, NGSI extends
well-known Web standards, such as Representational state transfer (REST)
and Linked Data, to develop an ontology and interoperability framework
for IoT. In particular, entities and relationships which constitute the
system data (the so-called IoT "context" in NGSI parlance) become Web
resources, each identified by a unique Uniform Resource Identifier (URI)
and retrievable through an HTTP call by constructing a suitable Uniform
Resource Locator (URL) from the resource's URI. Those Web resources are
made available through a Web service, the FIWARE Context Broker, which
provides a standard mechanism for clients to discover what resources are
available in the IoT context that it manages. In somewhat more detailed
terms, a client can request a number of well-known top-level nodes (resources)
in the information graph (IoT context) from which other nodes are reachable
by following the edges (links) returned along with those nodes.

Thus, for the sake of interoperability, platform data can be thought of
as a graph where nodes are instances of NGSI data structures and edges
are instances of links among NGSI data structures in a given NGSI data
model. The KITT4SME project will develop NGSI data models for the manufacturing
industry in order to achieve semantic interoperability of platform components.
(As separate document detailing said data models will be provided in due
course.) A data translation layer at the platform's boundary maps external
data to instances of NGSI entities in accordance with the KITT4SME NGSI
data models. The building blocks of this layer are the FIWARE agents,
software components that can interface with external systems using widely
implemented standards such as OPC UA and ROS. Agents can be easily configured
to translate data coming from external systems into a common format that
the rest of the platform components know how to handle, namely the NGSI
data format. It should also be noted that the NGSI specification is a
widely adopted open-source standard. Therefore, the KITT4SME platform
will be interoperable with any external Web service capable of understanding
the NGSI data format. Furthermore, data sets originating from different
NGSI sites can be combined in a multi-site distributed system using the
federation framework provided by Context Broker.


**TODO**: refs/cites ⟶ specs, papers, etc.


### Core data model

Having introduced interoperability through NGSI as an abstract concept,
we are now ready to present a more concrete view of the data model on
which FIWARE components operate. The material presented here constitutes
the developer's view of the data model and is applicable to both NGSI
specifications currently implemented by the FIWARE platform, namely NGSI
v2 and NGSI LD. Moreover, we conceptualise elements of the FIWARE data
model which are not in the NGSI specifications but are essential for
practical purposes nonetheless. In this regard, this material represents
a practical, unified view of the core data model adopted by the KITT4SME
platform for the sake of interoperability.

#### Entities and relationships
We begin with the elements of the data model which allow to encode objects
(concepts, things, etc.) and relationships among them. The `Entity` data
structure identifies a certain concept of interest in a model and describes
its properties. Each `Entity` object must have an `id` field containing
a URI that uniquely identifies it and a `type` field to classify the object. 
An `Entity` contains one or more `Attribute`s, each with a `value` and
a `type` field. The `value` field holds the actual value of an object's
property whereas the `type` field contains a text label which specifies
the data type of that value. When processing an entity, some FIWARE components
attempt to interpret an attribute's value according to the type label,
thus it is important to use a label suitable for the value at hand. Most
FIWARE components support boolean types (`type = Boolean`), numeric types
(`Integer`, `Float`, `Number`), text (`String`, `Text`), time (`Date`,
`Time`, `DateTime`), geometry (points, lines, etc.), arrays (`Array`)
and instances of arbitrary data structures (`StructuredValue`). Additionally,
an attribute having a type of `Relationship` is interpreted as a pointer
to other entities and its `value` should be one or more URIs identifying
other entities in the system. Thus, these "Relation" attributes play a
special role among attributes in that they allow to encode an entity
graph where nodes are `Entity` instances and edges are Relation attributes.

#### JSON representation
FIWARE services exchange data by means of JSON documents. Each `Entity`
instance is encoded as a JSON `object` with `id` and `type` `string` fields
and an `object` field in correspondence of each `Attribute`. By way of
example, the JSON document below encodes an instance of a milling machine
entity owned by a company named Smithereens. One attribute of this entity
is the temperature of the machine's spindle and the other is a pointer to
a separate entity representing the shop floor where the milling machine
is located.

```json
{
    "id": "urn:ngsi-ld:smithereens:MillingMachine:1f3d-8776-a3d5-671b",
    "type": "MillingMachine",
    "spindleTemperature": {
        "type": "Float",
        "value": 64.8
    },
    "refShopFloor": {
        "type": "Relationship",
        "value": "urn:ngsi-ld:smithereens:ShopFloor:2"
    }
}
```

Another special kind of attribute is the "Metadata" attribute which can
be nested inside an attribute to convey additional information about the
attribute's value. The JSON fragment below contains the same
`spindleTemperature` attribute from the previous example but with two
additional metadata fields to provide an accuracy rating for the measured
temperature and a timestamp indicating when the reading was taken.

```json
{
    ...
    "spindleTemperature": {
        "type": "Float",
        "value": 64.8
        "metadata": {
            "accuracy": {
                "value": 2,
                "type": "Number"
            },
            "timestamp": {
                 "value": "2021-04-12T07:20:27.378Z",
                 "type": "DateTime"
            }
        }
    }
    ...
}
```

#### Entity hierarchies and multi-tenancy
Entities are organised in a hierarchy tree where inner nodes are identified
by text labels and leaf nodes are entities. FIWARE services let clients
operate on entity data through HTTP requests. When a client requests an
entity operation, it specifies a path on the tree to restrict the scope
of the operation to the entities below the last inner node in the path.
This path is specified through the `fiware-servicepath` HTTP header and
is a string assembled by joining the labels identifying the inner nodes
in the path from the root to the last node using a slash character as
a separator. For instance, the tree path `root ⟶ factory1 ⟶ floor2`
would be encoded as `/factory1/floor2`. The concept of a `Service` furnishes
the data architect with an even stronger mechanism to separate entities
into disjoint groups: all the entities in the system are partitioned
by service. Thus, entities in one service partition are isolated from
the entities in any other partition. Often FIWARE-based cloud solutions
exploit this mechanism to implement multi-tenancy: a tenant (typically
a company utilising the cloud's services) is identified with a FIWARE
`Service` so that their data, i.e. the entity hierarchies they own, are
not accessible to other tenants (FIWARE `Service` instances) in the system.
FIWARE `Service`s are identified by unique text labels which clients
wanting to access entity data must specify through the `fiware-service`
HTTP header. The UML class diagram below models the concepts of entities,
attributes, entity hierarchies and services as explained thus far and
introduces some new concepts regarding device provisioning and a
publish-subscribe mechanism to which we are going to turn our attention
next.

![FIWARE core data model.][dia-data-model]

#### Agents and device provisioning
A fundamental concept of any IoT system is that of a physical object
(a "thing") equipped with hardware and software which allows it to sense
its environment, exchange data and possibly perform actions in response
to software commands. Any such external device can be connected to a
FIWARE system so that FIWARE services can use any data which it produces
or issue commands to operate it. The process of interfacing a device with
a FIWARE system is often referred to as "provisioning" the device. The
two key data structures to enable this process in FIWARE are the `Device`
and the `ServiceGroup`. The `Device` structure holds the information
needed to interface with a physical device. Its `id` field uniquely
identifies the physical device within a FIWARE system whereas the `protocol`
field specifies the communication protocol to be used to interact with
the device, e.g. OPC UA. As explained earlier, within FIWARE data are
encoded through `Entity` structures and external data need to be converted
to `Entity` instances for FIWARE services to be able to use those data.
Consequently, a `Device` is paired with an `Entity` and specifies a
translation map to be used by FIWARE Agents to convert external data
to an instance of the `Entity` associated with the `Device`. In most
cases, the translation map is a list of transformation instructions
from external data fields to `Attribute`s, however it is also possible
to specify more sophisticated data transformations.

Perhaps an example is in order. Recall the [brief discussion][intro.plat.s-i]
from the introduction section about leveraging FIWARE to provide an
interoperable communication infrastructure to support the Sense and
Intervene phases of the KITT4SME workflow. The diagram accompanying
the text showed the devices owned by two manufacturing companies streaming
readings to the platform. One stream contained the following labelled
measurements

    f: 3
    b: 7

supposedly sent by the `foodev` device through a certain protocol `P`.
On crossing the platform boundary, the data were converted to an NGSI
entity

```json
{
    "id":   "urn:ngsi-ld:manufracture:Bot:1",
    "type": "Bot",
    "foo": {
        "type": "Integer",
        "value": 3
    },
    "bar": {
        "type": "Integer",
        "value": 7
    }
}
```

This is a typical scenario indeed and involves configuring a FIWARE
Agent which can handle protocol `P` on the receiving end. The Agent
would be provisioned with a `Device` instance specifying the external
device ID, the target entity ID and a description of how to transform
the external data fields into entity attributes as in the JSON document
below.


```json
{
    "device_id":   "foodev",
    "entity_name": "urn:ngsi-ld:manufracture:Bot:1",
    "entity_type": "Bot",
    "attributes": [
        { "object_id": "f", "name": "foo", "type": "Integer" },
        { "object_id": "b", "name": "bar", "type": "Integer" }
    ]
}
```

Each `Device` instance identifies a physical device. Hence, there must
be one instance in correspondence of each physical device linked to the
system through the provisioning process. `Device` instances sharing the
same target `Entity` type are collected together in a `ServiceGroup`.
A `ServiceGroup` defines the Agent service endpoint which the physical
devices in the group use to communicate with FIWARE. In order to send
data, physical devices need to know to which `ServiceGroup` they belong.
The API key field of a `ServiceGroup` serves the purpose of identifying
the group with the physical device. When sending data to the Agent endpoint,
a physical device specifies the API key of the group to which it belongs.
A `ServiceGroup` also contains the URL of the Context Broker to which
data should be forwarded after having been transformed into an NGSI
entity. (Recall that Context Broker is the service which maintains the
entities constituting the current state of the system.) The following
JSON document exemplifies how to create a `ServiceGroup` for an HTTP
endpoint to service devices configured with a target entity type of `Bot`.

```json
{
    "apikey":      "3z4w",
    "cbroker":     "http://orion:1026",
    "entity_type": "Bot",
    "resource":    "/iot/d"
}
```

A physical device having a corresponding `Device` instance in this
`ServiceGroup` would construct the URL of the service endpoint by setting
the path component to the value of the `resource` field and then appending
a query string containing the API key and the ID of its `Device` instance
as in the URL below which shows the path and query which the device `foodev`
would construct to call the Agent endpoint:

    /iot/d?i=foodev&k=3z4w

#### IoT context change notifications
An important aspect of the KITT4SME architecture is the publish-subscribe
mechanism through which changes to the IoT context (system data) held
by Context Broker are propagated to other services. Any service can observe
changes to the IoT context by creating a `Subscription` with Context Broker.
To create a `Subscription`, the service (the `Subscriber`) specifies an
HTTP endpoint where Context Broker can send state change notifications
and an entity predicate (condition) `p` which, when true, will trigger
the notification. More accurately, for any entity `e` in the IoT context
if a change occurs to `e` (e.g., a device sends new readings) resulting
in a new entity state `e'` and `p(e')` evaluates to true, then Context
Broker sends `e'` to the subscriber. Subscribers can also instruct Context
Broker to send a subset of the changed entity data instead of the whole
entity `e'`. This is done by specifying a list of attributes `[a, b, ...]`
in the subscription so that Context Broker will only include the corresponding
attribute values in the notification. For instance, a subscriber could
create a subscription to get notified of any change to entities of type
`Bot` from the previous example but request that only the current data
of the `foo` attribute be included in the notification.

This publish-subscribe pattern serves as the primary means through which
KITT4SME services can keep abreast of any change in the shop floor and
possibly react with corrective actions or recommendations as the case
may be. In other words, publish-subscribe sits at the core of the communication
infrastructure that supports the Sense and Intervene phases of the KITT4SME
workflow. Moreover, it is also what enables the construction of time
series from IoT context data. In fact, the KITT4SME platform features
a time-series service whose purpose is to maintain a historical record
of the IoT context which Context Broker makes available. The time-series
service is notified of IoT context changes and records any modifications
to NGSI entities. It constructs a time-indexed sequence of changes for
each entity: `{ (t0, e0), (t1, e1), … }`, where `t0` is the time when
the entity was created and `e0` is the initial entity data; `e1` is the
entity data as it was at time `t1` when the entity was modified; and
so on. Thus each entity has an associated sequence of real numbers (the
time index values `t0`, `t1`, …) which identify the changes to that entity
over time. In other words, the entity data is versioned by the time
index numbers.




[dia-data-model]: ./data-model.png
[intro.plat.s-i]: ../intro/platform.md#senseintervene
