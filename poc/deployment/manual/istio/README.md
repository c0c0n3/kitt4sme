Istio
-----
> Resources to set up our POC Istio instance.

The `demo-profile` we have in here is basically the same as Istio
`1.9.1`'s own [demo profile][profile], i.e. the one you'd get if
you ran

    $ istioctl install --set profile=demo

but I set `nodePort` values for some of the ingress gateway ports
to stop Minikube from assigning them random numbers so we can e.g.
use port `80` for HTTP traffic from outside the cluster instead of
whatever random number. Obviously, those ports will have to be
available on your box when the cluster boots. Have a look at the
`nodePort` values in the file to see what ports we need.

The files in the `addons` dir got lifted as is from Istio `1.9.1`'s
[samples dir][addons] and stashed here for convenience since we only
install some of the addons: Grafana, Jaeger, Kiali and Prometheus.
[Istio's addons README][addons] tells you what these guys do within
Istio, give it a read.




[addons]: https://github.com/istio/istio/tree/1.9.1/samples/addons
[profile]: https://github.com/istio/istio/blob/1.9.1/manifests/profiles/demo.yaml
