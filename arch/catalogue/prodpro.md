Production Profiler
-------------------

**NOTE**. The content below was contributed by Holonix, copy-pasted from
the original document.


_Task 5.3 – Production system competence profiling [Leader: HOL, Duration: M11 – M22]_

_This task develops a Production System Profiler as a dual of the Worker Profiler of T5.2. The aim of this tool is to
characterize skills and capabilities demand at the various levels of the factory (whole plant, production line, workplace).
The use of the same taxonomy used in T5.2 ensures the coherence of the representation towards its comparison in the
matchmaking of T5.5._

### High-level functionality 

The Production Profiler is an extension to Worker Profiler. The taxonomy is based on T5.2 database. In this phase the user can choose the macro class of production. This will be the first step to create a new questionnaire based on the archetype chosen by the user. The generated questionnaire is divided into six main sections:

1.	Production type
2.	Digitalization level
3.	Communication & data transfer
4.	Process control
5.	Process management
6.	Human resources skills
7.  Human resources type

![Profilers](https://user-images.githubusercontent.com/2041951/154861902-7b86f36a-8350-4b76-83b2-6d118bfa2b2f.png)

### Role in the architecture

On the basis of a "clustering" of the archetypes already identified in T5.2, we could identify groups of archetypes attributable to the various AI components present in the platform. In this way, once the AI ​​component has been chosen from the marketplace, SME will be able - by activating the tools we are developing - to find a list of consistent archetypes. In this framework, the worker profiler (and in general all the consequent tools developed in WP5) can have different functions:

1. Guiding the user company in deciding which employees to involve in the profiling of skills (both the professional figures that may already be associated with the archetype on which to perform skill assessment / upskilling to bring them to the level of international standards, and professional figures currently not associated with the 'archetype, if, for example, the professional profile is not present in the company and you want to fill the personnel assigned to other activities through an internal reskilling process)

2. Automatically offer a job description aligned with international standards to be used in case of need for recruiting from the outside (but also internally) that can be used to fill in a job vacancy.

### Requirements

- Worker archetypes and production skills related archetypes databases
- Communication with Competence Matchmaking Tool

### Improvements

It is its first implementation

### Value proposition

The Production Profiler's goal is to define any skills demands related to the shop floors various activities. As an extension of the Worker Profiler, we ensure the consistency, continuity and integrity of any data and matchmaking process(es) (T5.5)
