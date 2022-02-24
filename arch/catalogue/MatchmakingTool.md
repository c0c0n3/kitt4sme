Competence Matchmaking Tool
--------------------
Competence Matchmaking Tool (CMT) is a software that matches worker profiles to training experiences/courses based on workers' competence/skill gaps and the skills offered by training experiences and courses.


### High-level functionality

* CMT matches a worker profile with training experiences and courses to fulfill skill gaps in worker profile, which is necessary to maintain an efficient production system.
* The CMT takes two inputs: 1) the competence/skill gaps of the worker consisting of the list of skills the worker is required to have and 2) a catalogue of training experiences/courses consisting of a list of skills each of the training experience offer. In particular, the competence/skill gaps consist of three skill gaps: 1) should do (the skills the worker should acquire), 2) want to do (the skills the worker requires to perform the tasks she/he wants to be able to do) and 3) wish to be (the skills that the worker requires to achieve a worker profile he/she wishes to become). A more detailed description of these skill gaps can be found in Worker Profiler. 
* As an output, CMT provides a list of courses that each worker profile should undergo to fulfill gaps in their profile. In particular, CMT takes into consideration the duration of the training experiences and whether they provide a certificate or not, permitting SMEs to find training experiences that fulfill workers skill gaps in short time period and permitting workers to enhance their profile with course certificates, respectively. 
* CMT aims to fulfill the competence/skill gaps of all workers of an SME while minimizing the overall number of training courses to be conducted by the workers of the SME.
* In the context of the KITT4SME platform, the CMT enables to offer SMEs a service to match their worker profiles to training experiences that optimally allows fulfilling competence gaps of workers. 


### Role in the architecture

* CMT is a KITT4SME platform application service. It acquires two inputs: 1) skill gaps from the Worker Profiler and the Production System Profiler and 2) training experiences and the list of skills offered from Training Experience Virtual Catalogue. It ouputs to an SME utilizing it a list of training experiences (courses) to be assigned to each worker.  


### Requirements

* Worker profile competence/skill gaps
* Catalogue of training experiences and courses 


### Improvements

* This is a first implementation. CMT is a novel tool developed in the context of KITT4SME. The work to develop CMT is carried out in WP 5 (Digital competences and platform service evolution, Task 5 (Matchmaking for competence development).


### Value proposition

* CMT helps manufacturing SMEs that want to fulfill competence/skill gaps in the profiles of their workers to meet requirements of the production system by providing them with a list of training experiences/courses that each of the workers should conduct. CMT therefore allows SMEs to match worker profiles to training experiences within seconds, savings SMEs a huge deal of effort and time. 
