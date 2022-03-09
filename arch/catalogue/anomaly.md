# SADS (Shop Floor Anomaly Detection System)

**NOTE**. The content below was contributed by Ginkgo, copy-pasted
from the original document.

### High-level functionality

SADS is a KITT4SME integrated AI service for anomaly detection in production. It consists of several anomaly detection models (based on supervised as well as unsupervised learning) for real-time detection of defective outcomes during production. The models can be trained on historic raw data from shop floor machines for example welding machines (containing parameters such as Output Joules, Charge, Residue, Force). Once trained, the chosen model can be used in production to distinguish acceptable from abnormal welding points.   
Data received from the shop floor machines might not be explicitly labeled, hence the SADS module also contains a labeling tool (based on repeated processing of welding points). 
For the KITT4SME platform, SADS offers a real-time and scalable solution for manufacturing companies to continuously monitor the health and quality of their products. In addition, the module will help to better understand the process flow and the causes of anomalies/abnormalities. 


### Role in the architecture

SADS is served as a cloud service and can be integrated into any other Analytics platform via its standalone REST API. It is served as an app in the KITT4SME platform via its publish /subscribe framework. The data refinement and transfer are based on the NGSI data model template.  
SADS in KITT4SME streamlines the detection process through an NGSI API. The data is first converted to an NGSI entity before being routed to the API via the FIWARE context broker (using update/subscribe functionality). These technologies solution is provided through the RAMP marketplace. The security protocols are established by the mesh service, for detail [Service mesh](https://github.com/c0c0n3/kitt4sme/blob/master/arch/mesh/interception.md).  
The SMEs connect their machines to the KIT4SME platform to access the SADS tool. The raw measurements from the shop floor are transformed into NGSI entities by the middleware, the output of which is then sent to the anomaly detection model with the aid of the FIWARE context broker for quality assessment and future values prediction.  
SADS’ estimations and the metadata (welding point description) are conveyed to the dashboard for visualization and analysis purposes. 

### Requirements

Near real-time streaming of live data from the shop floor is required to use the SADS tool. 
- Historic data is required for model training.  


### Improvements

The SADS is finetuned the existing Anomaly detection REST API to the KITT4SME platform  
Architecture. Especially the SADS is modified to meet the KITT4SME platform’s database, NGSI module, and publish/subscribe framework and made it robust to be used as a part of the platform and a standalone REST service. To achieve this we dockerized the app and scaled it via Kubernetes. 
The SADS comes with a pilot use case to show the workings of the app. The use case is developed as a part of WP4.2 and WP6.1 and they are released under the names of AnoWam and TimeWam. 

### Value proposition

The service aims to seamlessly coalesce artificial intelligence and human problem-solving expertise into a single digital concept with advanced shop floor orchestration capabilities. SADS significantly improves the current monitoring of the welding process, making it more accurate and faster. Detection of anomalies in the process with an immediate indication of the place of occurrence (image made available to the operator) will support operator training. The available reports in the KITT4SME kit will extend the knowledge of the process by quality specialists and managers. Quick insights into the result of the process will improve the process of training operators and specialists in correcting the process flow. (New settings and process validation for new and manufactured products). The beta version of the service in KITT4SME has been released as open-source software at [Anomaly detector](https://github.com/c0c0n3/kitt4sme.anomaly/tree/601f25e45a26a037745a765b62cbdae0a13d475b)
