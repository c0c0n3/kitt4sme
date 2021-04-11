Information model
-----------------
> you speak NGSI?


A tenet of KITT4SME is that artificial intelligence (AI) has the potential
to increase the profitability of small and medium manufacturing enterprises
(SMEs) by improving product quality (e.g. through anomaly detection and
correction), by optimising production line configuration (e.g. rapid
reconfiguration to achieve lot-size-one production) and by levelling
up staff productivity (e.g. through stress relief suggestions and personalised
training). To enact such positive changes, the KITT4SME platform needs
to acquire heterogeneous data sets from a variety of sources and have
that information flow to AI components which can process it. Within
the platform itself, components which were not originally designed to
work together have to exchange information in order to perform KITT4SME
workflow tasks. For data to be exchanged and processed meaningfully
in a distributed system, processes have to agree on data formats and
semantics as well as on a communication mechanism. This chapter explains
how the KITT4SME platform achieves data interoperability through the
adoption of the NGSI standard, whereas later chapters address inter-process
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
the same device (e.g. think of a firmware upgrade) and a similar degree
of data format volatility can be expected of information systems (e.g.
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
course.** A data translation layer at the platform's boundary maps external
data to instances of NGSI entities in accordance with the KITT4SME NGSI
data models. The building blocks of this layer are the FIWARE agents,
software components that can interface with external systems using widely
implemented standards such as OPC UA and ROS. Agents can be easily configured
to translate data coming from external systems to a common format that
the rest of the platform components know how to handle, namely the NGSI
data format.


### Core FIWARE data model

**TODO**
* meat of the matter: turn the diagram below into words
* complement: example of IoT to NGSI data from sense-intervene diagram
* also: lift content from questions already answered in DMP

![FIWARE core data model.][dia-data-model]




[dia-data-model]: ./fiware-data-model.png
