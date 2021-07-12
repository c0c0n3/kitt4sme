Continuous integration
----------------------
> ready, steady, ...deploy!

KITT4SME adopts an automated workflow to manage service delivery. A
KITT4SME platform instance is described by a set of files versioned
in an online Git repository. Each file declares a desired instantiation
and runtime configuration for some of the components in the platform
instance. Collectively, the files at a given Git revision describe
the deployment state of the platform services and mesh infrastructure
of which the KITT4SME platform instance is comprised at a point in
time. An Infrastructure-as-Code (IaC) operator monitors the Git repository
in order to automatically reconcile the desired deployment state with
the actual live state of the platform instance.

Automated, version-controlled service delivery has several benefits.
Automation shortens deployment time and ensures reproducibility of
deployment states. In turn, reproducibility dramatically reduces the
time needed to recover from severe production incidents caused by faulty
deployments as the platform instance can swiftly be reverted to a previous,
known-to-be-working deployment state stored in the Git repository. Thus,
overall platform stability and service availability are enhanced. Moreover,
the Git repository stores information about who modified the platform
state when, thus furnishing an audit trail that may help to detect
security breaches and failure to comply with regulations such as GDPR.

We now delve into the mechanics of the KITT4SME deployment process.
The deployment of AI service kits is a key activity to be performed
in the Compose phase of the KITT4SME workflow. Therefore we detail
it below. Platform infrastructure services and mesh infrastructure
components are deployed in exactly the same way, hence we do not provide
any further information about them.


### Deploying AI service kits

Instructions to carry out changes to a live kit deployment are encoded
in YAML files and kept in an online Git repository. Changes to the live
system are triggered through an automated workflow which the system
administrator initiates by creating a new revision of some YAML files
in the Git repository. (In the future, the KITT4SME Platform Configurator
could automatically trigger the deployment of new kits.) When the first
revision of a kit is uploaded to the repository, the kit's services are
created in the KITT4SME cloud whereas subsequent configuration changes
result in the live services being updated as soon as the new configuration
is uploaded to the Git repository. The mechanism through which services
are created and then updated is the same.

![Platform continuous integration.][dia.gitops]

By way of example, the above diagram depicts a typical scenario where
a change to a tailor-made kit needs to be carried out. In this example
scenario, the Git repository contains the configuration of two independent
kits assembled for two different companies, ManuFracture and Smithereens.
The administrator would like to modify a certain operational parameter
(the `port`) of a service (`vision`) currently deployed in the KITT4SME
Kubernetes cluster for ManuFracture. (Each company is assigned a different
cluster namespace when creating their kit.) As hinted by the diagram,
the last time this service was modified, the `port` was set to a value
of `6776` in the YAML file containing the deployment instructions and
Git assigned a revision of `v5` to that change set. To enact the desired
change, the administrator edits the YAML file to set `port` to `5445`
and subsequently commits the edited file to the Git repository. On receiving
a fresh version of this file, Git assigns it a new revision of `v6`.
An IaC operator periodically polls the Git repository to detect any
updates so that the current state of the live KITT4SME deployment can
be reconciled with the latest instructions present in the Git repository.
Thus, shortly after revision `v6` is appended to the change history record,
the IaC operator recognises that the live system reflects the deployment
instructions at revision `v5` which has now been superseded by `v6`,
hence it is necessary to bring the live deployment up to date. For this
to happen, suitable commands will have to be issued to the cluster manager.
Therefore, the IaC operator proceeds to interpret the stanzas in the YAML
file as a command line that the Kubernetes client can understand. After
assembling the required command, the IaC invokes the Kubernetes client
with it. In turn, the Kubernetes client interprets that command as a
call to the Kubernetes API which finally triggers the desired deployment
actions on the live system, resulting in the deployment state to reflect
the YAML configuration at revision `v6`.




[dia.gitops]: ./gitops.png
