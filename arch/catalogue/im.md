Intervention Manager
--------------------

The Intervention Manager (IM) component allows users to easily define
intervention rules to orchestrate a production system.

### High-level functionality

The Intervention Manager is a service to orchestrate a production system by
means of intervention rules. The component monitors the status of the factory
ecosystem in real-time, by elaborating data from sensors, machines, workers
monitoring systems. The set of intervention rules is known to the IM, which
selects the best one to trigger.

### Role in the architecture

IM is a KITT4SME platform application service. It subscribes the platform
middleware (FIWARE Context Broker) to continuously read data about the factory.
Collected data are evaluated against predefined rules; when all the conditions
are satisfied for a rule, a new intervention is sent back to the platform IoT
context as a NGSI entity. As a platform application service, IM is available in
the RAMP marketplace. An SME selects and deploys the service from RAMP, and then
should define the set of intervention rules to consider.

### Requirements

The IM allows SMEs to define their own intervention rules, by including
different parameters based on their needs. For example, a rule may monitor the
perceived fatigue exertion of a worker, provided by a different platform service
(e.g., FaMS). In this way, SMEs can include results from several services and
combine the information stored in the platform IoT context to take data-driven
decisions.

### Improvements

To deliver a new IM, we built on an existing version developed in previous
European projects. The existing IM has been used as a starting point for
developing the new IM version, as well as collecting new functional
requirements. A new implementation of the IM will be released in KITT4SME, with
specific connectors for the FIWARE middleware, as well as a model to publish
interventions to the FIWARE Context Broker.

### Value proposition

The Intervention Manager (IM) helps manufacturing SMEs that want to adopt
collaborative robotics and automation systems by providing a user-friendly
environment to easily define rules to orchestrate a production system. It
monitors the real-time status of the worker-factory ecosystem, elaborating data
from sensors, machines, workers monitoring systems, ERP, etc. The IM knows the
full list of possible interventions, and it employs a rule-based mechanism to
decide which is the best one to optimise the process performance, the well-being
of the workers and the interaction between humans and automation.
