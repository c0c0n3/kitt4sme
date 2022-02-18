# Manufacturing Process Management System (MPMS)

**NOTE**. The content below was contributed by ED, copy-pasted from
the original document.


### High level functionality

The MPMS orchestrates manufacturing processes by keeping a model of the production process and assigning tasks to the involved actors at the appropriate time.
The actors in the manufacturing process can be humans, machines or other software systems. The orchestrator emits the corresponding commands based on the values of data flowing from the shopfloor or the output of interconnected 3d party modules.

### Role in the architecture

The MPMS is deployed as an authorized service in the KITT4SME Service Mesh. Its interaction with external services, databases, sensors and controllers is realized
through the FIWARE infrastructure and abides by the technical specification applicable to all services.

### Requirements

1. Create the model of the production process, with all the possible branches or alternatives in BPMN.
2. Issue or redirect command signals towards other modules in the kitt4sme platform (messages, task progress, sensorial input and command signals to high level modules)
3. Implement or integrate safety logic in collaboration with (potentially locally installed) safety modules (optional implementation, determined on the basis of specific processes)
4. Integration of the execution engine to the FIWARE enabled kitt4sme platform

### Improvements

The MPMS is based on the [Camunda engine](https://camunda.com/) which is configured and extended for the process and integration requirements. The corresponding User Interfaces in terms of FIWARE entities are specified for each application. The implementation under KITT4SME will be based on the results of the [HORSE project](http://horse-project.eu/) and will be further developed to include:

- model development for the processes under the KITT4SME pilots (where appropriate)
- integration to the FIWARE infrastructure
- establishment of interfaces towards the relevant AI services in the KITT4SME platform


### Value proposition

- Introduce high-level process automation and monitoring to the production systems of SMEs, especially to the ones with low adoption of automation
- Enable the integration of AI modules to the production systems of SMEs: links the decision making ability of AI modules (for example the Intervention Manager) to
  the sensing and control equipment of the shopfloor (via the process model). The MPMS executes the production process model and by keeping a record of the process state, it envokes the best assignment of roles to ensure that:
    - the process continues unobstructed (for example without unexpected stops from worker fatigue), since the allocation of tasks happens dynamically
    - the health and safety of human workers is considered as an integral activity of the process
