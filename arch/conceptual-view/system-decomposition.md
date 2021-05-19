System decomposition
--------------------
> Breaking it down into sub-systems.


### Functional decomposition

Here's the breakdown of the Kitt4Sme platform into sub-systems and layers.

**TODO**: **the text below is a straight C&P from the proposal and needs
some massaging!**

With the aim of building an open source platform for uptake of AI solutions
in manufacturing SMEs, KITT4SME selected the currently best-in-class open
source platform for IoT: FIWARE. Figure 6 illustrates the different platform
layers (components in the mid-blue boxes are provided by FIWARE). FIWARE
is a scalable open source component framework that can be composed to
integrate, handle and manage context information from different data sources,
distribute that data and stream it into involved external components for
persistence as well as for AI-based processing aims. Computed results can
then be integrated back enabling actuation and the enrichment of the
current context.

Starting from the lowest layer, the KITT4SME architecture covers data
gathering from different devices, deployed in the factory, feeding the
knowledge-base of the system with raw and pre-processed data:

* Wearable Sensors, worn by the worker, are meant to help monitor
  psychophysical parameters related to health and well-being. According
  to the “human in the loop” principle, those sensors can be also involved
  within the decision-making loop.
* Cyber-Physical Systems, especially those typically involved within the
  process (machining equipment, 3D printers, collaborative robots, automated
  logistics, etc.).
* Environmental Sensors, scattered in the factory and aimed to collect
  information on the environmental conditions (i.e. air pollution, temperature,
  noise level, etc.).

At the next layer, the FIWARE framework provides a set of Generic Enablers
interfacing devices for the purpose of gathering context information or
triggering actuations in response to context updates:

* The IDAS Generic Enabler which offers a wide range of IoT Agents meant to
  interface devices using the most widely used IoT protocols (LWM2M over CoaP,
  JSON and UltraLight2.0 over HTTP/MQTT/AMQP, OneM2M or OPC-UA).
* The FAST RTPS Generic Enabler that adopts ROS2 middleware, which helps to
  interface with robotics systems.
* The Generic Enabler Kurento that enables real-time processing of media
  streams to support the transformation of video cameras into sensors as well
  as the incorporation of advanced application functions (integrated audiovisual
  communications, augmented reality, flexible media playing and recording, etc.)

The next upper layer shows the FIWARE Context Broker, the core and mandatory
component for a Powered by FIWARE solution. It enables to manage context
information in a decentralized and large-scale way. It provides a RESTful
API enabling to perform updates, queries or subscribe to changes on context
information. The Context Broker holds information about current context data,
i.e. the current and most recent update status of all the devices, components
and processes that are engaged in a processing industry factory. However,
context information evolves over time, creating a context history that is 
fundamental for analytical and machine learning tasks that base their algorithms
on dedicated time windows of factory context data. FIWARE provides own Generic
Enabler to persist Time Series historical data, QuantumLeap and STH-Comet, but
can also forward the data to other third-party databases. Furthermore, data can
be streamed to distributed processing engines like the Big Data and AI-based
Detections Tools to enable analysis on historic data context.

![Layers][components]

The next upper layer shows those Big Data, AI-based detection and optimization
tools components. They process context history data in order to detect patterns
and correlations, anomalies, malfunctions, unexpected behaviours, outliers by
means of Big Data analytics, stream processing and to provide value-added
functionalities like process optimization or quality improvements. The results
of their processing are injected back into the FIWARE Context Broker to
activate the decision-making processes and actuations. The detection and
optimization tools can be continuously created and edited by using integrated
functional models editors such (like JupiterLab) and added as new FIWARE
components made available to the open source community by means of a
Functional Model Catalog.

At the same layer, the KITT4SME architecture foresees four further components:

* Human description Database, deployed by means of Cygnus, in charge of
persisting data related to the physiological parameters, information about
workers, machine parameters and environmental data that contribute to create
a complete representation of the worker in activity at the shop floor.
* The BI platform and suite Knowage: a FIWARE Generic Enabler to perform
traditional business analytics over classical data sources, databases and
big data systems. It enables manual ad-hoc OLAP analytics, dashboarding as
well as publishing reports about historical data and KPIs to extend the
automatic anomalies detection analytics capabilities.
* A Mashup Platform as KPI-driven process governance dashboard: it helps
the different operators within the factory to have immediate and easy access
at all the relevant context information that represent the latest status of
the processes. The dashboard is contextual: i.e. the interface is automatically
customized to the operator and to his location within the factory.
Localization is based on different technologies depending on the concrete
scenarios developed in the use cases. The RAMP platform, here integrated
and described afterwards, provides a set of factory dashboards, including
one integrated with this Mashup Platform provided by FIWARE.
* External IDS Connector: this connector represents a component of the IDSA
reference architecture. It works as a trustful interface between internal
data sources and external data consumers to enable secure and interoperable
data exchange. This connector makes the KITT4SME architecture ready to be
integrated with external value- added services where the data exchange is
regulated by the IDS policies.

As anticipated before, the results of the Big Data and (X)AI-based detections
and optimization solutions activate the decision-making mechanisms whose logics
can be modeled and then managed during execution by MPMS. Tasks belonging to
the activation process can foresee, on the one hand, a user interaction (for
example for inputting some information or simply for supervising some
decisions by means of a wearable devices) and, on the other hand, a behavioral
update for a group of involved CPS. Basically, the decision maker, supported
by the Intervention Manager, is meant to react in order to both optimize
process performances and workers’ well-being. The interventions are launched
at different levels (single workstation, work cell, production system), and
orchestrated so as to exploit the flexibility of the production system to
support operators whenever their behavior deviates from optimal and/or safe
performance.

The triggered actuations need to be identified by IDAS IoT Agents (again
through the FIWARE Context Broker) in order to finalize the retroactions
towards CPS on the basis on the decisions made.

Within the KITT4SME project, RAMP (Robotics and Automation MarketPlace)
enables the Software-as-a-Service provision of the above-mentioned components.
By enabling FIWARE-compatible equipment (robots, machines, sensors, mobile
devices etc.) in the production floor, it will be possible to directly use
the different tools offered by KITT4SME, without the need of timely software
deployments and IT expertise, allowing SMEs to focus on the value-adding
activities of their core business. On top of that, the distributed capabilities
of the architecture allow the tools and production data to be used
collaboratively between manufacturing SMEs and technology providers, providing
a better overview of the production status and facilitating the online
co-creation, which in turn minimises the need of continuous on-site inspections
and system installations. The KITT4SME components include different Dashboards
(Process monitoring, FIWARE Mashup, Data visualisation), as well as the Process
Design sub-module of the MPMS.

The KITT4SME Platform is supported by an IDM (IDentity Management & Access
Control) Generic Enabler that brings support to secure and private OAuth2-based
authentication of users and devices, user profile management, privacy-preserving
disposition of personal data, Single Sign-On (SSO) and Identity Federation
across multiple administration domains.




[components]: ./components.png
