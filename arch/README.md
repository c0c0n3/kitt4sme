Reference Architecture
----------------------
> A technical map of the software.

This document describes (only) the technical aspects of the KITT4SME
architecture through a set of interlocked architectural viewpoints.
As such, it is only aimed at developers who need to understand the
big picture before modifying the architecture or extending the code
with new functionality. [Read the executive summary][abstract].


### Document status

**WIP!!**

* See: https://github.com/c0c0n3/kitt4sme/projects/1
* Partner contribs wanted!


### Table of contents

1. [Introduction][intro]. The basic ideas are summarised here and then
   further developed in subsequent sections.
    - [Project background][into.motivation]. Motivation and value proposition,
      or why we're doing this.
    - [KITT4SME workflow][intro.workflow]. Delivering AI to the manufacturing
      industry through the famed KITT4SME workflow :-)
    - [Platform concept][intro.platform]. Lunar-orbit, conceptual view of
      how we're thinking of supporting the KITT4SME workflow in software.
      (Notice there's more to the KITT4SME workflow than just software, but
      here we're only focusing on software.)
    - [About this document][intro.about]. Scope of this document, the approach
      followed to write it and its intended audience.
    - [Document overview][intro.overview].
2. [Platform requirements][view.req]. An account of functional requirements
   and system quality attributes which shape the architecture.
3. [System decomposition][view.conceptual]. Subsystems and components,
   modularity.
4. [Information model][view.data]. What information the system handles and
   how it is represented and processed, with an emphasis on interoperability.
5. [Interaction mechanics][view.ipc]. Distributed communication protocols and
   synchronisation, message routing and manipulation.
    - [RESTful services][view.rest].
    - [NGSI services][view.ngsi-svc].
    - [Pub/sub and IoT context propagation][view.pub-sub].
    - [Mesh & traffic management][view.interception].
6. **Persistence**.
    - [Time series][view.times-series]. How to take advantage of NGSI pub/sub
      to implement IoT time-series services.
    - ...
7. **Security**.
    - Istio & OPA (~> document prototype's code)
    - IdM (Keycloak?)
    - ...
8. **Performance**.
    - scalability
    - HA
    - ...
9. [Deployment and operation][view.deploy]. Platform deployment and operation.
    - [Cloud instance][view.crt]. Software placement & execution on a
      cluster, including the instantiation of platform services within
      the computing infrastructure.
    - [IoT provisioning][view.provisioning]. Connecting the shop floor
      IoT environment to the running platform instance.
    - [Continuous integration and GitOps][view.ci]. Continuous delivery
      of platform functionality through an infrastructure-as-code (IaC)
      approach.
10. Marketplace.
    - [Diagnose, compose, and RAMP][wiki.dcr]
11. Quality assurance.
12. **Architecture validation**. Verifying we've designed a viable solution
   especially w/r/t pilots & open calls.
    - [Platform prototype][proto]. Demo cluster we've built to test out our
      ideas and try out scenarios to validate the architecture.
    - [Scenarios][scenarios]. A sketch of the scenarios we think are
      representative of how the platform will be used and how we tested
      them with the prototype.
13. [Conclusion][conclusion].
14. Appendix: [Software catalogue][catalogue]. Overview of the software
    KITT4SME partners are integrating into the platform, role in the
    architecture, purpose and value proposition.


### Notes

If we flesh out all those sections above we'll definitely wind up with
more content than we're expected to deliver, IMHO. Well at least if we
get judged by what we promised to deliver in the Dead on Arrival (DoA).
In fact, this is what's in the DoA

* consider WP1 requirements
* build on proposed arch sketch
* integration of partners' software
* guidelines for ref implementation
* APIs to access/exchange data
* CI of platform components




[abstract]: ./abstract.md
[catalogue]: ./catalogue/README.md
[conclusion]: ./conclusion.md
[intro]: ./intro/README.md
[intro.about]: ./intro/about.md
[into.motivation]: ./intro/motivation.md
[intro.overview]: ./intro/overview.md
[intro.platform]: ./intro/platform.md
[intro.workflow]: ./intro/workflow.md
[proto]: ../poc/README.md
[scenarios]: ./scenarios.md
[view.ci]: ./mesh/gitops.md
[view.crt]: ./mesh/cloud.md
[view.conceptual]: ./conceptual-view/system-decomposition.md
[view.data]: ./fw-middleware/data.md
[view.deploy]: ./deploy.md
[view.interception]: ./mesh/interception.md
[view.ipc]: ./ipc.md
[view.ngsi-svc]: ./fw-middleware/ngsi-services.md
[view.provisioning]: ./fw-middleware/provisioning.md
[view.pub-sub]: ./fw-middleware/ctx-change-propagation.md
[view.req]: ./requirements.md
[view.rest]: ./rest.md
[view.times-series]: ./fw-middleware/time-series.md
[wiki.dcr]: https://github.com/c0c0n3/kitt4sme/wiki/Diagnose,-compose,-and-RAMP
