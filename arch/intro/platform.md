Cloud platform
--------------
> Supporting the Kitt4Sme workflow.

Having introduced the KITT4SME workflow, we are now ready to present
a high-level, conceptual view of the software platform through which
it is implemented. Note that the KITT4SME workflow comprises a rich
set of activities some of which are carried out through a software
system or are only partially supported by software. However, in the
following we only focus on the aspects of the workflow which require
a software infrastructure to be performed. The interested reader is
referred to the original proposal to learn more about the details of
the KITT4SME workflow activities.

One of the main goals of the reference architecture is to define the
software infrastructure to support the KITT4SME workflow and the AI
services. We begin with introducing the concepts and principles which
constitute the foundation of the architecture. Then we proceed to show
how the platform supports the Diagnose, Compose, Sense and Intervene
steps of the KITT4SME workflow.


### Key concepts and guiding principles
The KITT4SME (software) platform is a service mesh, multi-tenant, cloud
architecture designed to assemble AI components from a marketplace into
a tailor-made service offering for a factory, connect these components
to the shop floor, and enable them to store and exchange data in an
interoperable, secure, privacy-preserving and scalable way. The KITT4SME
platform comprises loosely-coupled Web services that run in a cluster
environment and relies on a dedicated cluster software infrastructure.
The platform design revolves around the key concepts and principles
outlined below.

#### Leveraging state-of-the-art technology
The KITT4SME platform relies on a dedicated cluster software infrastructure.
This cluster software, referred to as "mesh infrastructure" in the following,
orchestrates the deployment and operation of services and provides a
uniform, programmable interface to computational resources (CPU, memory,
storage) across cluster nodes. Additionally, the mesh infrastructure
provides a programmable interface to manage, secure and observe service
traffic independently of services. Kubernetes together with Istio form
the preferred software stack to provide the mesh infrastructure, although
similar products may be employed.

Purely from a software standpoint, a key project objective is to combine
both the FIWARE and RAMP platforms in a unique software offering tailored
to the manufacturing industry. FIWARE is an open-source platform to build
Internet of Things (IoT) applications. It provides the building blocks to
acquire data from the shop floor and create a digital representation of
it which can then be queried and manipulated to control physical devices
in the factory, e.g. stop a conveyor belt. RAMP is a digital marketplace
where Smart industry solution providers can offer their software to
manufacturing industry customers.

#### Platform services
A service is a distinct part of the platform that provides some functionality
through a set of software processes and/or data stores. Typically a
service manages and mediates access to a collection of related resources,
presenting their functionality to users and/or other services. Discrete
application programming interfaces (APIs) encapsulate service implementation
and govern service interactions whereas policies control service access
and usage.

Broadly speaking, there are two kinds of KITT4SME platform services:
application services that are an integral part of the KITT4SME workflow
(e.g. an anomaly detection service, a KPI dashboard) and infrastructure
services that support the operation of application services, such as
the services in the FIWARE middleware.

#### RESTful interactions
Most KITT4SME platform services are expected to expose their functionality
through Web interfaces in accordance with the REpresentational State
Transfer (REST) architectural style. As a distributed architecture style,
REST is grounded in the client-server paradigm whereby clients communicate
with services over a network by exchanging request and response messages
as specified by the HyperText Transfer Protocol (HTTP).

A service makes its resources available as Web resources, each identified
by a unique resource locator (URL), and provides its functionality to
clients only through basic create, read, update, and delete operations
on these resources. The provided functionality is documented in a service
API, an out-of-band agreement between the service and its clients to
ensure correct service usage.

However, the operation invocation mechanism is independent of resources,
services and API specifications. Clients invoke service operations by
sending a request with the name of the operation (GET, POST, etc.) to
perform on a specific resource identified by a URL. The service responds
with a message indicating the outcome of performing that operation and
possibly a resource representation or the location (URL) where to retrieve
one if applicable. The HTTP protocol defines the semantics of each operation
(GET, POST, etc.) in terms of its effect on the target resource, thus
affording clients a uniform mechanism to invoke operations on resources
across all services.

Communication is stateless from the service's standpoint and responses
can be cached. A service can understand and process each client request
in isolation. If state is to be maintained between requests, it is the
client's responsibility to do so. Upon delivering a resource representation,
the service specifies for how long the client can cache it.

Intermediary components intercept service requests and responses to
enrich services with non-functional features (e.g. security) and enhance
overall quality of service (e.g. performance). Communicating parties
have no knowledge of intermediaries.

#### Embracing open standards and interoperability
Services have to exchange information in order to perform KITT4SME
workflow tasks. For data to be exchanged and processed meaningfully,
services have to agree on data formats and semantics as well as on a
communication mechanism. The KITT4SME platform adopts open communication
and data standards to foster service interoperability.

As noted earlier grounding service API design on REST principles ensures
a standard, uniform communication mechanism among services and facilitates
the creation of new services by combining existing ones. Furthermore,
KITT4SME embraces the NGSI standard to develop ontologies for IoT data.
Standard data models address the variation in type and nature of IoT
data, providing a homogeneous view of the data which platform services
can process in a uniform fashion.

#### Separation of concerns
The KITT4SME platform mesh implements a network of intermediaries to
transparently route and balance service traffic, secure communication
and access to service resources, and monitor service operation. Additionally,
the platform leverages service intermediaries to enhance performance
and recover from service failures, thus increasing overall service
availability.

These features are implemented within the platform mesh infrastructure
independently of platform services. Therefore service developers are
relieved from the burden of catering to (most of the) operational concerns
and can focus on implementing service-specific features.

#### Multi-tenancy
The same instance of the KITT4SME platform can be shared among different
manufacturing companies. Each company is associated to a security protection
domain, the platform tenant, whereby company data and users are isolated
from other tenant’s data and users. Controlled sharing of users and
data among tenants is still possible if desired, although it has to
be arranged explicitly through security and sharing policies agreed
on by all the involved parties.

Tenants share platform computing resources and infrastructure services
in a controlled way. Computing resources (CPU, memory, storage, network,
etc.) are shared through quotas of the same underlying physical and
virtual computing facility. Additionally, computing resources can be
dynamically reassigned depending on tenant demand. Tenants also share
the same instances of the platform infrastructure services (FIWARE
middleware, backend databases, etc.) but their respective data sets
are siloed in separate databases and/or schemas.

Pooling of computing resources and sharing of infrastructure services
reduces computational and operational costs. Service processing overhead
is spread over many tenants as are hardware and IT operations costs.
Resource allocation among many tenants avoids system under-utilisation,
thus reducing overall service cost per hour. In principle, these cost
savings coupled with the fact that services and computing infrastructure
are paid for on a per-usage basis rather than purchased should make
KITT4SME services affordable even to small manufacturing companies
on a budget.

#### Containerised deployment and orchestration
Service software is packaged along with operating system images which
are then run in the cluster through operating-system level virtualisation.
(The packaged software is often referred to as a "container image" whereas
the term "container" refers to the isolated user space in which the
software is executed.) Each service can be deployed independently of
the others through an automated release process whereby the publishing
of images and deployment instructions in an online repository triggers
the service instantiation in the mesh infrastructure.

#### Decoupled service development
Services are typically developed independently using the most appropriate
technology stack for service implementation. Consequently, different
programming languages, frameworks, databases, etc. may be used to implement
different services. However, most services are expected to provide their
functionality through REST APIs as noted earlier.


### Diagnose and Compose
Having outlined the foundational ideas, we can begin to look at the
key elements of the software infrastructure which support the Diagnose
and Compose steps of the KITT4SME workflow. The following material is
only meant to furnish the reader with a conceptual, bird's eye view
of how the Diagnose and Compose steps relate to the software infrastructure.
Later, more technical sections will fill the gaps. The following informal
diagram shows structure and behaviour at a glance.

![Infrastructure to support the diagnose & compose steps.][dia-comp-infra.dia]

In relation to Diagnose and Compose, there is an integration point with
the RAMP platform to provide a mechanism whereby existing as well as
new AI components can be composed in a working system configuration.
From a very abstract standpoint, the situation can be modelled with a
graph where nodes are components and an edge specifies how two components
can be assembled in a working configuration, that is a tailor-made kit
for a factory. In practice, in correspondence of each kit configuration
that the Diagnose step outputs, there will be a set of deployment descriptors
(e.g. Docker Compose or Kubernetes Helm charts). This set of descriptors
comprise the kit's package of services to be deployed on the cloud
instance running the FIWARE service mesh which provides the communication,
security and persistence backbone as well as an interface to external
IDS services.


### Sense and Intervene
In relation to the Sense phase of the KITT4SME workflow, the platform
is expected to be able to acquire data from the shop floor through a
diverse range of IoT devices and cyber-physical systems such as wearable
devices, environmental sensors, cameras and robots. Data can flow in
the other direction too, i.e. from the platform to the shop floor, as
AI components issue commands to control devices or suggest corrective
actions during the Intervene phase of the KITT4SME workflow.

The following informal diagram shows how the platform supports the
Sense and Intervene steps. As for Diagnose and Compose earlier, the
diagram and the below explanation are only meant to be suggestive of
the actual platform implementation.

![Infrastructure to support the sense & intervene steps.][sen-int-infra.dia]

The platform provides an "information highway" so that data can travel
from the shop floor to the AI brain and from the AI to the factory.
The diagram depicts two fictitious manufacturing companies, aptly called
ManuFracture and Smithereens, whose devices are sending raw measurements
to the system backbone. As data travel along, they are converted and
refined so that AI components and KPI dashboards can process it.
Our thinking here is that the system backbone will be the FIWARE
middleware, and components will exchange data in the NGSI
format using NGSI REST APIs. Thus for example, the `foo` and `bar`
interfaces on which the AI components rely should be REST resources
having an NGSI representation which can be manipulated through NGSI
REST operations.
In the other direction, the Intervene lane, things work similarly.
The diagram shows the AI detecting a `bar` value which is too high
therefore it issues a high-level, human-understandable command to
reset `bar` to an acceptable level. This high-level command is eventually
translated to a command the `foobie` device can understand.

Continuing with the road analogy, road safety is very important too.
Accidents on any highway should be avoided at all costs, which is why
the platform ensures that data can travel safely on the KITT4SME highway.
In fact, depending on the deployment scenario, part or even all of this
communication highway could sit in the cloud. Therefore, it is imperative
to use secure communication channels and encryption where appropriate.
For example, hijacking commands from the cloud to the factory could
have a disastrous impact on a production line. Moreover, the security
infrastructure caters to multi-tenant scenarios as depicted in the diagram
where two different companies share the same cloud stack. The platform
allows to define and enforce security policies to ensure that data
are kept private to their respective owners or shared in ways the owner
can control. Proper authentication and authorisation are in place too
and data exchanges traced. Our plan for security is to rely on open
standards like OAuth2 and OpenID Connect which are fully supported
by FIWARE.




[dia-comp-infra.dia]: ./diagnose-compose.png
[sen-int-infra.dia]: ./sense-intervene.png
