FIWARE middleware
-----------------

The FIWARE middleware is KITT4SME's IoT communication, data exchange
and interoperability backbone.


### High-level functionality 

FIWARE is an open-source platform to build IoT applications and comprises
a curated set of components implementing the NGSI interoperability
specifications.

KITT4SME assembles a selection of FIWARE components into a middleware
to support the Sense and Intervene phases of the KITT4SME workflow.
During the Sense phase, this middleware allows KITT4SME application
services to acquire data from the shop floor through a diverse range
of IoT devices and cyber-physical systems such as wearable devices,
environmental sensors, cameras and robots. The same middleware makes
information flow in the other direction too, i.e. from the platform
to the shop floor, as AI components issue commands to control devices
or suggest corrective actions during the Intervene phase of the workflow.

The middleware also provides a foundation for interoperability, tracing
of data transactions and multi-tenancy. Instead of interfacing directly
with the shop floor IoT environment in an ad-hoc fashion, KITT4SME
application services interact with the shop floor through the FIWARE
middleware, using standard, interoperable APIs and data models defined
by the NGSI specifications. The middleware tags each data transfer
with the platform tenant who owns the data as well as a transaction
identifier. The KITT4SME security infrastructure then uses this information
to enforce security and trace data transactions.


### Role in the architecture

The FIWARE middleware is a set of platform infrastructure services.
Together, these services constitute the platform's IoT backbone through
which a digital representation of the shop floor (the IoT "context"
in FIWARE parlance) is created, queried and possibly manipulated to
control physical devices in the factory. The FIWARE middleware makes
the IoT context available as a distributed graph on which platform
application services can operate by means of REST APIs as specified
by the NGSI standards.

The middleware includes several FIWARE services as well as backend
databases:

- **OrionLD**. A FIWARE Context Broker implementing both the NGSI v2
  and LD specifications. It maintains IoT context data and publishes
  context changes. Typically, platform application services rely on
  OrionLD to get notified of changes in the shop floor IoT environment
  during the Sense phase of the KITT4SME workflow. Application services
  may interact with OrionLD in the Intervene phase too—e.g. to send
  high-level commands to shop floor devices.
- [QuantumLeap][ql]. A FIWARE IoT context management service. It
  tracks changes to the IoT context to build a history of context
  changes which then makes available to query over space and time
  through a REST API. KITT4SME leverages QuantumLeap's ability to
  track time varying measurements in the IoT context to provide platform
  application services with time series of shop floor measurements.
- **Agents**. A set of FIWARE services to interface with the shop
  floor IoT environment. Together, these services act as a data translation
  layer at the platform's boundary, mapping external data to instances
  of NGSI entities in accordance with the KITT4SME data models. They
  also translate high-level commands issued by application services
  into low-level instructions which IoT devices can understand. This
  layer comprises several software components that can interface with
  external systems using widely implemented standards such as OPC UA
  and ROS.
- **Databases**. A set of databases (MongoDB, Postgres, etc.) to
  provide the persistence backend for the above services. Note that
  these databases also provide a persistence backend to several platform
  application services.

The FIWARE middleware services rely on the underlying KITT4SME mesh
infrastructure for security, scalability and automated deployment.
As infrastructure services, their role is to support the operation
of application services, so unlike application services they are not
available in the RAMP marketplace. Below is a visual to summarise the
role of the FIWARE middleware in the KITT4SME architecture.

![FIWARE middleware context diagram][ql.dia]


### Requirements

The DoA committed to a FIWARE-based IoT platform and interoperable
solution to facilitate the integration of application services and
shop floor software. The FIWARE middleware has been developed to
fulfill exactly these requirements.


### Improvements

Except for [QuantumLeap][ql], no other middleware component has required
any modification to their respective code bases. However, a significant
amount of effort has gone into the plumbing needed to deploy and run
the middleware components on the mesh infrastructure. This has entailed
the development of Kubernetes and Istio manifests, Argo CD projects
and applications, and the fine-tuning of the middleware components
themselves. An early version of the middleware was open-sourced in
Q2 2021 as part of the initial platform prototype developed to validate
the KITT4SME architecture and is still available at:
https://github.com/c0c0n3/kitt4sme.
The middleware has since evolved into the current open-source version
at: https://github.com/c0c0n3/kitt4sme.live.
The work has been carried out in WP 2 as part of the FIWARE middleware,
persistence and deployment tasks.


### Value proposition 

Although the FIWARE middleware provides no direct business value to
KITT4SME end-users, it is a key component of the platform infrastructure
that enables the operation of application services delivering actual
business value. Unlike proprietary solutions, FIWARE is open-source
and based on time-tested IoT standards which dramatically reduce the
effort required to integrate application services and shop floor software
into an IoT continuum.




[fw.dia]: ./fiware.svg
[ql]: ./quantumleap.md
