My Awesome Component
--------------------
^ replace with product name


My Awesome Component (MAC) is a software to [say what it does in a
short sentence or snappy catchphrase].

Example:

* [Roughnator][roughnator] estimates surface roughness of
  manufacturing parts.


### High-level functionality 

* Short description of the software.
* Purpose in KITT4SME.
* Focus on functionality, not the technical wiring within the platform.
* Don't copy-paste from the DoA.

Example:

* Roughnator is a service to estimate the surface roughness of items
  being processed by a milling machine. It receives raw measurements
  from the milling machine and uses a machine learning model to predict
  the quality of the parts being worked on. Since it can do this in
  near real time, it enables the KITT4SME platform to offer manufacturing
  SMEs a service to implement in-process quality assessment and machine
  reconfiguration.


### Role in the architecture

* Where does this component fit in the KITT4SME architecture?
  (E.g. platform app service.)
* How does it integrate in the architecture? (E.g. through pub/sub.)
* Deployment. How's the component deployed? Is it a cloud service
  or an on-prem component? How to secure communication?
* Add a diagram to guide the reader if possible.

Example:

* Roughnator is a KITT4SME platform application service. It is a
  REST service that acquires data from the shop floor through the
  platform publish/subscribe middleware—FIWARE Context Broker. It
  also produces data that makes available as NGSI entities in the
  platform IoT context for other services to consume. It relies on
  the underlying mesh infrastructure for security, scalability and
  automated deployment. Roughnator is available to SMEs through the
  RAMP marketplace.
* The following diagram puts Roughnator into the context of the KITT4SME
  platform. As a platform application service, Roughnator is available
  in the RAMP marketplace. An SME can deploy the service from there and
  then connect their machines to the KITT4SME platform to have Roughnator
  produce roughness estimates as the machines work on a production batch.
  As raw measurements come in from the shop floor the platform middleware
  refines them into NGSI entities and passes these entities on to the
  Roughnator service. On receiving an NGSI entity, Roughnator feeds it
  into its machine learning model to produce a roughness forecast which
  it writes to the IoT context. The platform infrastructure tracks changes
  to the IoT context to produce time series which are ultimately displayed
  in a RAMP dashboard an SME operator has access to. Through the dashboard,
  the operator can easily gauge product quality and possibly intervene to
  reconfigure their production process.

![Roughnator context diagram][roughnator.dia]


### Requirements

* Map KITT4SME requirements to the functionality provided by this
  component.
* Focus on how this is going to help SMEs make the most out of the
  platform.
* Reference the user journey if possible.


### Improvements

* What improvements have been made to make the software fulfill its
  role in the platform?
* What resources have been used?

Example:

* Roughnator makes some of the GAMHE 5.0 functionality available as
  a KITT4SME service. This has required the development of a new
  service to embed existing GAMHE 5.0 software modules in KITT4SME.
  The work has been carried out in WP 2 (interface to the mesh
  infrastructure and FIWARE middleware) and WP 4 (machine learning
  model, NGSI data models).


### Value proposition

* Why is this development valuable within KITT4SME?
* Focus on how the component helps the platform reach its stated
  objectives and goals. (Here's an [overview][arch.vp] of the KITT4SME
  value proposition, read up about the details in the DoA.)
* How does it improve the state of the art?
* If applicable, mention the software is open-source and it's
  already been released publicly.

You can use this template if you like—adapted from Strategyzer's
[value proposition template][vp.template].

> [Component] helps manufacturing SMEs that want to [jobs to be done]
> by [e.g. reducing, avoiding] [an SME pain]
> and [e.g. increasing, enabling] [an SME gain].
> Unlike [competing value proposition].

Example:

* Roughnator helps manufacturing SMEs that want to produce high quality
  parts by reducing the number of items to be reworked or scrapped and
  enabling in-process product quality assessment. Unlike traditional
  quality control performed at the end of the manufacturing process,
  in-process quality control can help detect defects early which has
  the potential to increase business profitability and market competitiveness.
  The KITT4SME consortium has already released an early version of
  Roughnator as open-source software at:
  https://github.com/c0c0n3/kitt4sme.roughnator




[arch.vp]: https://github.com/c0c0n3/kitt4sme/blob/master/arch/intro/motivation.md
[roughnator]: https://github.com/c0c0n3/kitt4sme.roughnator
[roughnator.dia]: ./roughnator.svg
[vp.template]: https://static1.squarespace.com/static/5abb0c805b409b8d0da49ce5/t/5caecdffe2c483abeaf49a14/1554959871097/Ad+Lib+Value+Template.pdf
