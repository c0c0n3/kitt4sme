Conclusion
----------
> That's all folks!


### Addressing the requirements

TODO Rehash how the architecture tackles requirements & meets challenges

* sharing, open source ⟶ affordable
* NGSI ⟶ interop
* RAMP ⟶ marketplace
* Istio/OPA/.. ⟶ security
* K8s/Istio/.. ⟶ scalability
* ...and so on

TODO mention major design decisions, rationale & trade-offs

AI has the potential to increase the profitability of manufacturing
SMEs by improving product quality, optimising production line configuration
and levelling up staff productivity. KITT4SME intends to deliver affordable,
tailor-made AI kits to the manufacturing industry through an especially
designed workflow. This document has shown how a cloud platform can
be built to support the KITT4SME workflow by combining FIWARE with
the RAMP platform.

Specifically, section 9 showed how to assemble AI components from the
RAMP marketplace into a tailor-made service offering for a factory and
how to connect them to the shop floor, whereas sections 3 through 8
showed how to enable them to store and exchange data in an interoperable,
secure, privacy-preserving and scalable way. Section 10 highlighted
the tools that the RAMP platform makes available to solution providers
to deliver their services and support to manufacturers, conveying how
KITT4SME and RAMP complement each other.

The architecture has been designed taking into account the requirements
elicited by the user journey, security and AI tasks performed in WP1.
In particular, section 7 detailed how the architecture accommodates
security requirements whereas section 9 handled user requirements with
respect to the Compose and Diagnose phases of the KITT4SME workflow.
The other parts of this document concentrated on the infrastructure
required to support the Sense and Intervene phases of the workflow
and hence the operation of AI kits. Moreover, through multi-tenancy
and resource sharing as well as open-source software, the architecture
caters for the project goal of making AI services affordable even to
small manufacturing companies on a budget.


### Validation

The architecture has been validated through regular design reviews
and by developing a platform prototype. Reviewers have found the
architecture to be in line both with the project goals and with the
functional decomposition originally proposed in the Description of
Action. Moreover, the platform prototype provides empirical evidence
that the architecture can accommodate the requirements gathered by
WP1 as well as the integration of software previously developed by
consortium members.

The prototype software is publicly available in the KITT4SME online
repository along with installation instructions and software documentation.
Together with the architecture document, the prototype aims to offer
sufficient guidance for an initial platform implementation. Additionally
it should appeal to AI developers and open call applicants alike in
that they can learn about the platform through direct experimentation
with working software.


### Next steps

The present document has a companion living architecture document which
is publicly available in the KITT4SME online repository. The online
version of the document will be updated to reflect future technical
decisions as the architecture is refined in response to implementation
tasks. Moreover, the online document will guide the implementation of
deliverable D2.5 "Powered-by FIWARE middleware for AI".

It should also be noted that WP2 will release further, in-depth documentation
regarding some of the key aspects of the KITT4SME platform which the
present document has only outlined. Specifically, D2.2 (data models)
will delve into persistence, the design of NGSI data models for the
manufacturing industry, and semantic data interoperability of platform
components. D2.4 (security design) will provide comprehensive guidance
and blueprints to implement IdM, mesh security and secure communication
channels for platform services. Finally, D2.7 (deployment manual) will
detail the packaging of platform services, their deployment and other
relevant operational aspects such as continuous integration of platform
components, including software to be employed for the planned platform
pilot deployments.
