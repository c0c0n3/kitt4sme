Shop floor reconfigurator (SFR)
--------------------

* Shop floor reconfigurator is a service to generate smart recomendations and conduct
  physical reconfiguration, if the shop floor components allows  it. The component receives 
  raw measurements from shop floor related with production times and condition
  of the assets. These information is processed by machine learning and fuzzy models to 
  generate smart recomendations and to enable physical reconfiguration. Since it can be done in
  near real time, it enables  KITT4SME platform to offer manufacturing
  SMEs a service to implement in-process reconfiguration.


### Role in the architecture

* Shop floor reconfigurator is a KITT4SME platform application service. 
  It is a REST service that acquires data from the shop floor and from 
  other components of KITT4SME through the platform publish/subscribe
  middleware—FIWARE Context Broker It also produces data   
  available as NGSI entities in the platform IoT context for other services 
  to consume. It relies on the underlying mesh infrastructure for security,
  scalability and automated deployment. 

* SHF can be deployed as a service allocated into the KITT4SME
  cloud. Raw measurements come from the shop floor the platform 
  middleware refines them into NGSI entities and passes these entities on 
  to SHF service together with the outputs of other KITT4SME modules related 
  to condition monitoring and productivity. Once receiving an NGSI entity, 
  the machine learning and fuzzy models process the data and produce decision-making for
  smart recomendations and physical reconfigurations, which are written in the 
  IoT context. The platform infrastructure sends these outputs to the IoT devices
  in the shop floor, for physical reconfiguration and also to a RAMP dashboard. 
  Through the dashboard, the operator/technologist read the smart recomendations and can take 
  or not corresponding.

![Roughnator context diagram][roughnator.dia]


### Requirements

* Shop floor reconfigurator provides the functionalities to generate smart 
  recomendations and physical reconfiguration as a KITT4SME service. The smart 
  recomendations and the automatic reconfiguration will be focus on increase the 
  productivity, avoid bottlenecks and assets critical failures. It is important  
  highlight that the components has some importants constraints including the 
  minimum number of machines/devices (>4). The first is related to the measurement 
  of inputs. To use SHF is important to to meet the following requirements: (i) 
  Theoretical production time per device/machine/robot (TA1…n)…n-assets, 
  (ii)Real production time per device/machine/robot measured/recorded via KITT4SME 
  architecture (RA1…n)…n-assets, (iii) Status of a machine/devices/assets 
  (good, medium, fail). The others constraints are related to the outputs. When 
  you want to perform a physical reconfiguration it's important to know the physical 
  constraints of each one of the components because a wrong  initial parametrization 
  of SFR could cause the breakage of an assets. 


### Value proposition

* SFR helps manufacturing SMEs that want to increase productivity, avoid 
  critical failures by generating the optimal shop floor configuration 
  taking into consideration the production ratios and the states of the
  assets. Unlike traditional scheduling software SFR will also include the
  functionality of physical reconfiguration to decrease the response time 
  improving the productivity and avoiding long downtimes.


