The Platform Configurator
--------------------

Platform Configurator compares critical issue probabilities with module capabilities to rank kits for RAMP recommendation to customers.

### High-level functionality

The Platform Configurator operates by taking the probabilities associated with critical issues from the [Adaptive Questionnaire (AQ)][aq] as input.
It then compares these probabilities with the critical issues addressed by each module/kit, extracted from the Digital Data Sheets (DDS).
To determine the compatibility level, the algorithm calculates the similarity between the two vectors (by exploiting the cosine distance). The cosine similarity is then interpreted as the percentage of compatibility of a kit, with reference to the specific needs of the company.

### Role in the architecture

The Platform Configurator is a platform application service, exposing a REST API that acquires data from two Postgres databases, shared with [AQ][aq] and DDS. It is mainly exploited for sending to RAMP a list of recommended kits of AI tools.

### Requirements

The Platform Configurator is a crucial component within the \'Modules matching and kit creation\' block of the user journey (see figure below).
It utilizes AQ's results and tools descriptions available in DDS to generate kits of AI modules.
The set of created kits can be then sent directly to RAMP, where the user can further customize them in a later stage. 
From the user\'s perspective, this component, along with the AQ, plays a fundamental role in assisting end users to independently identify the modules that align most effectively with their requirements, without the need for expert guidance.

![PC context diagram][pc.dia]

### Improvements

* Platform Configurator is available as one of the functionality of the KITT4SME platform covering the **Compose** phase. The service has been developed from scratch, including:
  * Interfaces and Data Models to share data with AQ, DDS, and RAMP
  * Kit creation strategy, to combine multiple tools into a kit, also resolving dependencies  
  * Scoring function to rank kits

### Value proposition

The Platform Configurator helps manufacturing SMEs in efficiently identifying modules that cater to their specific needs. By implementing an algorithm that considers user requirements from [AQ][aq] and matches them with the issues addressed by tools available in DDS, the Platform Configurator significantly reduces the time spent on researching potential solutions.
Unlike traditional consultancy, where a person is in charge to perform the shop floor analysis to suggest solutions that can alleviate the problems detected, the combination of [AQ][aq] with Platform Configurator offers a digital and automated consultancy approach.
This approach saves time without compromising the quality of the proposed solutions.


[aq]: ./aq.md
[pc.dia]: ./pc.png
