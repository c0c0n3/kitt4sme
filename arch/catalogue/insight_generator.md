Insight Generator
--------------------

**NOTE**. The content below was contributed by CSIC, copy-pasted from
the original document.


Insight Generator(IG) is a REST service for analyzing historical 
data sets and generate new insights to improve the manufacturing 
systems.


### High-level functionality 

* Insight generator is module designed to manage historical data 
from a production system, to extract valuable information from it 
and generate smart recommendations for improving the manufacturing 
systems on the basis of already defined KPIs by the users. It 
performs two main operation. Firstly, the software determines the 
key features that most influence on each KPI considered by users. 
Secondly, it creates models on the basis of KPIs and the whole 
historical dataset and suggest the optimal setting of the 
manufacturing system for improving the KPIs. The first phase is 
carried using feature selection techniques, whereas the second 
phase uses the selected features for training machine learning-based 
models encapsulated in a library, evaluates resulting models and 
applies an optimization method generating useful insights to 
technologist and plant managers for optimal parametrization of 
the manufacturing system.


### Role in the architecture

* Insight Generator is a KITT4SME platform-based service to conduct 
historical data analysis in order to generate new valuable insights. 
It is a REST service that receive form the Context Broker a trigger 
in order to initialize the data analysis and publish back to the 
Context Broker the results obtained (new insights). The following 
diagram shows the role of Insight Generator into the platform..

![Insight Generator context diagram][ig.dia]


### Requirements

* Historical data set: a historical data set should be provided in 
order to carry out the insight generation process.
* Data Quality: a sufficient volume of data should be available, 
and these must have the required quality, to be able to generate 
valuable insights.
* Interoperability: it necessary a visual interface (dashboard) to 
generate the start trigger as well as to visualize the results 
obtained via the Context Broker. Insight Generator communicates 
over HTTP, exposes a REST API and adheres to the NGSI specifications.

### Improvements

* Insight Generator enables the KITT4SME platform to offer a new 
artificial intelligence-based service to analyze historical data 
sets and generate new valuable insights. This service combines 
the use of advanced analytics tools, deep machine learning models, 
and optimization heuristics algorithms. IG have been developed as 
a rest service extended to support NGSI v2 model, defined as the 
model to exchange messages between the components within KITT4SME 
platform. This work has been carried out in WP 4 as part of task 4.5.


### Value proposition

* Currently, many SMEs are addressing new paradigms of connected 
industry, with a large volume of data generated and stored insufficiently 
exploited to improve the production processes. Although, in many cases,
 manufacturing SMEs have analytic tools, current software are cumbersome
to be handle, sometimes very expensive solutions, and limited to 
visualization and simple stats. Using Inside generator, SMEs can 
qualitatively improve not only manufacturing processes but also 
the whole business by analyzing insights generated in relation to KPIs.
IG analyze large volumes of historical data and translate data in 
useful information by new valuable insights. These generated insights
are supported on optimization using already defined KPIs, enabling 
more efficiency and higher productivity.


[roughnator]: https://github.com/c0c0n3/kitt4sme.roughnator
[ig.dia]: ./ig_diagram.svg

