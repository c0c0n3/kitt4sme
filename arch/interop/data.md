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
to translate data coming from external systems to a common format that
the rest of the platform components know how to handle, namely the NGSI
data format.


**TODO**: refs/cites for specs, papers, etc.


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
the data modeller with an even stronger mechanism to separate entities
into disjoint groups: all the entities in the system are partitioned
by service. Thus, entities in one service partition are isolated from
the entities in another partition. This mechanism is used in practice
to implement multi-tenancy...


**TODO**
* meat of the matter: turn the diagram below into words
* complement: example of IoT to NGSI data from sense-intervene diagram
* also: lift content from questions already answered in DMP

![FIWARE core data model.][dia-data-model]




[dia-data-model]: ./fiware-data-model.png
