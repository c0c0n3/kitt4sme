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

