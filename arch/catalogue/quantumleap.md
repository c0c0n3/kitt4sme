QuantumLeap
-----------

QuantumLeap is a REST service for storing and querying spatial-temporal
IoT data.


### High-level functionality 

QuantumLeap is a core IoT context management component of the FIWARE
platform. It tracks changes to the IoT context to build a history of
context changes which then makes available to query over space and
time through a REST API. KITT4SME leverages QuantumLeap's ability to
track time varying measurements in the IoT context to provide AI and
dashboard services with time series of shop floor measurements.


### Role in the architecture

QuantumLeap is a KITT4SME platform infrastructure service and core
component of the KITT4SME FIWARE software stack. It is a REST service
that subscribes to Context Broker to get notified of NGSI entity changes,
converts notified entities to tabular format, and stores them in a time
series and geo-spatial database. Typically these entities carry raw
measurements acquired from the shop floor or data produced by AI
services—e.g. a surface roughness forecast for parts being worked on
by a milling machine. QuantumLeap allows KITT4SME application services
to easily query time series through well-known NGSI query syntax. The
following diagram shows the role QuantumLeap plays in building and
making time series available to application services—AI, dashboards,
etc.

![QuantumLeap context diagram][ql.dia]

QuantumLeap relies on the underlying KITT4SME mesh infrastructure for
security, scalability and automated deployment. As an infrastructure
service, its role is to support the operation of application services,
so unlike application services it is not available in the RAMP marketplace.


### Requirements

The following key KITT4SME requirements justify the adoption of QuantumLeap:

- **Time series**. Ability to generate time series from shop floor
  data and make them available to AI and other analytics services
  as well as KPI dashboards.
- **Interoperability**. Uniform access to data through standard protocols
  and information models. QuantumLeap communicates over HTTP, exposes a
  REST API and adheres to the NGSI specifications.
- **FIWARE integration**. The DoA committed to a FIWARE-based IoT platform.
  QuantumLeap is a FIWARE core component.


### Improvements

QuantumLeap enables the KITT4SME platform to build time series out of
IoT context changes. The platform information model caters for both
NGSI v2 and LD IoT contexts. Consequently, QuantumLeap has been extended
to support NGSI-LD while retaining backward compatibility with the
more widespread NGSI v2 model. To be able to process context changes
at scale, reliability and performance of data ingestion and time series
generation have been improved. Finally, as QuantumLeap is a key component
of the FIWARE stack within KITT4SME, the software has undergone several
stabilisation cycles entailing countless bug fixes and enhancements
to ensure fitness for purpose. This work has been carried out in WP
2 as part of the FIWARE middleware task.


### Value proposition 

AI services, analytics and KPI dashboards often need to process time
series in order to produce valuable business insights. In this regard,
although QuantumLeap provides no direct business value to KITT4SME
end-users, it is a key component of the platform infrastructure that
enables the operation of application services providing actual business
value.

Unlike ad-hoc data pipelines, QuantumLeap ensures uniform access to
data thanks to the adoption of time-tested IoT standards which dramatically
reduces the effort required to integrate AI services and KPI dashboards
into KITT4SME. Moreover, QuantumLeap is open-source software that can
be used free of charge. Its source code is hosted at:
https://github.com/orchestracities/ngsi-timeseries-api.




[ql.dia]: ./quantumleap.svg

