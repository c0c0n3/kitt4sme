Adaptive Questionnaire
--------------------

The Adaptive Questionnaire (AQ) is a software that supports manufacturing SMEs
in extracting their tacitly existing needs and critical issues (e.g., high
repetitiveness of manual tasks) that AI could solve.


### High-level functionality

The Adaptive Questionnaire (AQ) technology supports manufacturing SMEs
registered in the KITT4SME platform to identify their main production needs and
critical issues that AI could solve. SMEs are guided through a set of multiple
choice questions and get, at the end, the list of issues.

It will be available in the landing page of the KITT4SME for the registered
users and as a service in itself offered to companies that want carry out a
self-assessment. In facts, it is considered also a promotional tool that
influences the perception of KITT4SME in the eyes of the users, as it interacts
with them from the first stage of their journey through the platform.

The compilation of the AQ allows also to acquire valuable inputs for the other
services offered by the KITT4SME platform and, first of all, for the
configuration of the kit of customized modules the KITT4SME platform can offer.


### Role in the architecture

The AQ is a service provided to users thorough the KITT4SME platform. Any
registered SME has the possibility to fill in it online. The adaptive approach
will be adopted in such a way the sequence and the number of questions is
adapted to the respondent. The respondent will receive immediate feedback at the
end of the questionnaire. The output of the questionnaire is also a valuable
information for the creation of the kit to be proposed. In this sense, it can be
considered as an internal service to the platform.


### Requirements

According to the Customer Journey Map, the AQ supports the DIAGNOSE phase and
represents the first step along the manufacturing SMEs Customer Journey
immediately after their registration.

The methods and times of execution, the ease of use and understanding and the
validity of the results are considered as the most important requirements: they
influence the level of confidence that is created between the user and the
platform and if they do not meet the expectations, they lead to an increase in
the churn rate of users.

The adaptiveness of the questionnaire tailors the sequence of questions to the
respondent, thus offering a customized experience to the user from the very
first step fo the user journey.


### Improvements

The SUPSI experts, deepening the results obtained from the verification of the
pilots and the validation tests, have improved the level of accuracy of the
expert knowledge: through a refinement on the correlation of the weights
attributed between responses and critical isseus.

The adaptive engine, the algorithm necessary to dynamically select the
questions, is an extension of the tool for adaptive questionnaires AdapQuest
(https://github.com/IDSIA/adapquest) that had been developed by SUPSI to support
the language placement tests.  The software has been further develop to adapt
and fulfill the role in the platform. These changes include new objective
functions and a new easy-to-read-for-humans template that allows the
elicitations of the internal model. In addition to these improvements to the
existing software, for the KITT4SME project a series of internal tools has been
developed and deployed internally to allow the knowledge transfer from the
expert to the adaptive model. The integration of these changes made it possible
to improve the effectiveness of the tool.

Further data collection is planned in the future in order to re-run the
validation tests and make other improvements to the tool both in terms of
efficiency and effectiveness.


### Value proposition

The tool provide a service that allows a company to carry out a self-assessment
focused on the identification of  critical issues that can be solved with AI.
This service is provided for free as an incentive to go one step further in the
journey offered by the KITT4SME platform.


The tool is based on an Bayesian Network that allows it to acquire information
and learn while the user fills the answers in the questionnaire. The use of such
networks allows human experts to easily describe the connection between the
answers and the issues that can be solved by a specific AI kit. This allows to
easily add in the future new issues and new kits, increasing the level of
effectiveness, detail and precision of the results provided by the tool to users
and consequently also of the proposed solutions.

The adaptiveness of the questionnaire increases the effectiveness of the the
tool compared to more traditional analysis tools and provides an alternative to
more expensive consulting services.

The tool is an evolution of [AdapQuest](https://github.com/IDSIA/adapquest/)
published as an open source software by [IDSIA](https://idsia.ch), an institute
of SUPSI for research on AI.
