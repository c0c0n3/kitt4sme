Document Overview
-----------------
> Ready to dive in?

The remainder of this document is structured as follows. Section 3
gives an account of the functional requirements and system quality
attributes which shape the architecture. Section 4 contains a functional
decomposition of the platform, introducing the key platform application
and infrastructure services as well as the RAMP marketplace. Components
which were not originally designed to work together have to exchange
information in order to perform KITT4SME workflow tasks. Section 5 explains
how the KITT4SME platform achieves data interoperability through the
adoption of a core data model based on the NGSI standards, whereas
section 6 examines interoperability from the distributed communication
standpoint, detailing how services interact according to Web standards
and the NGSI specification. The KITT4SME platform relies on a dedicated
cluster software infrastructure to transparently route and balance
service traffic, secure communication and access to service resources,
and monitor service operation. The particular arrangement of communicating
entities and the communication pattern are essential aspects of the
architecture which are also examined in section 6. How data are persisted
is the topic of section 7, with a focus on constructing time series from
shop floor data. Time series are essential to several statistical analysis
tools, KPI dashboards and machine learning algorithms which will be
developed for the KITT4SME platform. Section 8 addresses platform security.
In particular, it discusses the implementation of identity management,
access control, data encryption, secure communication and traceability.
Section 9 focuses on the deployment and operation of the KITT4SME platform.
It provides an overview of the placement of the software and its execution
on a cluster, explains how to connect the shop floor IoT environment
to the running platform instance, and also discusses the continuous
delivery of platform functionality through an infrastructure-as-code
(IaC) approach. Section 10 is devoted to the RAMP platform, with an
emphasis on how KITT4SME and RAMP complement each other. In fact, RAMP
offers solution providers a comprehensive set of tools to deliver their
services and support to manufacturers as well as factory KPI dashboards.
The last part of the document, section 11, introduces the platform prototype
that has been developed to validate the architecture.



