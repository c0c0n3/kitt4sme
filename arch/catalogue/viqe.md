Vision for Quality Excellence
-----------------------------

**NOTE**. The content below was contributed by Rovimatica, copy-pasted
from the original document.

Vision for Quality Excelence (VIQE) is a software module to perform
image processing based on Deep Learning in industrial environments.


### High-level functionality 

VIQE is a generic service to perform image processing using Deep Learning
to classify, detect and segment objects in industrial field. It allows
to customize by training new models based on pre-trained models for U-Net,
MobilenetV2 and YOLO architectures. It enables the KITT4SME platform
to offer a service to implement production quality inspection based
on image processing. In the particular case of KITT4SME project, the
VIQE module will be customized for tweezers and RAW material quality
evaluation.


### Role in the architecture

VIQE is a KITT4SME platform application service. It is a REST service
that acquires images from specific clients developed in quality inspection
machines. It also provided data as NGSI entities in the Orion Context
Broker. It relies on the underlying mesh infrastructure for security,
scalability and automated deployment. VIQE is available to SMEs through
the RAMP marketplace.

The following diagram shows VIQE in the context of the KITT4SME platform.
An SME can deploy the service and then connect inspection machine to
the platform to have VIQE producing image processing outcomes based
on previously trained deep learning model. VIQE has implemented the
training functionality to customize deep learning model to solve particular
problems. Images are received from vision machines and sent to Deep
Learning sub-module producing outcomes. These outcomes are received
in the vision machine to customize according to the quality inspection
(e.g. measure, filter, etc…) and generates quality inspection measurements.
These measurements feed an NGSI entity in the KITT4SME Context Broker
through the communication sub-module. The platform tracks the entity
to store in platform database which are displayer in a RAMP dashboard.

![VIQE context diagram][viqe.dia]


### Requirements

VIQE requires high power graphic computer unit (GPU) to perform the
inspection in near-real time. VIQE will help SMEs to implement a Deep
Learning pipeline for image processing without addressing the training
and model development. User will require annotated images according
to the VIQE features. These images will be sent to VIQE service to
train and generate a new deep learning model that could be used by
a machine vision to perform quality inspection using images.


### Improvements

Deep Learning models pipeline, from training to deployment, has been
encapsulated in a REST service to generate VIQE in order to fulfill
with the platform requirements. The work is being carried out in the
WP2 (interface to the FIWARE middleware) and WP 4 (deep learning models).


### Value proposition

VIQE helps manufacturing SMEs that want to implement quality inspection
based on image processing by reducing the number of items with nonconforming
defects and increasing the quality inspection accuracy by using state-of-the-art
Deep Learning models for image analysis. Unlike traditional computer
vision analysis techniques, deep learning models implemented in VIQE
will produce a dramatically reduction of items reworking that help to
increase the market competitiveness of the SMEs.




[viqe.dia]: ./viqe.png
