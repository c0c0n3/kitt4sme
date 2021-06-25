IoT provisioning
----------------
> E.T. phone home...

Device provisioning is the process of interfacing external IoT devices
at a factory to the KITT4SME platform. Building on the analysis of
Agents and provisioning presented in the information model, the current
section delves into the provisioning process proper.


### The provisioning workflow

KITT4SME platform services interact with the factory IoT environment
in order perform Sense and Intervene tasks within the KITT4SME workflow.
Data flow from IoT devices to the platform where services analyse them
to construct a digital representation of the shop floor's current state.
Data also travel from the platform to the IoT devices as AI services
issue commands to steer the shop floor towards the desired production
goals. FIWARE Agents mediate interactions between external devices and
platform services as well as facilitating the data flow by translating
device data into instances of NGSI entities in accordance with the
KITT4SME data models.

Before IoT devices at a factory can play an active role in any Sense
and Intervene task, both the devices and the Agent layer within the
platform have to be configured to work together. This entails creating
device configurations in the Agents database and supplying transformations
from device data to NGSI entities as well as programming devices to
send data to Agents and/or receive commands from them. Whereas FIWARE
Agents afford the platform administrator a uniform way to define device
configurations and data transformations by means of a device management
REST API, the procedure required to configure physical devices to interact
with the Agents typically varies from device to device and may also
entail programming device gateways external to the KITT4SME platform.
Thus, the remainder of this section explains the provisioning procedure
from the platform standpoint, intentionally omitting any device-specific
details.

The provisioning workflow begins with grouping physical devices having
similar characteristics. Devices in the same group communicate with
the KITT4SME platform using the same protocol and produce data that
can be mapped to instances of the same NGSI entity type `T`. As Agents
mediate communication between the devices and the platform, the communication
protocol in question has to be among the ones implemented by the Agents.
In this regard note that a wide array of protocols are available,
ranging from the general purpose such as HTTP and MQTT, to the
industrial-automation-orientated such as OPC UA and ROS. (It is also
possible to implement new protocols by leveraging the Agent core
framework.)

To each conceptual device group has to correspond a `ServiceGroup` object
in the Agents database. Recall that a `ServiceGroup` defines the Agent
service endpoint with which the physical devices in the group interact
and specifies the URL of the Context Broker to which data should be
forwarded after having being transformed into an NGSI entity. Thus,
each `ServiceGroup` in the Agents database defines a (virtual) communication
link between the devices in the group and a given Context Broker service.
To create a `ServiceGroup`, an HTTP `POST` request is sent to the
`/iot/services` device management API endpoint of one of the platform
Agent services which can handle the communication protocol used by the
devices in the group. The HTTP request body contains the JSON representation
of the `ServiceGroup` to create. Additionally, the request contains
two headers: `fiware-service` and `fiware-servicepath`. The former identifies
the platform tenant owning the data produced by the devices in the
group (typically the company owning the factories where the devices
are located), whereas the latter pinpoints NGSI entities within the
tenant's own entity hierarchy by means of a tree path as explained in
the information model section. These entities are instances of the same
NGSI entity type `T` shared by all the devices in the group.

Note that for a device at a factory to send data to the platform, the
device needs to know to which `ServiceGroup` it belongs. For the purpose
of device-to-agent communication, the API key field of a `ServiceGroup`
identifies the group. When sending data to the Agent endpoint, a device
has to include the API key of the group to which it belongs. Consequently,
devices (or device gateways) have to be programmed to send messages
to the platform as expected by the Agent interface. Although this is
an integral part of the provisioning process, as already mentioned,
implementation procedures will vary from device to device and are outside
the scope of this document.

Having created a `ServiceGroup` and configured the physical devices,
the next step in the provisioning workflow entails adding device digital
twins to the `ServiceGroup`. For each physical device in the group,
there needs to be a corresponding `Device` object linked to the `ServiceGroup`
object in the Agents database. This `Device` object contains a pointer
to a target NGSI entity (of type `T`) and a translation map to convert
incoming device data to the target entity. On receiving data from the
physical device, the Agent uses this information to turn the incoming
payload into a `T` instance `e` and create or replace the target entity
in Context Broker with `e`, as the case may be.
To add a `Device` to a `ServiceGroup`, an HTTP `POST` request is sent
to the `/iot/devices` endpoint of the same Agent service used to create
the `ServiceGroup`. The HTTP request body contains the JSON representation
of the `Device` to create. Moreover, the request must have the same
`fiware-service` and `fiware-servicepath` headers initially used to
create the `ServiceGroup` to ensure the links among `ServiceGroup`,
`Device` and target NGSI entity are established within the entity
hierarchy of the correct tenant.

In conclusion, from the KITT4SME platform standpoint, the provisioning
workflow is performed by making HTTP calls to the Agent layer to create
suitable `ServiceGroup` and `Device` objects. The platform administrator
can make these calls from a terminal using command line tools such as
`curl`. A better option would be to offer a Web user interface to facilitate
the provisioning process and the management of large device sets. There
exists a number of proprietary user interfaces which could be integrated
in the platform for this purpose and, at the time of writing, licensing
schemes are being examined that would allow proprietary software to be
packaged with the core open-source KITT4SME platform infrastructure.


### Provisioning in action

The UML (custom) communication diagram below exemplifies the provisioning
workflow discussed thus far. The scenario shown in the diagram depicts
the configuration (within KITT4SME) of devices owned by a platform tenant.
As in the Sense-Intervene example presented in the introduction, there
are two tenants, ManuFracture and Smithereens, sharing a common NGSI
data model with a `Bot` entity type to represent device data. Similarly,
devices produce two kinds of measurements, labeled `f` and `b` respectively.
`Bot` carries a `foo` attribute meant to hold `f` values and a `bar`
attribute for `b` values. Furthermore, the devices to be provisioned
use the HTTP protocol to send their readings to external software and
an Agent service `H` has been deployed to the platform that can handle
device communication over HTTP.

ManuFracture have fitted a number of these devices to two of their shop
floors and are now ready to connect them to the KITT4SME platform. They
have decided to group devices by the shop floor in which they are located.
Accordingly, they have designed a simple NGSI entity hierarchy tree
with an inner node in correspondence of each shop floor. In particular,
`floor1` is an inner node representing one of the two shop floors. It
is meant to have `Bot` entities as children storing data collected from
the `foodev` and `foobar` devices at that shop floor. (In the diagram,
each `Bot` entity under `floor1` is named after the corresponding physical
device producing the data.) The top right-hand side of the diagram
shows the envisaged entity hierarchy whereas the bottom right-hand
side displays the `ServiceGroup` and `Device` objects that will be
created during the provisioning procedure described below.

![Provisioning devices.][dia.provisioning]

#### Creating a service group
To begin the provisioning process, the platform administrator sends
Agent `H` an HTTP request to create a new `ServiceGroup` for `floor1`
devices. As shown by step 1 in the diagram, the request is a `POST`
message destined for the `/iot/services` endpoint.

The enclosed request body is a JSON representation of the `ServiceGroup`
to create. It carries an API key field and the type of the NGSI entities
(`Bot`) that will store data originating from devices in the group:

    {
        "apikey":      "3z4w",
        "cbroker":     "http://orion:1026",
        "entity_type": "Bot",
        "resource":    "/iot/d"
    }

Note that it is the responsibility of the platform administrator to
ensure that API keys are unique within the platform. Often administrators
use UUIDs for API keys to ensure uniqueness. The `resource` field of
the JSON object defines the URL path (`/iot/d`) which devices in the
group will use to send the Agent HTTP requests containing sensor readings.
As explained in the information model section, a physical device with
an ID of `x` in this service group, would send Agent `H` data at
`/iot/d?i=x&k=3z4w`. (Note the `k` query parameter set to the group's
API key in order to identify the `ServiceGroup` object containing the
platform `Device` instance paired to the physical device.) Finally,
the `cbroker` field instructs Agent `H` to store device data as NGSI
entities in the Context Broker service listening to port `1026` on host
`orion`. The platform administrator should use a mesh host name and
port combination rather than a physical address so that the mesh can
manage a distributed Context Broker service (i.e. a logical service
comprising several server processes possibly on different machines)
and apply traffic management rules to HTTP requests between the Agent
and the Context Broker service.

The service group has to be instantiated in the correct data context,
i.e. within the data owned by the platform tenant for which the group
is being created. For this reason, the HTTP request includes two FIWARE
headers. The `fiware-service` header indicates that the `ServiceGroup`
is to be created in the tenant data space identified by the `ManuFracture`
label. (It is common practice to name platform tenants after real-life
tenants as in our running example where ManuFracture, the company, is
identified, as a platform tenant, by the string `ManuFracture`.) The
`fiware-servicepath` header, set to `/floor1`, pinpoints the ManuFracture
entity hierarchy node under which will be stored `Bot` entities containing
device data originating from shop floor `floor1`.

#### Populating the service group with devices
Having created a `ServiceGroup` for shop floor `floor1`, the platform
administrator proceeds to add device digital twins (`Device` objects)
to this group. There are two physical devices on `floor1`,`foodev` and
`foobar`, which have to be interfaced with the platform. Step 2 in the
diagram shows how the platform administrator uses the Agent device
management API to configure a `Device` object for `foodev`. (The other
device would be configured similarly.)

In detail, the administrator sends Agent `H` an HTTP `POST` request
to create a new `Device` object to represent the physical device referred
to as `foodev`. The request URL is `/iot/devices` and the request body
contains a JSON representation of the `Device` to create:

    {
        "device_id":   "foodev",
        "entity_name": "urn:ngsi-ld:manufracture:Bot:1",
        "entity_type": "Bot",
        "attributes": [
            { "object_id": "f", "name": "foo",
              "type": "Integer" },
            { "object_id": "b", "name": "bar",
              "type": "Integer" }
        ]
    }

The `device_id` field uniquely identifies the physical device within
the platform, which is why the device must include this ID when sending
data to the Agent during the Sense phase. (As noted earlier, in the
case of HTTP communication, the device inserts its ID in the query
string of the request URL.) The `entity_name` contains the ID of the
target NGSI entity where `foodev` data are ultimately stored after
having been translated into NGSI format.

The posted JSON object contains a data transformation specification
which enables the Agent to convert incoming `foodev` data into `Bot`
entities. In fact, the `entity_type` and `attributes` fields define
a translation map. The `entity_type` field requires that incoming `foodev`
data be converted into an NGSI entity of type `Bot` and the `attributes`
field declares a reading-to-attribute translation procedure. To wit,
`attributes` states that a measurement labeled `f` becomes the value
of the integer attribute `foo` in the target `Bot` entity and, similarly,
a `b` reading becomes a `bar` attribute.

As was the case with creating a `ServiceGroup` earlier, the HTTP request
ensures that `Device` objects are stored in the correct data context
by including suitable FIWARE HTTP headers. The request has exactly the
same `fiware-service` and `fiware-servicepath` headers used to create
the `ServiceGroup` in step 1. This way, the platform is able to instantiate
and link the `Device` object within the data graph owned by ManuFracture.




[dia.provisioning]: ./provisioning.png
