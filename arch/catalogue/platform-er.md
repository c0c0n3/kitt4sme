KITT4SME Platform Exploitation
------------------------------
> ...still a work in progress!


### Description

The KITT4SME platform is a distributed software system designed to
deliver affordable, tailor-made AI at scale to European manufacturing
SMEs.

The platform features a 5-step workflow through which manufacturers
on a budget and no IT expertise can still benefit from AI. The workflow
begins with a "Diagnose" step where a company profile is elicited to
determine business needs and opportunities for improvement. Using this
information, in the "Compose" step, a company-specific, optimal subset
of services is selected from the service marketplace. This tailor-made
service kit is then assembled and deployed to acquire information from
the manufacturer's shop floor. The kit processes that information to
determine whether the shop floor is en route for a desirable or undesirable
outcome---e.g. detect and explain anomalies, visualise key performance
indicators, etc. These activities comprise the "Sense" step. In the
"Intervene" step, the kit suggests and negotiates corrective actions
to steer the shop floor towards the desired production and staff well-being
goals. Finally, in the "Evolve" step, the outcome is analysed to improve
the Diagnose and Compose steps, and to propose personalised staff training.

From a technical standpoint, the platform can be characterised as a
service mesh, multi-tenant, cloud architecture to assemble AI components
from a marketplace into a tailor-made service offering for a factory,
connect them to the shop floor, and enable them to store and exchange
data in an interoperable, secure, privacy-preserving and scalable way.

Both the platform provider and AI developers benefit from this cloud
architecture. Thanks to extensive pooling of computing resources and
sharing of services among tenants, the platform provider can dramatically
reduce operational costs which, in turn, results in lower service cost
for manufacturing SMEs. AI developers leverage the platform compute
infrastructure so they can focus on delivering business value rather
than building infrastructure.

![Technology stack context diagram.][tech-stack.dia]


### Innovation

TODO


### Target market

* European manufacturers
* AI developers developing solutions for the European manufacturing
  industry
* Cloud platform providers

Early adopters

* Manufacturing companies involved in the KITT4SME pilot deployments
* Later on other manufacturers depending on market strategy


### Value proposition

TODO the text below is basically a copy-paste-tweak from
https://github.com/c0c0n3/kitt4sme/blob/master/arch/intro/motivation.md

Artificial Intelligence (AI) has the potential to revolutionise the
shop floor by considerably increasing product quality, for example
by detecting and correcting any anomalies. AI can optimise the reconfiguration
of a production line, potentially paving the way to lot size one production.
Furthermore, AI can even improve staff productivity by suggesting fatigue
and stress relief measures as well as personalised training.

The better the factory does in these areas the more profitable the
company can potentially be. Small and medium-sized enterprises (SMEs)
constitute the backbone of the European economy, thus the more profitable
SMEs become, the stronger the European economy becomes too. Nevertheless,
despite the potential benefits, very few SMEs have implemented AI solutions
in their factories. What is preventing them from jumping on the AI
bandwagon? As it turns out, mostly low budgets and lack of expertise.
The KITT4SME platform aims to smash down these adoption barriers by
offering SMEs affordable, tailor-made AI for quality, reconfiguration
and human-robot interaction (HRI) through a marketplace and an adoption
support network.


### Progress

MVP released, working towards pilot deployments. Some additional
infrastructure required to support open calls.

Technology readiness level:

* Initial: 3 (experimental proof of concept)
* Current: 4 (technology validated in lab)
* Expected: 7 (system prototype demonstration in operational environment)




[tech-stack.dia]: https://raw.githubusercontent.com/c0c0n3/kitt4sme.live/main/docs/tech-stack.svg
