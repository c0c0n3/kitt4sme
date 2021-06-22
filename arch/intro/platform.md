Cloud platform
--------------
> Supporting the Kitt4Sme workflow.

So where does all this leave us? Well, we could say that the main
goal of the reference architecture is to define the software infrastructure
to support the Kitt4Sme workflow and AI modules. But this is a bit
of a vague, catch-all statement, so we should put flesh on the bones
of it.

### Guiding principles
The basic idea is that of a service mesh, multi-tenant, cloud architecture
to assemble AI components from a marketplace into a tailor-made service
offering for a factory, connect these components to the shop floor,
and enables them to store and exchange data in an interoperable, secure,
privacy-preserving and scalable way. The platform design revolves around
the key concepts and principles outlined below.

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

#### Interaction mechanics
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
savings should make KITT4SME services affordable even to small manufacturing
companies on a budget.

#### Open standards and interoperability
TODO

### Deployment
TODO
* containerisation, services get packaged in container images and
  these images are made available in a repository accessible from
  the platform.
* IaC
* Continuous delivery / DevOps

#### Service development
Services are typically developed independently using the most appropriate
technology stack for service implementation. Consequently, different
programming languages, frameworks, databases, etc. may be used to implement
different services. However, most services are expected to provide their
functionality through REST APIs as noted earlier.


### Diagnose/Compose
Let's start with a quick look at the key elements of the software
infrastructure that was proposed to support the Kitt4Sme Diagnose
and Compose steps. Keep in mind this is very high level, like looking
at it from the moon kind of thing and later on, the technical sections
will fill the gaps. Here's what it looks like at a glance.

![Infrastructure to support the diagnose & compose steps.][dia-comp-infra.dia]

In relation to diagnose & compose, we have an integration point with
the RAMP platform to provide a mechanism whereby existing as well as
new AI modules can be composed in a working system configuration.
From a very abstract standpoint we've got a graph where nodes are
components and an edge tells you how two components can be assembled
in a working configuration, that is a tailor-made kit for an SME. In
practice, in correspondence of each kit config that the diagnose step
spits out, there will be a set of deployment descriptors (think Docker
Compose or K8s Helm charts) that make up that kit's package of services
to be deployed on the cloud instance running the FIWARE service mesh
which provides the communication, security and persistence backbone
as well as an interface to external IDS services.

**TODO** challenges


### Sense/Intervene
With diagnose & compose under our belt, let's see what it takes
to support the sense and intervene steps. Again, here's the lunar-orbit
picture.

![Infrastructure to support the sense & intervene steps.][sen-int-infra.dia]

Our job here is to build an information highway so data can travel
from the shop floor to the AI brain and from the AI to the factory.
In the diagram, we see two companies, aptly called ManuFracture
and Smithereens, whose devices are pumping raw measurements into
the system backbone. As data travels along, it gets converted
and refined so AI modules and KPI dashboards can process it.
Our thinking here is that the system backbone will be the FIWARE
middleware, and components will exchange data in the NGSI-LD
format using NGSI REST APIs. So for example, the `foo` and `bar`
interfaces the AI piggybacks on in the diagram should be REST
resources having an NGSI-LD representation you can manipulate
through NGSI REST operations.
In the other direction, the intervene lane, things work pretty
much the same. Yah, like same same but different, you know. The
diagram shows the AI sniffing out a `bar` value that's too high
so it issues a high-level, human-understandable command to reset
bar to a decent value which eventually gets translated to a command
the foobie device can understand.

Surely road safety is very important too. Nobody wants to get
into a nasty accident on a highway which is why we'll have to
make sure data can travel safely on our highway. In fact, depending
on the deployment scenario, part or even all of this communication
highway could sit in the cloud, so it's very important to use secure
communication channels and encryption where appropriate. For example,
hijacking commands from the cloud to the factory could have a disastrous
impact on the production line. Also the security infrastructure will have
to cater to multi-tenant scenarios like we see here with two
different companies sharing the same cloud stack, making sure
data is kept private to their respective owners or shared in
ways the owner can control. Proper authentication & authorisation
will have to be in place and data exchanges traced. Our plan
for security is to rely on open standards like OAuth2 and OpenID
Connect which are fully supported by FIWARE.




[dia-comp-infra.dia]: ./diagnose-compose.png
[sen-int-infra.dia]: ./sense-intervene.png
