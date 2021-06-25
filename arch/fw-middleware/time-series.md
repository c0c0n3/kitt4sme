Time series
-----------
> Time to get series.

Upon examining the data model earlier, we mentioned tracking changes
to the IoT context over time by creating subscriptions with Context
Broker to get notified of changes to NGSI entities. One of the uses
of this feature is to maintain a historical record of the IoT context
which AI components can then use for time-series analysis. The basic
idea is to build a database containing a time-indexed sequence of changes
for each entity of interest: `{(t0, e0), (t1, e1),…}`, where `t0` is
the time when the entity was created and `e0` is the initial entity
data; `e1` is the entity data as it was at time `t1` when the entity
was modified; and so forth. This section delves into details of building
these time series. Specifically, this section illustrates the high-level
design of a RESTful time-series service which builds its database out
of NGSI entity changes. The design presented below follows closely that
of QuantumLeap, the FIWARE service adopted by the KITT4SME platform
to provide IoT time-series. However, from a high-level standpoint other
FIWARE time-series services work similarly (at least in principle) and
platform developers can use these design guidelines and blueprints to
implement new services to construct, manipulate and query time-series
assembled from the IoT context managed by Context Broker.


### Spatial-temporal features of IoT data

Our goal is to examine the design a REST service for storing and querying
spatial-temporal IoT data. Before delving into the design proper, we
should clarify the meaning of "spatial-temporal data". Spatial-temporal
features of IoT data refers to the fact that space and time are intrinsically
linked to IoT device readings. Indeed, as soon as a device is activated,
that device will start taking measurements, e.g. air quality, water
level in a sewage, but ultimately each reading is taken in some place
at a specific point in time.

As it turns out, often (but by no means always!) to analyse those data,
one cannot consider each reading in isolation but typically one needs
to know when and where the reading was taken. Therefore, a set of tuples
`(reading, time, space)` is eventually collected for analysis

    R = { (reading, when, where) }

If pressed to provide a concise characterisation of NGSI time-series
services, it would probably be fair to say that an NGSI time-series
service is a REST services to construct persistent and queryable sets
`R` of these tuples out of NGSI entity data.

An example should help to clarify this terse definition. Assume, for
the sake of argument, that a number of temperature sensors have been
installed at two shop floors, "shop floor 1" and "shop floor 2". These
sensors are producing temperature values at set intervals and a sizeable
amount of temperature readings from the two shop floors have been accumulated.
Now to ask meaningful questions about this data set, both space and
time have to be considered in conjunction with temperature values. For
example, what is the current average temperature on shop floor 1? Since
data are collected from two shop floors, for each current measurement
we need to know where it was taken if we are to answer this question.
Similarly, one could ask how the daily temperature has varied on average
at shop floor 2 since, say 24 Mar 2021. Again, we need to know where
and when each reading was taken to answer this question: we will have
to divide up the data collected since 24 Mar 2021 in days and for each
day average the temperature values from shop floor 2.


### Storing and querying NGSI entities over space and time

Let us turn our attention to a typical approach to storing and querying
NGSI data over space and time. In a nutshell, the time-series service
gets notified of entity changes by Context Broker, converts those notified
NGSI entities to tabular format, and stores them in a time series &
geo-spatial database. Then, through a REST API, a client can query those
entities over space and time using the familiar, well-known NGSI query
syntax. The diagram below visualises how a typical NGSI time-series
service would operate.

![Storing and querying time-series.][dia.ql]

The bottom left corner of the diagram shows three sensors installed
on shop floor 2, sitting in a rectangular area whose bottom right corner
coordinates are `(4, 0)` whereas the top left corner is at `(0, 2)`.
Sensor `#3` connects to the IoT Agent's device data port (often dubbed
"iota-south" as in the diagram) with a UL 2 payload containing a new
temperature reading, the shop floor coordinates (top left and bottom
right corners) and a reading timestamp. As mentioned previously, agents
are configured to translate external data into NGSI entities and forward
them to Context Broker to update the IoT context. The time-series service
has a subscription with Context Broker (the publisher) to get notified
of entity updates. Thus, as soon as Context Broker receives the entity
update, it notifies any interested subscribers, the NGSI time-series
service in this case. The diagram shows Context Broker `POST`ing new
entity data to the service. In fact, the Agent translated the original
UL 2 payload into an entity of type `TempSen`. At this point the time-series
service transforms the entity into a tabular record and inserts it into
a database that supports both time-series and spatial data, such as
Timescale or CrateDB, also assigning a suitable time index value and
a location in the process.

Subsequently, a dashboard application needs to visualise the average
temperature on shop floor 2 since 24 Mar 2021. To do that, the application
can simply perform an HTTP `GET` of the NGSI `TempSen` entity exposed
by the time-series service. The top right corner of the diagram shows
what the URL would look like. The path part of the URL instructs the
service to select `temp` attribute values of `TempSen` entities whereas
the query string restricts the set of `temp` values to the data points
since 24 Mar 2021 acquired from shop floor 2 (`fromDate` and `geo*/coords`
parameters, respectively). The `geo*/coords` parameters specify a polygon
enclosing shop floor 2. Additionally, the client requires the service
to partition the data into day-wide intervals (`aggrPeriod`) and average
the temperature (`temp`) values in each day interval (`aggrMethod`).
Behind the scenes, the service parses the URL into an AST which then
translates (interprets) into a SQL query as shown by the pseudo-code
on the diagram which computes a sequence `a` of average temperatures
indexed by day `d` where `d` runs from 24 Mar 2021 and each `a[d]` is
the average of the set of temperatures `T(d)` recorded on day `d` such
that `t` is in `T(d)` just in case it is the value of a `temp` attribute
of an entity of type `TempSen` which is associated to a location lying
within the client-specified polygon.




[dia.ql]: ./quantumleap.png
