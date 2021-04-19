Continuous integration
----------------------
> ready, steady, ...deploy!

TODO short intro about devops/gitops and benefits

TODO explain how to use to support diagnose/compose---see intro/platform

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

![Wada wada.][dia.gitops]

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
An IaS operator periodically polls the Git repository to detect any
updates so that the current state of the live KITT4SME deployment can
be reconciled with the latest instructions present in the Git repository.
Thus, shortly after revision `v6` is appended to the change history record,
the IaS operator recognises that the live system reflects the deployment
instructions at revision `v5` which has now been superseded by `v6`,
hence it is necessary to bring the live deployment up to date. For this
to happen, suitable commands will have to be issued to the cluster manager.
Therefore, the IaS operator proceeds to interpret the stanzas in the YAML
file as a command line that the Kubernetes client can understand. After
assembling the required command, the IaS invokes the Kubernetes client
with it. In turn, the Kubernetes client interprets that command as a
call to the Kubernetes API which finally triggers the desired deployment
actions on the live system, resulting in the deployment state to reflect
the YAML configuration at revision `v6`.




[dia.gitops]: ./gitops.png
