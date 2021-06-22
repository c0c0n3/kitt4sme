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

* Diagrams sum up discussions and design decisions so far but need
  narrative. Also, we should probably convert them to vector graphics
  for publication.
* Existing prose needs to be massaged into formal style before publication.
  Exceptions: [about section][intro.about], [info model][view.data],
  [pub/sub][view.pub-sub] and [CI/GitOps][view.ci] sections got rewritten
  in formal style.
* Partner contribs wanted!


### Table of contents

1. **Introduction**. The basic ideas are summarised here and then further
   developed in subsequent sections.
    - [Project background][into.motivation]. Motivation and value proposition,
      or why we're doing this.
    - [KITT4SME workflow][intro.workflow]. Delivering AI to the manufacturing
      industry through the famed KITT4SME workflow :-)
    - [Platform concept][intro.platform]. Lunar-orbit, non-technical view of
      how we're thinking of supporting the KITT4SME workflow in software.
      (Notice there's more to the KITT4SME workflow than just software, but
      here we're only focusing on software.)
    - [About this document][intro.about]. Scope of this document, the approach
      followed to write it and its intended audience.
    - [Document overview][intro.overview].
2. [System requirements][view.req]. An account of functional requirements
   and system quality attributes which shape the architecture.
3. [System decomposition][view.conceptual]. Subsystems and components,
   modularity.
4. [Information model][view.data]. What information the system handles and
   how it is represented and processed, with an emphasis on interoperability.
5. **Message passing mechanics**. Distributed communication protocols and
   synchronisation, message routing and manipulation.
    - NGSI REST services.
    - [Pub/sub and IoT context propagation][view.pub-sub].
    - mesh & traffic management.
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
9. Deployment and operation.
    - service mesh
    - [IoT provisioning][view.provisioning].
    - [Continuous integration and GitOps][view.ci]. Btw, this is also how
      we can support Diagnose/Compose.
    - Observability.
10. Marketplace.
11. Quality assurance.
12. **Architecture validation**. Verifying we've designed a viable solution
   especially w/r/t pilots & open calls.
    - [Platform prototype][proto]. Demo cluster we've built to test out our
      ideas and try out scenarios to validate the architecture.
    - [Scenarios][scenarios]. A sketch of the scenarios we think are
      representative of how the platform will be used and how we tested
      them with the prototype.
13. [Conclusion][conclusion].


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
[conclusion]: ./conclusion.md
[intro.about]: ./intro/about.md
[into.motivation]: ./intro/motivation.md
[intro.overview]: ./intro/overview.md
[intro.platform]: ./intro/platform.md
[intro.workflow]: ./intro/workflow.md
[proto]: ../poc/README.md
[scenarios]: ./scenarios.md
[view.ci]: ./mesh/gitops.md
[view.conceptual]: ./conceptual-view/system-decomposition.md
[view.data]: ./fw-middleware/data.md
[view.provisioning]: ./fw-middleware/provisioning.md
[view.pub-sub]: ./fw-middleware/ctx-change-propagation.md
[view.req]: ./requirements.md
[view.times-series]: ./fw-middleware/time-series.md
