KITT4SME Demo Services Deployment
---------------------------------
> Deploying FIWARE services to your cluster.


### 1. First deployment

Earlier on we didn't ask ArgoCD to automate deployment so we could
see it happen for the first time. So we've got to the point where
it's time to hit the deployment button! Browse to the ArgoCD UI

    $ open http://$(minikube ip -p kitt4sme):8080
    # use e.g. xdg-open on Linux, or just the name of your browser command

and hit the "Sync" button on the `kitt4sme` app panel. ArgoCD should
fetch all our K8s YAML files sitting in the `poc/deployment/auto`
directory within the online repo and deploy an eensy-weensy FIWARE
stack we can play with. If you click on the app panel you should see
the K8s `default` namespace getting populated with the services
specified in `poc/deployment/auto`. Plus, if you open up the Kiali
dashboard

    $ istioctl dashboard kiali

you should be able to see the same services there too.


### 2. Regular deployments

So we've got an idea of what's happening under the bonnet. Now get
back into the ArgoCD UI and enable "auto-sync" for the KITT4SME app,
make some changes to the K8s YAML in `poc/deployment/auto`, commit,
and watch your changes being applied. Notice that since we specified
`poc/deployment/auto` as a sync path when creating the app, ArgoCD
will ignore any changes you commit to the repo that aren't in this
dir. Also there's a sort of backdoor feature that comes in very handy
for developing & testing your config locally without having to commit
every little experiment you make: you can use the CLI to force a sync
from your file system.

    $ argocd app sync kitt4sme \
             --server "$(minikube ip -p kitt4sme):8080" --plaintext \
             --local ./poc/deployment/auto

(In general, you should only be doing this with a test cluster or a
local cluster otherwise your GitOps benefits fly out of the window!)


### 3. Accessing services from outside the cluster

The load balancer exposes a bunch of ports to clients outside the
cluster. (Make sure those ports are available on your box when you
start Minikube.) First, port `80` (`443`) is where HTTP(s) service
traffic goes through. Second, the ArgoCD, CrateDB and Grafana Web
UIs are, respectively, at ports `8080`, `4200` and `3000`. Here's
the list of entry points:

* Orion: `http://$(minikube ip -p kitt4sme)/orion`
* QuantumLeap: `http://$(minikube ip -p kitt4sme)/quantumleap`
* Ultralight Agent—provisioning: `http://$(minikube ip -p kitt4sme)/iota-north`
* Ultralight Agent—data: `http://$(minikube ip -p kitt4sme)/iota-south`
* ArgoCD UI: `http://$(minikube ip -p kitt4sme):8080`
* CrateDB UI: `http://$(minikube ip -p kitt4sme):4200`
* Grafana UI: `http://$(minikube ip -p kitt4sme):3000`

Plus, don't forget you can easily get Istio to open a browser with
Kiali's UI

    $ istioctl dashboard kiali

and that works for the Grafana mesh performance dashboards too

    $ istioctl dashboard grafana


### 4. Convenience scripts

If you get tired of typing up those URLs every time, you can `source`
the `env.sh` Bash script in the `scripts` dir that'll put them all in
Bash variables for you. Also in the `scripts` directory, there's some
Bash scripts that could come in handy

* `ministart.sh` starts your Kitt4sme Minikube cluster and switches
   K8s context accordingly. If the cluster isn't there, it makes a
   new one for you.
* `ministop.sh` stops your Kitt4sme Minikube cluster if it's running.
* `argocd.depoy-local.sh` forces ArgoCD to do a backdoor local
   deployment. Any files in your local `./auto/` dir get deployed,
   recursively. (This is the kind of local deployment we mentioned
   earlier on.)
* `ui.argocd.sh` opens a browser window to navigate to the ArgoCD UI.
* `ui.crate.sh`, same as above but gets you in the CrateDB UI.
* `ui.grafana.sh`, same but for Grafana.

Notice the last three UI scripts use the command specified by `OPEN_URL_CMD`
(defined in `env.sh`) to call your fave browser. It defaults to `open`
which will only work on MacOS, so replace `open` with whatever works
on your box, e.g. `xdg-open` on Linux or just the name of your browser
command, like `firefox`.

