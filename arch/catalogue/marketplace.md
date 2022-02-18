RAMP
----

**NOTE**. The content below was contributed by ED, copy-pasted from
the original document.


Is the adaptation of the Robotics and Automation Marketplace ([RAMP](www.ramp.eu/)) for the scope of the KITT4SME project. It was initiated with the project L4MS, and is now a joint activity (development, testing, dissemination, exploitation) with projects DIH², SHOP4CF and Better Factory.

### High level functionality

- Enables the elicitation of end-user needs
- Enables the submission of new technical solutions to the registry
- Enables the interaction between end-users and kit-integrators for the creation of new kits (sets of solutions)
- Publishes (presents) the solutions to an audience of common-minded actors
- Provides a set of tools for the visualization of data, searching/ creating tenders for new solutions and user interaction
- Stores the solutions (registry)
- Allows the deployment of modules using docker containerisation


### Role in the architecture

Is a component of the Service Mesh and abides by the rules of the cluster for the exposition of services, user authentication and interaction with other services

### Requirements
The mapping of the User Requirements to the functionalities provided by RAMP is made in D3.3. The main user requirements are repeated here for ease of reference:

1. Integration with Adaptive Questionnaire (RAMP serves the UI)
2. Integration with Digital Datasheets (RAMP serves the UI)
3. Enable the interaction (communication) between technology dev and end-user
4. UI for the creation and customization of the `kit`
5. UI for the submission of new software solutions


### Improvements

- Development of new data visualization tool
- Development of Digital Datasheets for the technical description of new components
- Integration/ adaptation to the KITT4SME platform
- Development of interface and implementation of workflow for the elicitation of user needs
- Implementation/ adaptation of the mechanism for the interaction of the kit-integrator with the end-user towards the kit creation



### Value proposition

- Exposes solutions for the industry sector to the relevant audience (supported by a number of DIHs and EU-projects)
- Enables the creation of customized (kits of) solutions for the end-users
- Provides a readily available toolset to the manufacturing end-users, by leveraging the kitt4sme infrastructure
- Supports the growth of the community by:
    - screening of solutions
    - interaction with end-users
