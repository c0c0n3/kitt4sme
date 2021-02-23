Demo
----

Prep Minikube

    $ minikube start -p argocd-demo --memory=16384 --cpus=4
    $ kubectl config use-context argocd-demo

Install ArgoCD in the cluster and the CLI locally

    $ kubectl create namespace argocd
    $ kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    $ brew install argocd

Expose the ArgoCD API server through K8s port forwarding in another
terminal

    $ kubectl port-forward svc/argocd-server -n argocd 8080:443

Set up admin credentials

    # grab initial password (see note below)
    $ export ARGOCD_INITIAL_PASSWORD=`kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2`
    
    # make sure you can actually login
    # (hit 'y' to ignore self gen cert warning)
    $ argocd login localhost:8080 --username admin --password "${ARGOCD_INITIAL_PASSWORD}"
    
    # change password
    # (hit 'y' to ignore self gen cert warning)
    $ argocd account update-password --account admin --current-password "${ARGOCD_INITIAL_PASSWORD}" --new-password 'abc123'

###### Note
The password trick works for Argo CD 1.8 and earlier, but won't work for 1.9.

Create demo app

    $ argocd app create orion \
        --repo https://github.com/c0c0n3/kitt4sme.wp2 \
        --path middleware/poc/deployment/plain-k8s \
        --dest-namespace default --dest-server https://kubernetes.default.svc \
        --directory-recurse

We specified no sync strategy so we can trigger the sync ourselves and
see how all the bits and pieces get deployed. Log on to Web UI

* https://localhost:8080/
* user: `admin`; password: `abc123`

Hit the sync button and watch Orion and MongoDB being deployed. As soon
as you get a green tick mark, you can have some fun with Orion

    # expose Orion's port, then...
    $ kubectl port-forward svc/orion 1026:1026

    # ...in another terminal
    $ curl -v localhost:1026/v2

Now enable "auto-sync" for the Orion app in ArgoCD, make some changes
to the K8s YAML in `plain-k8s`, commit, and watch your changes being
applied. Notice that since we specified `plain-k8s` as a sync path when
creating the app, ArgoCD will ignore any changes you commit to the repo
that aren't in this dir. Also there's a sort of backdoor feature that
comes in very handy for developing & testing your config locally without
having to commit every little experiment you make: you can use the CLI
to force a sync from your file system. (Obviously you should be using
a test cluster or a local cluster otherwise your GitOps benefits fly
out of the window!)

    $ argocd app sync orion --local ./plain-k8s
