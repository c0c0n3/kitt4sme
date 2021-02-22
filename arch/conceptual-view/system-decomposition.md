System decomposition
--------------------
> Breaking it down into sub-systems.


### Functional decomposition

Here's the breakdown of the Kitt4Sme platform into sub-systems and layers.
Starting from the lowest layer, the KITT4SME architecture covers data
gathering from different devices, deployed in the factory, feeding the
knowledge-base of the system with raw and pre-processed data:

* Wearable Sensors, worn by the worker, are meant to help monitor
  psychophysical parameters related to health and well-being. According
  to the “human in the loop” principle, those sensors can be also involved
  within the decision-making loop.
* Cyber-Physical Systems, especially those typically involved within the
  process (machining equipment, 3D printers, collaborative robots, automated
  logistics, etc.).
* Environmental Sensors, scattered in the factory and aimed to collect
  information on the environmental conditions (i.e. air pollution, temperature,
  noise level, etc.).

At the next layer, the FIWARE framework provides a set of Generic Enablers
interfacing devices for the purpose of gathering context information or
triggering actuations in response to context updates:

* The IDAS Generic Enabler which offers a wide range of IoT Agents meant to
  interface devices using the most widely used IoT protocols (LWM2M over CoaP,
  JSON and UltraLight2.0 over HTTP/MQTT/AMQP, OneM2M or OPC-UA).
* The FAST RTPS Generic Enabler that adopts ROS2 middleware, which helps to
  interface with robotics systems.
* The Generic Enabler Kurento that enables real-time processing of media
  streams to support the transformation of video cameras into sensors as well
  as the incorporation of advanced application functions (integrated audiovisual
  communications, augmented reality, flexible media playing and recording, etc.)

The next upper layer shows the FIWARE Context Broker, the core and mandatory
component for a Powered by FIWARE solution. It enables to manage context
information in a decentralized and large-scale way. It provides a RESTful
API enabling to perform updates, queries or subscribe to changes on context
information. The Context Broker holds information about current context data,
i.e. the current and most recent update status of all the devices, components
and processes that are engaged in a processing industry factory. However,
context information evolves over time, creating a context history that is 
fundamental for analytical and machine learning tasks that base their algorithms
on dedicated time windows of factory context data. FIWARE provides own Generic
Enabler to persist Time Series historical data, QuantumLeap and STH-Comet, but
can also forward the data to other third-party databases. Furthermore, data can
be streamed to distributed processing engines like the Big Data and AI-based
Detections Tools to enable analysis on historic data context.

![Layers][components]




[components]: ./components.png
