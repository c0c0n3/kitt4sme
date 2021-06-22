RESTful services
----------------
> Have a REST buddy.

Most KITT4SME platform services are expected to expose their functionality
through Web interfaces in accordance with the REpresentational State
Transfer (REST) architectural style. Web services adhering to REST
principles are known as RESTful services. As a distributed architecture
style, REST is grounded in the client-server paradigm whereby clients
communicate with services over a network by exchanging request and
response messages as specified by the HyperText Transfer Protocol (HTTP).
(Strictly speaking, REST does not mandate HTTP as a communication protocol,
but in practice, at least from an interoperability standpoint, no other
viable protocol choice exists.)

### Service APIs
A KITT4SME RESTful service makes (representations of) its resources
available as Web resources, each identified by a unique resource locator
(URL), and provides its functionality to clients only through basic
create, read, update, and delete operations on these resources. For
each resource R, the service specifies which of the basic operations
are available (some resources may only support a subset of the operations),
the effect of invoking them (i.e. how create, read, update, and delete
operations on R are interpreted in terms of service functionality),
and, for each operation, the corresponding HTTP method to be used for
invocation (GET, POST, etc.) as well as the data formats (typically
JSON) available for encoding R’s state (i.e. the resource representation)
in HTTP messages. All together, this information constitutes the so-called
RESTful service API specification to which clients need to adhere in
order to interact with the service in a meaningful manner.

### Uniform invocation
However, the operation invocation mechanism is independent of resources,
services and API specifications. Given any URL, a client can invoke any
operation on the resource identified by that URL by sending a suitable
HTTP request to the host in the URL. The request contains the name of
the operation (GET, POST, etc.) to perform and the URL's path component,
which locates the resource within the service context. The service responds
with a message indicating the outcome of performing that operation and
possibly a resource representation or the location (URL) where to retrieve
one if applicable. The HTTP protocol defines the semantics of each operation
(GET, POST, etc.) in terms of its effect on the (state of the) target
resource, thus affording clients a uniform mechanism to invoke operations
on resources across all services. (This architectural constraint is
known as the uniform interface principle in the REST literature.)
For example, if service A offers resource X at `http://a/x` and service
B resource Y at `http://b/y`, the client can retrieve either resource
with the same mechanism, by invoking a read operation through an HTTP
GET request, i.e. `GET /x` on host `a` and `GET /y` on host `b`, respectively.
Take heed: notwithstanding this uniform invocation interface, clients,
in general, still need service API specifications to be able to request
service functionality meaningfully. In fact, HTTP data manipulation
operations such as POST permit arbitrary service side-effects of which
the client cannot be aware without a service specification. For instance,
even if a client knew of a resource X at `http://svc/x`, how could it
possibly determine the meaning, in terms of service functionality, of
invoking the POST operation on X? Perhaps X is a device reading and
POSTing a new X adds it to the collection of all X readings or perhaps
X is a command to operate a conveyor belt in a factory. Or perhaps
something else altogether.

### Stateless communication
Communication is stateless from the service's standpoint, thus a service
can understand and process each client request in isolation. In other
words, to fulfill a request, a service takes into account only the
request data and the current state of the request's target resource.
Consequently, a service does not need to retain any information from
previous requests to process the current request. If state is to be
maintained between requests, it is the client's responsibility to make
provisions accordingly and include any information about past requests
in the current should the service need that information to process the
current request.

### Caching
KITT4SME services and clients should exploit HTTP caching whenever possible.
HTTP offers a basic caching facility whereby services specify, through
response headers, a period of time during which a resource representation
can be reused as is without retrieving it again from the service and
clients can determine, through requests headers, whether a cached
representation is still current after it becomes stale. Services should
employ response headers to specify for how long clients can cache a
resource representation. Clients should cache representations as needed
to avoid issuing new requests which would result in retrieving the exact
same data, thus wasting precious computational resources.

### Separation of concerns, performance and resilience
Stateless communication and a uniform invocation interface facilitate
the implementation of a layered architecture where any number of intermediaries
can be interposed between clients and services to attain separation
of concerns. Intermediaries can enrich services with non-functional
features (e.g. security) and enhance overall quality of service (e.g.
performance) transparently (i.e. with no knowledge of the communicating
parties) and without requiring any modification of service or client
code. As we shall see shortly, the KITT4SME platform implements a network
of intermediaries to transparently route and balance service traffic,
secure communication and access to service resources, and monitor service
operation.

In particular, the KITT4SME platform infrastructure leverages service
intermediaries to enhance performance and recover from service failures,
thus increasing overall service availability. The basic idea is to maintain,
for each nominal service, a pool of actual service processes (replicas)
and have a load balancer distribute incoming requests to the processes
in the pool. Any process in the pool can safely handle any incoming
request by dint of stateless communication, thus new processes can be
added to the pool to meet an increased service demand or replace failed
processes as the case may be. By the same token, processes can be removed
from the pool as service load abates, thus saving computational resources.
Web (proxy) caches within the platform infrastructure also save computation
and enhance performance. This is especially so in the case of time series
acquired from the shop floor since each series contains historical data
which can potentially be cached indefinitely.
