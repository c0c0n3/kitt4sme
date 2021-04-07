KITT4SME Demo Cluster Installation
----------------------------------
> One-off procedure to build & set up your cluster.

**TODO**: use Nix or Guix to automate the procedure below and to make
it reproducible! Ideally, I'd like to be able the bring up a fully
functional cluster from scratch with a single command, e.g.

    $ nix build -A kitt4sme.cluster

But for now, manual procedure it is :-)
So here goes.


### 1. Install Minikube & prep cluster

[Minikube][minikube] will run the whole shebang. So you've got to install
it along with Docker and `kubectl`. Here's my versions, later ones should
do too:

* Minikube `1.15.1` (uses Kubernetes `1.19.4` on Docker `19.03.13`)
* `kubectl` client `1.19.6`

Prep your Minikube cluster

    $ minikube start -p kitt4sme --memory=8192 --cpus=4 \
                     --extra-config=apiserver.service-node-port-range=1-65535
    $ kubectl config use-context kitt4sme

Notice how we [broaden Minikube's port range][minikube.node-port].
This is to make sure it'll be able to expose any K8s node port we're
going to use.

If you want to start from scratch again, you can just zap the whole
Minikube cluster with

    $ minikube stop -p kitt4sme
    $ minikube delete -p kitt4sme


### 2. Istio

We'll use [Istio][istio] to build a FIWARE service mesh. We tested
with Istio `1.9.1` so you'll have to install version `1.9.1` of the
`istioctl` command. One way of doing that is to download the Istio
`1.9.1` bundle, `cd` in there and add the `bin` dir to your path

    $ curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.9.1 sh -
    $ cd istio-1.9.1
    $ export PATH=$PWD/bin:$PATH

(Ideally, you should add the `bin` dir to your shell profile so it'll
be still there next time you start a terminal.) Now install Istio's
core and telemetry addons---Grafana, Jaeger, Kiali and Prometheus:

    $ cd /path/to/kitt4sme
    $ istioctl install -f poc/deployment/manual/istio/demo-profile.yaml \
                       -y --verify
    $ kubectl apply -f poc/deployment/manual/istio/addons

A bit more detail about all this stuff is [over here][deploy.istio].
This installation profile isn't configured for prod, but it has all
the services we'll need---Istio core, ingress/egress, and dashboards.
FIWARE services will sit in K8s' `default` namespace, so tell Istio
to automatically add an Envoy sidecar to each service deployed to
that namespace

    $ kubectl label namespace default istio-injection=enabled


### 3. OPA

We'll use [Open Policy Agent][opa] to secure our services. In fact,
we've got a Rego policy to check for service tokens before granting
access to FIWARE API endpoints. First thing to do is to create a K8s
secret containing that policy

    $ kubectl create secret generic opa-policy \
        --from-file poc/deployment/manual/opa/rego/fiware/service.rego

Then deploy an OPA service in the `default` namespace.

    $ kubectl apply -f poc/deployment/manual/opa/istio/standalone.yaml

Put the finishing touches to our setup by telling Istio to delegate
custom authentication actions to our OPA guy

    $ EDITOR=emacs kubectl edit configmap istio -n istio-system
    # ^ replace w/ yer fave

add the following `extensionProviders` stanza

```yaml
apiVersion: v1
data:
  mesh: |-
    # Add the following contents:
    extensionProviders:
    - name: "opa.default"
      envoyExtAuthzGrpc:
        service: "opa.default.svc.cluster.local"
        port: "9191"
```

Notice there's an Istio custom authz policy in the `auto` dir that'll
get deployed later automatically and that configures the ingress gateway
to forward traffic to our OPA service. Also, there's a bit more info
about our OPA setup [over here][deploy.opa].


### 4. ArgoCD

We'll use [ArgoCD][argocd] to implement a GitOps workflow whereby any
changes we make to the K8s descriptors in our repo get deployed automatically
to the cluster. The two commands below will install ArgoCD `1.8.7` in
our Minikube cluster

    $ kubectl create namespace argocd
    $ kubectl apply -n argocd -f poc/deployment/manual/argocd

Now you should be able to reach the ArgoCD server on port `8080` from
outside the cluster, e.g. on MacOS

    $ open http://$(minikube ip -p kitt4sme):8080
    # use e.g. xdg-open on Linux, or just the name of your browser command

should get you straight into the ArgoCD Web UI---I disabled login for
extra convenience and tweaked a couple of things to make our life easier,
details [over here][deploy.argocd].

At this point we're ready to create an ArgoCD app to monitor our repo
and deploy stuff as it changes. You can do that in the ArgoCD UI, but
rather install the ArgoCD command line tool since it'll come in handy
later for local deployments. To install on MacOS with Homebrew

    $ brew install argocd

(Read the ArgoCD docs for alternative ways to install the tool.)
This command creates our `kitt4sme` ArgoCD app

    $ argocd app create kitt4sme \
        --server "$(minikube ip -p kitt4sme):8080" --plaintext \
        --repo https://github.com/c0c0n3/kitt4sme \
        --path poc/deployment/auto --directory-recurse \
        --dest-namespace default --dest-server https://kubernetes.default.svc

Notice we asked ArgoCD to deploy any K8s YAML descriptors found in the
`poc/deployment/auto` directory (and sub-directories) but we specified
no sync strategy so we can trigger the sync ourselves later on and see
how all the bits and pieces get deployed.


### 4. Sanity check

Double-check you're able to get into the ArgoCD Web UI

    $ open http://$(minikube ip -p kitt4sme):8080
    # use e.g. xdg-open on Linux, or just the name of your browser command

You should be able to see the `kitt4sme` app but none of its services
should've been deployed. Start Istio's Kiali dashboard to see what's
going on in your freshly minted cluster

    $ istioctl dashboard kiali

You should be able to see the Istio services running happily in the
`istio-system` namespace as well as the ArgoCD ones in the `argocd`
namespace, but there should be no FIWARE services in the `default`
namespace yet. Cluster ready, mission accomplished, cool bananas!




[argocd]: https://argoproj.github.io/argo-cd/
[deploy.argocd]: ./manual/argocd/README.md
[deploy.istio]: ./manual/istio/README.md
[deploy.opa]: ./manual/opa/istio/README.md
[istio]: https://istio.io/
[minikube]: https://minikube.sigs.k8s.io/
[minikube.node-port]: https://minikube.sigs.k8s.io/docs/handbook/accessing/#getting-the-nodeport-using-kubectl
[opa]: https://www.openpolicyagent.org/
