KITT4SME Demo Cluster
---------------------
> We're in for some platform action!

This directory contains all the goodies you need to build an eensy-weensy
KITT4SME platform on, wait for it, your laptop. Yep, that's right.
It's basically an Istio service mesh running in Minikube, but with
a few tweaks you could easily build the platform on a fat Kubernetes
cluster if you have one. While this is just a proof of concept, all
the important bits and pieces to support the KITT4SME workflow are
actually there. Read on for the details.


### Why?

So [we want to build][intro.platform] the software infrastructure to
support the KITT4SME workflow and AI modules. The plan is to piggyback
on FIWARE to make data flow from the shop floor to the AI and back,
implement data persistence & security through open, interoperable
standards, and integrate the RAMP platform to be able to deploy
tailor-made AI kits. Sounds like fun.

With so many moving parts and components to integrate though, trying
to design the platform upfront without testing out our ideas could
get us a fat architecture doc with lots of shiny diagrams that in the
end is just a pie in the sky. How about a reality check each step of
the way instead? We can actually build working software to test out
our ideas about

* High-level design and cloud design principles;
* APIs for exchanging information among services;
* High-level design of persistence, data access & interoperability,
  security;
* Integration strategies (RAMP, AI modules);
* Guidelines for a platform reference implementation.

That's the purpose of this proof-of-concept thingie we've got here.


### A quick look at the cluster

The POC platform is an [Istio][istio] service mesh running in a
[Kubernetes][k8s] cluster. If you build it following the instructions
within this directory, you'll wind up with the whole Kubernetes
cluster inside a [Minikube][minikube]-managed VM. But if you've
done this kind of thing before, it should really be a no-brainer
to build the whole thing on top of a real, multi-node Kubernetes
cluster—famous last words. Either way, your freshly minted cluster
will host the essential building blocks of any respectable FIWARE
solution: an agent to provision and manage devices as well as to
collect data from and send commands to devices; a context broker
to provide a pub/sub bus for NGSI services and to manage the current
state of your IoT system; NGSI time series to record how your IoT
data changes over time. In fact the cluster features a Kubernetes
service for each of them: the [Ultralight Agent][ul-agent], the
[Orion][orion] context broker and [QuantumLeap][quantumleap] for
time series. Since Orion and Ultralight Agent like to stash away
their data in [MongoDB][mongodb], we have a MongoDB service too.
Also, [CrateDB][cratedb] is a popular choice for a QuantumLeap
back-end time series DB, so there's a CrateDB service as well.
Speaking of popular choices, a [Grafana][grafana] service to create
all sorts of monitoring dashboards rounds off the top picks you'll
find in the Kubernetes `default` namespace. You can see these guys
in the diagram below, among a bunch of other stuff I'm going to
touch on just now. (A dashed arrow from A to B means "A uses B".)

![KITT4SME demo cluster][cluster.dia]

The one thing you might've noticed in the diagram is how sparingly
the word "envoy" gets used—honestly, if you can think of a way to
tidy up the diagram, please go ahead and do it. Anyhoo, as a matter
of fact, each Kubernetes service pod in the `default` namespace gets
paired up with an Istio proxy, the "Envoy", to intercept any message
coming in from outside the cluster (ingress gateway), going out of
the cluster (egress gateway) or exchanged by pods within the cluster.
In service mesh parlance, data plane is the term for this "interception
network" and you can see it represented in the diagram as solid lines
connecting the various "envoys" to the Istio control plane.
On intercepting a message, the Envoy proxy processes it according to
the traffic management rules and security policies you set up in the
Istio control plane. For example, our ingress gateway is configured
to route HTTP traffic to FIWARE services depending on the URL prefix
of the HTTP request: `/orion/v2/entities` gets routed to the Orion
endpoint at `/v2/entities`, and so on. Also keep in mind message
interception underpins Istio's rich set of observability features
provided by these add-on services deployed in the `istio-system`
namespace:

* [Kiali][kiali]: visualise, monitor and configure your service
  mesh graph.
* [Jaeger][jaeger]: trace and visualise mesh communication flows.
  This is key to auditing as well as troubleshooting—e.g. figure
  out what the actual run-time service dependencies are and do
  root cause analysis, optimise performance and latency, etc. 
* [Prometheus][prometheus]: collect service metrics time series.
* Grafana: visualise service metrics time series. Notice this isn't
  the same Grafana service from earlier. It's actually a separate
  instance configured with a bunch of Istio dashboards and deployed
  in the `istio-system` namespace.

You can read more about how this gang of four complements Istio's
built-in telemetry [over here][istio.addons]. Another thing bolted
on to vanilla Istio is the [Open Policy Agent][opa] (OPA) which lets
you write security policies in a programming language (Rego) and
then evaluates them locally at each service by leveraging the Istio
Envoy proxy deployed alongside the service's pods. So we can write
complex policies at scale which would be a bit of a mission with
Istio's built-in YAML policies or FIWARE XACML. But we still rely
on Istio to secure communication for us so data is protected while
in transit—mutual TLS (mTLS) among services in the mesh, certificate
management, TLS termination, and so on. For single sing-on (SSO) and
identity & access management (IdM), we plonked down the mighty
[Keycloak][keycloak].

Last but not least, [Argo CD][argocd], a GitOps continuous delivery
framework, sits in its own namespace (`argocd`) and monitors our online
Git repo to automatically deploy any changes to the cluster config
we push to the repo. And that's how the whole cluster hangs together.
Now there's no stopping us from having some fun with it.


### Taking it for a spin

Ready to take the platform for a spin? Read on and fasten your seat
belt, hope you'll enjoy the ride! First off, build the cluster by
following the [installation instructions][poc.install]. Then deploy
the service stack as detailed in the [deployment instructions][poc.deploy].
If all went well, you should have a POC cluster in your hands that
looks pretty much the same as the one in the diagram above. Game on!

So now you're ready to test out your ideas through real-life service
workflows. You can look at the `scenarios` directory for some simple
examples:

* `versions`: scripts to hit the "version" endpoint of your FIWARE
  services.
* `basic-sense`: scripts to simulate the provision, subscribe and
  sense flows described in the architecture diagrams. Data, tenants,
  devices and all the rest are the same as those you'll see in the
  diagrams, so you should be able to work out what's going on quite
  easily. Also, after starting the sense script, you should get in
  to the Kiali console to have a look at service calls, data flows,
  metrics, traces and all the other nice things in there.

As an added bonus, if you followed the [deployment instructions][poc.deploy]
to a tee (you did, didn't you?!), then you've taken your first sip
of the compose secret potion. What's next? Try concocting your own
diagnose/compose and sense/intervene scenarios. Try integrating your
AI modules or RAMP dashboards. Fool around with persistence and
security. The world is your oyster! Oh, it'll be nice if you could
share your scenarios or even better put together some scripts to
help others reproduce what you've done :-)




[argocd]: https://argoproj.github.io/argo-cd/
[cluster.dia]: ./poc-cluster.png
[cratedb]: https://crate.io/
[grafana]: https://grafana.com/
[intro.platform]: ../arch/intro/platform.md
[istio]: https://istio.io/
[istio.addons]: https://github.com/istio/istio/tree/1.9.1/samples/addons
[jaeger]: https://www.jaegertracing.io/
[k8s]: https://kubernetes.io/
[keycloak]: https://www.keycloak.org/
[kiali]: https://kiali.io/
[minikube]: https://minikube.sigs.k8s.io/
[mongodb]: https://www.mongodb.com/
[opa]: https://www.openpolicyagent.org/
[orion]: https://github.com/telefonicaid/fiware-orion
[poc.install]: ./deployment/install.md
[poc.deploy]: ./deployment/deploy.md
[prometheus]: https://prometheus.io/
[quantumleap]: https://github.com/orchestracities/ngsi-timeseries-api
[ul-agent]: https://github.com/telefonicaid/iotagent-ul
