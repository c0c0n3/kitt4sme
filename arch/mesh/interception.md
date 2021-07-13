Service mesh
------------
> ...what a mesh.

The KITT4SME platform relies on a dedicated cluster software infrastructure
referred to as "mesh infrastructure" in this document. A key function
of this mesh infrastructure is to implement a network of intermediaries
to transparently route and balance service traffic, secure communication
and access to service resources, and monitor service operation. The
particular arrangement of communicating entities and the communication
pattern are essential aspects of the mesh infrastructure, thus we examine
these aspects here.


The central idea is to augment system functionality at runtime by means
of message interception and manipulation. The mesh interposes a network
of intermediaries (proxies) between services and clients to prevent
direct communication by intercepting application traffic destined for
or originating from services. Each service is paired with a proxy to
form a composite service which appears to be the actual service to
other communicating entities. Behind the scenes, the proxy manages
connections on behalf of the service and employs extensible pipelines
to process both incoming and outgoing messages. After processing a
message the proxy may forward a possibly altered message to its intended
destination or may discard the original message altogether and notify
the sender if appropriate. A mesh management component allows to deploy
the network of proxies, program proxy connection and message processing
functions, and observe mesh runtime behaviour.

Communicating entities within the mesh are grouped in three layers:
control plane, data plane and services. The control plane contains
the processes that constitute the management component. The proxies
and the network in which they are connected form the data plane.
Services and clients exchange application-level messages in the service
layer. Service and client processes have no knowledge of the control
and data plane and perform their tasks by exchanging messages according
to an application protocol such as HTTP. In other words, processes in
the service layer provide their functionality independently of the mesh
infrastructure and can function without it. However, the mesh can augment
service functionality by means of controlling connections and network
traffic. As an example, proxies can secure service calls according to
policies configured in their message processing pipelines, requiring
no changes to service code.

Thus, the mesh communication pattern revolves around a proxy observing
and possibly altering a message flow in order to enrich service functionality.
The following diagram illustrates the communication pattern in the case
of a request-reply protocol such as HTTP. A mesh manager component has
deployed a proxy alongside a service so that communication involving
the service can only happen through the proxy. (Typically, this is
achieved by routing network packets.) A proxy configuration interface
allows the mesh manager to instruct the proxy to operate according to
the current mesh configuration. Thus, as soon as the administrator
(not shown in the diagram) specifies new rules (e.g. a security policy
update), the mesh manager reconfigures the proxy accordingly. Then, a
client sends a request to the service. The proxy intercepts and processes
the request (e.g. to enforce access control), outputting a modified
request (e.g. with client credentials removed) that it forwards to
the service. Similarly, the proxy processes the service reply to produce
a variant that it returns to the client. Periodically, the proxy sends
telemetry data to the mesh manager so that the platform administrator
can monitor the system, e.g. by analysing performance metrics, distributed
traces and logs.

![Mesh communication pattern.][dia.com-pattern]

In conclusion, the mesh infrastructure allows to implement additional
system features independently of services and without requiring any
modification to them. The KITT4SME platform exploits this infrastructure
to achieve separation of application concerns from operational concerns.
Specifically, the following functionality is implemented in the mesh
infrastructure rather than in the platform services: routing and load
balancing, automatic retries and failover, connection encryption,
identity-based mutual authentication, access control, rate limits and
quotas, distributed traces, log aggregation, and performance metrics.
A subsequent part of this document outlines the implementation of these
features.




[dia.com-pattern]: ./mesh-com-pattern.png
