ArgoCD
------
> Resources to set up our POC ArgoCD instance.

The `install.yaml` we have in here is basically the same as the one
you'd use to install ArgoCD `1.8.7`, e.g.

    $ kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v1.8.7/manifests/install.yaml

except for a few tweaks that'll make our life slightly easier. First
off, I added a couple of flags to the command to start the ArgoCD server
in the K8s `argocd-server` deployment resource

* `--insecure`, to run the sever without TLS. We don't need this since
  we'll use Istio to handle certs and do TLS termination. This is what
  you're supposed to do anyway if you have e.g. a load balancer fronting
  the ArgoCD server, see explanation in the [ArgoCD docs][ingress].
* `--disable-auth`, to skip client authentication for convenience. We
  won't need it for the POC right now, but we can turn it on later.

Also for extra convenience, I turned the K8s original `argocd-server`
service into a `NodePort` service to be able to access ArgoCD from
outside the Minikube cluster on port `8080`. (Yes, I also had to add
a `nodePort` to the service definition for that to work.) Again, later
on we can make security airtight, but for now let's keep it simple.


### Regular install

For the record, here's what you'd do to install ArgoCD `1.8.7` without
the tweaks above I made for the POC. First, install ArgoCD in the cluster

    $ kubectl create namespace argocd
    $ kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v1.8.7/manifests/install.yaml

Then you should also install the `argocd` command on your box, e.g.
for MacOS

    $ brew install argocd  # or whatever you do on your platform

Now expose the ArgoCD API server through K8s port forwarding in another
terminal

    $ kubectl port-forward svc/argocd-server -n argocd 8080:443

Finally, set up admin credentials

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




[ingress]: https://argo-cd.readthedocs.io/en/release-1.8/operator-manual/ingress/
