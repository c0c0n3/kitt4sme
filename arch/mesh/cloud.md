Cloud instance
--------------
> Head in the clouds.

The KITT4SME software platform is a service mesh, multi-tenant, cloud
architecture which relies on a dedicated cluster software infrastructure
to deploy and run its services. This section outlines the placement of
software components on a cluster to form a running platform instance
and shows how this arrangement supports the Diagnose and Compose steps
of the KITT4SME workflow.


### Platform runtime

A platform instance can be thought of as comprising several layers of
processes and hardware. From the bottom up, these layers are:

* Hardware layer. The cluster hardware (computers, network) on which
  all the platform software runs forms the bottom layer. This could
  be either physical or virtualised hardware depending on the deployment
  scenario, e.g. the platform could be deployed on virtual computing
  resources rented from a cloud provider.
* Cluster orchestration. A set of processes that manage the computational
  resources (CPU, memory, storage) provided by the hardware layer and
  allocate them to processes in the upper layers. This layer orchestrates
  the deployment and operation of services by means of "containers":
  service software is packaged along with operating system images which
  are then run in the cluster through operating-system level virtualisation.
  (The packaged software is often referred to as a "container image" whereas
  the term "container" refers to the isolated user space in which the
  software is executed.) The cluster orchestration layer also provides
  a uniform, programmable interface to computational resources across
  cluster nodes.
* Control plane. Processes that manage a network of proxies to transparently
  route and balance service traffic, secure communication and access
  to service resources, and monitor service operation as explained in
  the [service mesh section][view.interception].
* Data plane. The proxies along with the interconnection network required
  to capture and process application traffic destined for or originating
  from services. Please refer to the [service mesh section][view.interception]
  for a detailed explanation.
* Platform infrastructure services. Processes that support the operation
  of application services, e.g. the services in the FIWARE middleware,
  database processes, machine learning frameworks, etc.
* Platform application services. The services that are an integral
  part of the KITT4SME workflow, e.g. an anomaly detection service,
  a KPI dashboard, etc.

The following diagram depicts a KITT4SME cloud instance connected to
two factories and linked to the RAMP marketplace.

![KITT4SME cloud instance.][dia.crt]

Application services typically depend on platform infrastructure services
to support their operation. Some infrastructure services may also depend
on other infrastructure services (e.g. a time series service would need
a context broker to collect data) but infrastructure services have no
knowledge of application services. The dashed arrows among platform
services in the diagram hint at this fact. Similarly, platform services
are independent of the processes in the layers below in that they provide
their functionality independently of those processes and can function
without them.

Collectively the cluster orchestration, data and control plane constitute
a software stack which has been referred to as "mesh infrastructure"
in earlier parts of this document. [Kubernetes][k8s] and [Istio][istio]
are the preferred software to implement the mesh infrastructure, although
similar products may be considered. However, it should be noted that
several cloud providers offer Kubernetes and Istio as managed services.
Thus, not only can hardware be rented from a cloud provider to run a
KITT4SME platform instance, but also, and more importantly, the entire
mesh infrastructure too. Renting both hardware and mesh infrastructure
could dramatically reduce operating costs which, in turn, would make
platform services more affordable. Moreover, relying on managed hardware
and mesh infrastructure can definitely simply the platform implementation
and maintenance tasks during the course of the KITT4SME project.


### Relation to Diagnose / Compose

The KITT4SME user journey envisages a guided path through which a factory
owner acquires an AI service kit to improve their production processes.
Initially the platform interacts with the user to select a kit suitable
to the user's needs (Diagnose phase) and then delivers the corresponding
AI services (Compose phase). In somewhat more detail,

1. The platform asks a business owner questions about their factory
   in order to assemble a company profile with their needs and opportunities
   for improvement.
2. The platform processes that profile to determine which AI kits the
   factory could use. There are some measures of "suitability to business
   goals" that are used to grade kits, e.g. grade by cost, accuracy, etc.
3. The platform presents the business owner with the candidate kits
   and their grades. Typically there are trade-offs between kits, e.g.
   one kit is more economical but less accurate than another.
4. The business owner consults with a platform expert to analyse trade-offs
   and then selects a kit.
5. The business owner places an order for that kit.
6. After successfully processing the order, the platform assembles the
   deployment instructions for the services that comprise the kit.
7. The services are deployed to the platform and connected to the
   factory.

KITT4SME and RAMP software support the above workflow as follows. The
Adaptive Questionnaire, one of the stock KITT4SME application services
running within the platform instance, drives step (1), whereas another
(yet-to-be-developed) stock service, the Platform Configurator, is responsible
for (2) and (3). RAMP provides the functionality to perform step (5)
whereas (6) requires an interaction with an online software repository
paired with the KITT4SME platform instance as shown in the above diagram
by a dashed arrow from the RAMP marketplace to the repository. This
repository contains service deployment instructions (e.g. Kubernetes
object descriptors, Helm charts) and is monitored by an Infrastructure-as-Code
(IaC) operator (e.g. [Argo CD][argocd]) within the platform instance.
As soon as the deployment instructions for a kit are uploaded to the
repository, the IaC operator detects that a new kit is to be instantiated
in the cluster and requests the cluster orchestration processes to
perform the deployment according to the given instructions. At this
point, all that remains to do to complete step 7 is to connect the
factory's IoT environment to the live service kit. The next two sections
detail, respectively, how to connect IoT devices to the platform instance
and the IaC workflow through which kits are deployed.

As shown in the diagram, different manufacturing companies can utilise
the same platform instance. Each company is serviced by its own AI kit,
but all the kits share the same computing resources, mesh infrastructure
and platform infrastructure services. Computing resources (CPU, memory,
storage, network, etc.) are shared through quotas of the same virtual
computing facility provided by the cluster orchestration layer. Each
company's data and users are isolated from any other company's data
and users by means of separate protection domains. An identity and
access control solution (IdM) such as [Keycloak][keycloak] allows
the platform administrator to create and manage a protection domain
(tenant) for each company. IdM, combined with the secure channels and
policy enforcement facilities provided by the mesh infrastructure,
affords the necessary protection of each tenant's own data both while
in transit and at rest.




[argocd]: https://argoproj.github.io/projects/argo-cd
[dia.crt]: ./cloud-instance.png
[istio]: https://istio.io/
[keycloak]: https://www.keycloak.org/
[k8s]: https://kubernetes.io/
[view.interception]: ../mesh/interception.md
