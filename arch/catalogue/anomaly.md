# Shop Floor Anomalies Detection System

**NOTE**. The content below was contributed by Ginkgo, copy-pasted
from the original document.

AnoWam is welding point anomaly detector
TimeWam is welding output Joules forecasting


### High-level functionality

AnoWam and TimeWam are KITT4SME integrated Ai services for welding point anomaly detection and forecasting. It consists of an anomaly detection model that performs real-time detection of defective welding points in the welding process and a forecasting model, which role is to estimate future welding output joules of the welding process. The detection and the forecasting procedures are carried out by taking the raw data from the welder as input to subsequently estimate the defectiveness of each measurement and forecast the future values based on the input values and parameters. AnoWam and TimeWam offer through the KITT4SME platform a real-time and scalable solution for manufacturing companies to continuously monitor the health and quality of their products. In addition, it will help to better understand the process flow and the causes of anomalies.


### Role in the architecture

The data refinement and transfer are based on NGSI data model template. 
Anowam and TimeWam in KITT4SME streamline the detection process and forecasting through a NGSI API. The data is first converted to an NGSI entity before being routed to the API via the FIWARE context broker (using update/subscribe functionality). These technologies solution is provided through the RAMP marketplace. The security protocols are established by the mesh service, for detail [Service mesh](https://github.com/c0c0n3/kitt4sme/blob/master/arch/mesh/interception.md). 
The SMEs connect their machines to the KIT4SME to access the anomaly detector and forecasting model. The raw measurements from the shop floor are shaped into NGSI entities by the middleware, which is then sent to the detection model with the aid of the FIWARE context broker for quality assessment and future values prediction. 
The models' estimations and the metadata (welding point description) are conveyed to dashboard for visualization and analysis purposes.


### Requirements

•	Map KITT4SME requirements to the functionality provided by this component.
•	Focus on how this is going to help SMEs make the most out of the platform.
•	Reference the user journey if possible.


### Improvements

AnoWam and TimeWam are part of the WP4.2 and WP6.1 (HUMAN-AWARE DIGITAL SHOP FLOOR DATA MODEL  ) respectively. 

### Value proposition

The service aims to seamlessly coalesce artificial intelligence and human problem-solving expertise into a single digital concept with advanced shop floor orchestration capabilities. Anowam improve the current monitoring of the welding process, make it more accurate and faster. Detection of anomalies in the process with an immediate indication of the place of occurrence (image made available to the operator) will support operator training. The available reports in the KITT4SME kit will extend the knowledge of the process by quality specialists and managers. Quick insight into the result of the process will improve the process of training operators and specialists in correcting the process flow. (New settings and process validation for new and manufactured products). The beta version of the service in KITT4SME has been released as open-source software at: [Anomaly detector](https://github.com/c0c0n3/kitt4sme.anomaly)
