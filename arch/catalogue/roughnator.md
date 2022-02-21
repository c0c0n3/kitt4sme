Roughnator
--------------------

**NOTE**. The content below was contributed by CSIC, copy-pasted from
the original document.


Raughnator is a module to stimate the roughness surfaces of
manufacturing parts in milling process.

### High-level functionality 

* Roughnator is a service to estimate the surface roughness in a milling process 
  of 170 x 100 x 25 aluminium AL7075-T6 (UNS A97075) work pieces
  being processed by Maho DMC 75 V machine center. It receives raw measurements
  from the milling machine and uses a machine learning model to predict
  the quality of the parts being worked on.


### Role in the architecture

* Roughnator is a KITT4SME platform application service for test the integration 
  of KITT4SME platform. It is a REST service that acquires data from the shop floor 
  (GAMHE 5.0 Pilot line)through the platform publish/subscribe middleware—FIWARE 
  Context Broker. Also the module could be used with data available at:
  [roughnator.data]
  It also produces data that makes available as NGSI entities in the
  platform IoT context for other services to consume. It relies on
  the underlying mesh infrastructure for security, scalability and
  automated deployment. Roughnator is available to SMEs through the
  RAMP marketplace.
* The following diagram puts Roughnator into the context of the KITT4SME
  platform. Rougnator was deployed as a demo component into the platform 
  to test the intregation of remote facilities into the platform.

![Roughnator context diagram][roughnator.dia]


### Requirements

* Roughnator is part of the GAMHE 5.0 lighthouse demostrator

### Improvements

* Roughnator is avialable as one of the functionalitythe of KITT4SME platfom in 
  GAMHE 5.0 lighthouse demostrator. This has required the development of a new
  service to embed existing GAMHE 5.0 software modules in KITT4SME.

### Value proposition

* Roughnator proves the concept that helps manufacturing SMEs who want to 
  produce high quality parts by reducing the number of items to be reworked or 
  scrapped and enabling in-process product quality assessment. Unlike traditional
  quality control performed at the end of the manufacturing process,
  in-process quality control can help detect defects early which has
  the potential to increase business profitability and market competitiveness.
  The KITT4SME consortium has already released an early version of
  Roughnator as open-source software at to test the integration of the KITT4SME platform:
  https://github.com/c0c0n3/kitt4sme.roughnator with the data plublished on: [roughnator.data]


[roughnator]: https://github.com/c0c0n3/kitt4sme.roughnator
[roughnator.dia]: ./roughnator.svg
[roughnator.data]: https://zenodo.org/record/1080135#.YhNx_5aCGUk
