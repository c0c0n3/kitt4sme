About
-----
> Odds & ends.

TODO find better heading!

This section outlines the scope of this document, the approach followed
to write it and its intended audience.


### Scope

It is common practice for architecture documents to model viewpoints
and concerns of various stakeholders. On the other hand, this document
is much narrower in scope in that it only considers the technical aspects
of the platform from a developer standpoint with the aim of offering
enough guidance for an initial platform implementation. In this regard,
the design effort has focused on modelling the software infrastructure
required to support the KITT4SME workflow and the operation of the
various AI modules which will be available in the KITT4SME marketplace.
In somewhat more detail, the main objectives are to describe

* how to assemble AI modules from the marketplace into a tailor-made
  service offering for an SME (Diagnose/Compose workflow phases);
* how to connect them to the shop floor (Sense/Intervene workflow phases);
* how to enable them to store and exchange data in an interoperable,
  secure, privacy-preserving and scalable way. (Sense/Intervene)

It should be noted that the proposal originally submitted to fund the
KITT4SME project envisioned an architecture revolving around the integration
of the RAMP platform to provide marketplace functionality and the adoption
of the FIWARE platform as a system backbone. Consequently, the design
effort has concentrated on developing these ideas further in order to
obtain an architecture in line with the proposal. Although the investigation
and evaluation of alternative technologies could have been beneficial,
this was not part of the proposed project plan, hence it is not within
the scope of this document.

As hinted at earlier, we do recognise that the scope of this document
should be broader. However, this is just the initial version of the
document. Our plan is to maintain a living architecture document which
will be updated as the architecture is refined in response to feedback
from the various implementation tasks.


### Methodology

We have been following an iterative approach to designing and documenting
the platform architecture. Work has proceeded at a steady pace through
subsequent, two-week iterations. During each iteration, requirements were
analysed and design ideas were put to the test by developing a platform
prototype. Feedback from implementation tasks allowed to refine the platform
design and informed the design decisions of the next iteration. Regular
reviews were held at the end of each iteration where the team would
demonstrate a working prototype to validate the design.

Purely from a software standpoint, one of the defining characteristics
of KITT4SME is the integration of existing AI components and software
stacks into a homogeneous platform. As a matter of fact, it is remarkably
difficult to anticipate issues that might arise when attempting to make
heterogeneous components work together, especially when there are many
components to integrate as is the case with KITT4SME. In this situation,
upfront, speculative platform design may incur the risk of delivering
a brittle architecture which could hamper integration rather than facilitate
it. To mitigate this risk, we have been following an experimentation-driven
approach and have built, as already mentioned, a platform prototype to
test some integration scenarios which we deem representative of real-world
use cases. Moreover, by building working software we have been able to
test out our ideas about high-level design and cloud design principles,
APIs for exchanging information among services, persistence, data access
and interoperability, security, and guidelines for a platform reference
implementation.


### Audience
Techies.
TODO mention it's not a good idea to wade through this doc if you're
a cloud computing noobie. E.g.

The content presented in this document is intended for a technical
audience, primarily platform developers. We assume the reader is well
versed in distributed systems and cloud computing. Also assumed is
general knowledge of identity and access management systems as well
as the rudiments of symmetric/asymmetric cryptography and digital
signatures. Moreover, the reader should be familiar with the following
technologies: HTTP, TLS, OAuth 2, JWT, Docker, Kubernetes, Istio, ...
TODO what else?
