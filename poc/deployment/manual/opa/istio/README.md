OPA/Istio
---------
> Resources to integrate OPA with Istio.

So I thought it'd be easy enough to just follow the procedure outlined
in the official OPA Envoy Plugin [repo][plugin] but it turned out to be
quite tricky—I sketched out what I did in the Failed attempt section
below. Luckily the Istio guys [have been working][istio-ext-authz] on
integrating OPA too and their approach actually worked for me. In fact,
the `standalone.yaml` file in here is something I lifted from their
blog post. It deploys a single OPA instance for the whole mesh instead
of one for each sidecar which is in general a better option to keep
latency low. Anyhoo, that wouldn't be difficult to do, it's just that
I'm too lazy to get it done :-)


### Failed attempt

For the record, I tried setting up OPA inside Istio using the official
[OPA Envoy Plugin][plugin] but I failed miserably. In fact, I tried
tweaking [their Istio example][istio-example] just slightly, but I
couldn't manage to get it to work so I eventually gave up. This is what
I did

1. Copy the content of `quick_start.yaml` in the [example dir][istio-example]
   at commit `a537d7b` to `setup.yaml`.
2. Replace their demo policy w/ mine: `rego/fiware/service.rego`.
3. `$ kubectl apply -f poc/deployment/manual/opa/istio/setup.yaml`
4. `$ kubectl label namespace default opa-istio-injection="enabled"`
5. Make a change to `auto/orion.yaml` and redeploy.

Result:

1. Getting Orion's version with a valid Authorization header and FIWARE
   service as in the examples in `rego/` returns a `503`
2. Sidecar logs report:

```
[2021-04-06T10:42:46.533Z] "GET /orion/version HTTP/1.1" 503 UAEX ext_authz_error - "-" 0 0 1 - "172.17.0.1" "curl/7.64.1" "36362423-0667-93f9-aa98-a5eb258e5ec1" "192.168.64.15" "-" - - 172.17.0.19:1026 172.17.0.1:0 outbound_.1026_._.orion.default.svc.cluster.local -
2021-04-06T10:49:31.709949Z	warning	envoy config	StreamAggregatedResources gRPC config stream closed: 0,
```

On a side note, their `MutatingWebhookConfiguration` adds an OPA instance
to each pod in a namespace of your choice. If you need more flexibility,
just replace `namespaceSelector` with `objectSelector` so the OPA proxy
only gets added to e.g. deployment resources labelled with

    opa-istio-injection: enabled

as in

    kind: Deployment
    metadata:
      labels:
        app: orion
        opa-istio-injection: enabled




[istio-example]: https://github.com/open-policy-agent/opa-envoy-plugin/tree/master/examples/istio
[istio-ext-authz]: https://istio.io/latest/blog/2021/better-external-authz/
[plugin]: https://github.com/open-policy-agent/opa-envoy-plugin
