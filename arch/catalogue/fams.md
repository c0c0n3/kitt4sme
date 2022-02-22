Fatigue Monitoring System
--------------------

The Fatigue Monitoring System (FaMS) is a software to detect possible physical
(e.g., tiredness) discomfort or harmful situations for a worker.

### High-level functionality

The Fatigue Monitoring System (FaMS) detects physical discomfort of workers by
predicting their perceived fatigue exertion. It takes workers physiological data
as input, and uses machine learning models to predict the perceived fatigue
exertion. Through the KITT4SME platform, FaMS enables SMEs to take data-drive
decisions to improve workers' well-being (e.g., suggesting to have a break,
increasing the support provided by auxiliary tools, like exoskeletons).

### Role in the architecture

FaMS is a KITT4SME platform application service. It recurrently acquires
historical physiological data from the platform time series database, and
produces predictions. Predictions are made available as NGSI entities in the
platform IoT context. As a platform application service, FaMS will be available
in the RAMP marketplace. An SME has to deploy the service from RAMP, and then
feed the time series database with physiological data about workers. Depending
of the different employed ML model, FaMS requires a different set of features to
be measured. FaMS computes the estimated perceived fatigue exertion for all the
workers recurrently, at a given rate (e.g., once every 10 minutes). The
predictions become available to other services as NGSI entities published to the
IoT context.

### Requirements

FaMS requires SMEs to adopt wearable devices in their factories to monitor
physiological data of workers. Given that the set of required features depends
on the employed ML model, wearable devices from specific vendors may be
required. Finally, a dedicated effort for training the ML model may be required,
depending on the desired level of prediction accuracy. This activity includes a
data collection campaign to collect and label data from workers.

### Improvements

FaMS is built on an existing application developed within a different EU
project. Wrapping FaMS as a KITT4SME services required to develop new data
connectors to (i) read data from time series databases (before, FaMS read data
from a dedicated Web services via REST APIs), and (ii) to write predictions to
the platform IoT context. The last activity required also a modeling phase to
convert plain text prediction into NGSI entities. The work has been carried out
in WP2 (connectors to the FIWARE middleware), and WP4 (NGSI data model for
predictions, additional training of ML models).

### Value proposition

FaMS helps manufacturing SMEs that want to monitor the well-being of their
workers by estimating the level of perceived fatigue exertion, enabling
data-driven decisions with the aims of limiting discomfort and harmful scenarios
and targeting the optimisation of the process performance, the welfare of the
workers and the interaction between humans and machines.
