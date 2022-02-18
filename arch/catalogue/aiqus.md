# AIQuS Component

**NOTE**. The content below was contributed by R2M, copy-pasted from
the original document.


AIQuS is a component inspired on the idea that traditional inspection techniques can be merged with innovative features of AI facilitating both the configuration and the verification phase of the control plan. **A training phase for the algorithms is done using acceptable vs defective pieces that are analysed and used to extract the optimal settings leading to mechanical adjustments to allow the correct movement of the pieces in the machine**. Furthermore, enabling these adjustments and the possibility of doing quick quality control on the pieces, it will allow the AI on the classification machines to learn overtime, retain and reuse knowledge and along with information provided by sensors to support operators in performing quality assurance processes, verifying the conformity of the pieces, and ultimately avoid errors classifying non-conformities.

AIQuS applies AI and non-AI approaches for **facilitating the setting-up and the operation of the quality inspection systems**. Specifically, AIQuS tries to solve the problem of the lack of training data. Most quality controls systems use supervised learning, trained with a collection of OK and NOK images. This data needs to be balanced for optimal results, but the problem is that it is easy to obtain a high number of images of OK parts but not so easy to obtain images of defective parts (NOK)

AIQuS uses Data Augmentation techniques in order generate new images, so this new data can be used to: 1) have balanced data for the training AI algorithms, specifically for new pieces that don't have enough NOK data; 2) to be used to compare different AI algorithms, and select the best settings; 3) enable operators to do a continuous evaluation, fine tunning and re-configuration of the quality control AI systems once new defects are detected.

### High-level functionality

AIQuS is a tool that uses different techniques to generate new data. Specifically, new synthetic images based on images with defects and images without defects.

Specifically, AIQuS receives sets of images (with or without errors) and applies non-AI techniques (such as resizing, rescaling, brightness changes, zooming, etc.), AI techniques (based on Generative Adversarial Network) and pixel-blending and layer overlapping techniques (only in some cases) to multiply the number of images, generating synthesized images.

### Role in the architecture

AIQuS is not, per se, an element of the architecture, but a component that performs a specific function of generating synthetic images for a pilot.

In any case, part of the functionality of AIQuS, could be used in a generic way, for example the part of Data Augmentation based on Image Data Generators, can be used by any KITT4SME component in need of generating synthetic images. Thus, this Data Augmentation part of AIQuS can be included as a downloadable element of the marketplace or as a proof of concept of how a module that interacts with part of the KITT4SME ecosystem can be implemented.

### Requirements

- Tensorflow/Keras: AI training and Data Augmentation
- Docker/Kubernetes: Composability, orchestration and integration with KITT4SME
- KITT4SME Broker: AIQuS writes some logs and information to the broker (e.g when a Data Augmentation process is started, when the process ended, information number of images generated), so this information can be stored in a database for traceability, or can be used in the Dashboards or Business Intelligence components
- KITT4SME Storage: AIQuS sends the data to the broker so the data is stored in the system, but could also work directly with a temporal database (e.g Timescale/ProstgreSQL)

### Improvements
 
AIQuS is an original KITT4SME idea and the first development implementation. Even the part related to Data Augmentation and GAN is new. AIQuS was designed to cover be aligned with the needs of the pilot, develop an AI related component, but also to be able to demonstrate the integrating of AI modules with KITT4SME middleware and being deployed to the marketplace.


### Value proposition

Using an Ad-lib to define our Value Proposition, we could summarise AIQuS as:

*Our* Data Augmentation and Synthetic data generator (AIQuS) component *help(s)* SMEs using classification algorithms *who want to* solve the problem of the lack of data and that want to compare classification algorithms *by* providing new data that allows them to set up fast the initial configuration of the classification machines, specifically for new pieces, refining the classifier once the more real data is generated, *and by* allowing them to use the synthetic data to compare algorithms in order to select which one is better for a specific classification task, 

*Our* Data Augmentation and Synthetic data generator (AIQuS) *help(s)* SMEs using KITT4SME ecosystem *who want to* have a collection of altered images for testing algorithms, fine tunning them, or developing need AI solutions *by* providing a KITT4SME compatible module, with a simple API, to generate thousands of synthetic images *and by* logging the actions performed so later can be queried or presented in a dashboard.


### Marketplace and availability

A proof of concept of this component with part of the functionality is planned to be uploaded to the marketplace and make it public available as an example of how to integrate some applications in the mesh.
