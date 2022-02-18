Worker Profiler
---------------

**NOTE**. The content below was contributed by Holonix, copy-pasted from
the original document.


_Task 5.2 – Human competence and capabilities profiling [Leader: GATE, Duration: M11 – M22]_

_This task develops the KITT4SME Worker Profiler, a tool that allows performing a skills gap assessment for the single
worker to be used as an input of the Competence Matchmaking Tool (T5.5) that finds the optimal training plan to fill
those gaps. Three steps are foreseen to develop the Worker Profiler._

_First, inputs from T5.1 are used to identify both the new archetypes requested by the on-going digital transformation and the updated skills to be integrated in the existing archetypes to update them according to the new technological requirements. Second, a map of the skills mismatching is created with a questionnaire._

_The questionnaire will be generated automatically using an AI based approach applied
on the information extracted in the previous point. The tool (offered by GATE) will be used in order to make the
questionnaire design phase more efficient and replicable. Finally, reference standards like ESCO and O*NET are used
to quantify gaps and to create a proper assessment procedure to be integrated into the tool._

_GATE will lead the task creating the skills map and the new archetypes supported by HOL for the implementation of
the resulting Worker Profiler and by the end-users for characterizing archetypes related to the pilots._

### High-level functionality

The worker profiler is a tool able to assess the skill gap of a worker in relation to:
- The technological skill needs driven by AI revolution and what International competence databases define as standards for her/his professional role (should do & want to do);
- The ambitions of the worker (wish to be);
- The technological skill needs driven by the acquisition of a specific AI component in KITT4SME platform.

### Role in the architecture

Worker profiler is a platform application service. It is a RESTful backend service with an UI, that users use it to fill questionnaires based on their skills.  It's output is the input for GATE's "Catalogue of Qualified Training Experiences" and  "Competence Matchmaking Tool" tools. 

### Requirements

- Worker archetypes database
- Communication with Competence Matchmaking Tool

### Improvements

It is its first implementation

### Value proposition

If the worker is interested to measure the skill gap between what they currently do and how they want to improve, Worker Profiler gives the opportunity to select any archetype from a long list of them. Then, the worker conducts the assessment.
The system takes the answers provided by the user and calculates a “similarity score” for every archetype. Finally, the three archetypes with the highest score are selected to be presented as suggestions to the user.

