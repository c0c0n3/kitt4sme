Sensing Layer
--------------------

### High-level functionality 
Sensing Layer implements access points, manipulation, storing and routing of the data regarding workplace and workers and coming from different and multiple sources like wearable devices and environment sensors.  It supports all possible use cases involving the use of the watches data sensor data for determining the assistance intervention for worker wellness during shop floor activities, as it provides an interoperability solution (APIs and broker client) for bidirectional data exchange between devices and the KITT4SME platform.

The IM can combine this data with context data to determine system state (workers + work cell) and react to improve process performance while also ensuring the well-being of workers. Misalignments that could be attributed to high cognitive or physical demands can be recognized, and real-time interventions (e.g., job assignment shifts, equipment, or machine parameter modifications, etc.) can be organized at various levels (e.g., equipment, machine, single workstation, work cell). This allows for the production system's flexibility to be used to assist operators when their behavior deviates from optimal and/or safe performance.

![SL](https://user-images.githubusercontent.com/2041951/154863454-cba97fca-168b-41bd-b8cd-333f4e9bced7.PNG)


### Role in the architecture

Sensing Layer is designed for M2M (machine-to-machine) communication with the Empatica watches that produce physiological data like: 

- Heart rate
- Blood glucose 
- Blood pressure 
- Respiration rate
- Body temperature
- Blood volume
- Sound pressure
- Photoplethysmography
- Electroencephalogram
- EKG (Electrocardiogram)
- Blood oxygen saturation
- Skin conductance  

### Requirements

Empatica watches. 

### Improvements

Communication with Apache Kafka and FIWARE Orion Context Broker

### Value proposition

GHEPI, supported by SUPSI and HLX Srl, has 25 injection molding lines in different work cells, where several components of different nature are produced by several skilled operators, supported by manipulators, cartesian robots and cobots. GHEPI’s pilot demonstration targets a work cell equipped with a 500-tons injection molding press to produce heavy plastic components through a multi-step production process. 

In KITT4SME context, the integration of a collaborative robot, which can be configured in short time and can adapt to the operators’ needs for the different kinds of production can help optimize plant productivity and workers’ well-being and motivation. To do so, KITT4SME tools for the GHEPI’s pilot are, besides the platform Core, the Fatigue Monitoring System (FaMS), the Sensing Layer (SL) and the Intervention Manager (IM). 

KITT4SME introduces extrinsic and intrinsic job variations in the GHEPI’s work cell by dynamically assigning tasks to operators or the cobot, specifically installed in the KITT4SME’s upgraded work cell. Thanks to the integration with the **Sensing Layer**, FaMS can collect data from wearable devices worn by workers and calculate their stress levels. 

The IM can couple this information with context information to detect system status (workers + work cell) and react to both optimize process performances and workers’ well-being. Misalignments potentially ascribable to high cognitive or physical demands can be identified and real-time interventions (e.g. tasks assignment shift, equipment or machine parameters changes, etc.) proposed at different levels (e.g. equipment, machine, single workstation, work cell), can be orchestrated. This allows exploiting the flexibility of the production system to support operators whenever their behavior deviates from optimal and/or safe performance.
