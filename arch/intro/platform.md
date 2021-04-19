Cloud platform
--------------
> Supporting the Kitt4Sme workflow.

So where does all this leave us? Well, we could say that the main
goal of the reference architecture is to define the software infrastructure
to support the Kitt4Sme workflow and AI modules. But this is a bit
of a vague, catch-all statement, so we should put flesh on the bones
of it.

### Diagnose/Compose
Let's start with a quick look at the key elements of the software
infrastructure that was proposed to support the Kitt4Sme Diagnose
and Compose steps. Keep in mind this is very high level, like looking
at it from the moon kind of thing and later on, the technical sections
will fill the gaps. Here's what it looks like at a glance.

![Infrastructure to support the diagnose & compose steps.][dia-comp-infra.dia]

In relation to diagnose & compose, we have an integration point with
the RAMP platform to provide a mechanism whereby existing as well as
new AI modules can be composed in a working system configuration.
From a very abstract standpoint we've got a graph where nodes are
components and an edge tells you how two components can be assembled
in a working configuration, that is a tailor-made kit for an SME. In
practice, in correspondence of each kit config that the diagnose step
spits out, there will be a set of deployment descriptors (think Docker
Compose or K8s Helm charts) that make up that kit's package of services
to be deployed on the cloud instance running the FIWARE service mesh
which provides the communication, security and persistence backbone
as well as an interface to external IDS services.

**TODO** challenges


### Sense/Intervene
With diagnose & compose under our belt, let's see what it takes
to support the sense and intervene steps. Again, here's the lunar-orbit
picture.

![Infrastructure to support the sense & intervene steps.][sen-int-infra.dia]

Our job here is to build an information highway so data can travel
from the shop floor to the AI brain and from the AI to the factory.
In the diagram, we see two companies, aptly called ManuFracture
and Smithereens, whose devices are pumping raw measurements into
the system backbone. As data travels along, it gets converted
and refined so AI modules and KPI dashboards can process it.
Our thinking here is that the system backbone will be the FIWARE
middleware, and components will exchange data in the NGSI-LD
format using NGSI REST APIs. So for example, the `foo` and `bar`
interfaces the AI piggybacks on in the diagram should be REST
resources having an NGSI-LD representation you can manipulate
through NGSI REST operations.
In the other direction, the intervene lane, things work pretty
much the same. Yah, like same same but different, you know. The
diagram shows the AI sniffing out a `bar` value that's too high
so it issues a high-level, human-understandable command to reset
bar to a decent value which eventually gets translated to a command
the foobie device can understand.

Surely road safety is very important too. Nobody wants to get
into a nasty accident on a highway which is why we'll have to
make sure data can travel safely on our highway. In fact, depending
on the deployment scenario, part or even all of this communication
highway could sit in the cloud, so it's very important to use secure
communication channels and encryption where appropriate. For example,
hijacking commands from the cloud to the factory could have a disastrous
impact on the production line. Also the security infrastructure will have
to cater to multi-tenant scenarios like we see here with two
different companies sharing the same cloud stack, making sure
data is kept private to their respective owners or shared in
ways the owner can control. Proper authentication & authorisation
will have to be in place and data exchanges traced. Our plan
for security is to rely on open standards like OAuth2 and OpenID
Connect which are fully supported by FIWARE.




[dia-comp-infra.dia]: ./diagnose-compose.png
[sen-int-infra.dia]: ./sense-intervene.png
