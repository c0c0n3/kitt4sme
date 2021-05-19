Time series
-----------
> Time to get series.

When we looked at the data model earlier we mentioned tracking changes
to the IoT context over time by creating subscriptions with Context Broker
to get notified of changes to NGSI entities. One of the uses of this
is to keep a historical record of the IoT context that AI components
can then use for time-series analysis. The basic idea is to build a
database containing a time-indexed sequence of changes for each entity
of interest: `{ (t0, e0), (t1, e1), … }`, where `t0` is the time when
the entity was created and `e0` is the initial entity data; `e1` is the
entity data as it was at time `t1` when the entity was modified; and
so on. Let's have a look at how to do that then. We're going to sketch
out the high-level design of a RESTful time-series service which builds
the DB out of NGSI entity changes. By the way, this is pretty much the
design of QuantumLeap, the FIWARE service we decided to plonk down on
the KITT4SME platform to take care of IoT time-series. But keep in mind
from a high-level standpoint other FIWARE time-series services work similarly
(well, same same but different) and, in principle, you can use the same
design to implement your own time-series out of the IoT context managed
by Context Broker.


### Spatial-temporal features of IoT data

So we'd like to design a REST service for storing and querying spatial-temporal
IoT data. Before we talk design, let's explain what the heck we mean by
"spatial-temporal data". Spatial-temporal features of IoT data refers
to the fact that space and time are intrinsically linked to IoT device
readings. Indeed, if you think about it, it makes sense since the moment
you switch a device on, that device will start taking measurements, e.g.
air quality, water level in a sewage, but each reading gets taken in some
place at a specific point in time.

As it turns out, often (but by no means always!) to analyse those data,
you can't just consider a reading in isolation but you'll typically need
to know when and where the reading got taken. So you'll wind up with a
set of tuples `(reading, time, space)` that you'll have to make sense of

    R = { (reading, when, where) }

If you were looking for the lunar orbit view of NGSI time-series services,
it'd probably be fair to say that you're looking at REST services to build
persistent and queryable sets of these tuples out of NGSI entity data.

I suppose a quick example is in order. Say we've installed a bunch of
temperature sensors on two shop floors, "shop floor 1" and "shop floor 2".
These sensors are producing temperature values at set intervals, so we
pile up alot of temperature readings from the two shop floors. Now to
ask meaningful questions about this data set, we're going to need to
consider both space and time over and above temperature values. For example,
what's the current average temperature on shop floor 1? Since we're collecting
data from two shop floors, for each current measurement we've got to know
where it was taken if we want to answer this question. Similarly, you could
ask how the daily temperature has varied on average at shop floor 2 since,
say 24 Mar 2021. Again, we need to know where and when each reading got
taken to answer this question: we'll have to divide up the data collected
since 24 Mar 2021 in days and for each day average the temperature values
from shop floor 2.


### Storing and querying NGSI entities over space and time

So let's have a look at a typical approach to storing and querying NGSI
data over space and time. In a nutshell, the time-series service gets
notified of entity changes by Context Broker, converts those notified
NGSI entities to tabular format, and stores them in a time series &
geo-spatial DB. Then, through a REST API, you can query those entities
over space and time using the familiar NGSI query syntax we all know
and love. And here's a diagram to visualise how a typical NGSI time-series
service would operate.

![Storing and querying time-series.][dia.ql]

You can see at the bottom left corner three sensors installed on shop
floor 2, sitting in a rectangular area whose bottom right corner coordinates
are `(4, 0)` whereas the top left corner is at `(0, 2)`. Sensor `#3`
hits the IoT agent's device data port (commonly called "iota-south")
with a UL 2 payload containing a new temperature reading, the shop
floor coordinates (top left and bottom right corners) and a reading
timestamp. As we've seen already, agents are configured to translate
external data into NGSI entities and forward them to Context Broker to
update the IoT context. The time-series service has a subscription
with Context Broker (the publisher) to get notified of entity updates.
So as soon as Context Broker receives the entity update, it notifies
any interested subscribers, the NGSI time-series service in this case.
We see in the diagram Context Broker `POST`ing new entity data to the
service. It's an entity of type `TempSen` the original UL 2 payload
got mapped to. At this point the time-series service turns the entity
into a DB record and stashes it away in a DB that supports both time-series
and spatial data, like Timescale or CrateDB, taking care of picking a
suitable time index value and a location.

Now along comes a dashboard app wanting to visualise the average temperature
on shop floor 2 since 24 Mar 2021. To do that, it can simply do an HTTP
`GET` on the NGSI `TempSen` entity exposed by the time-series service.
On the top right corner of the diagram, you can see what the URL would
look like. In the path part of the URL, the client says it's looking
for `temp` attribute values of `TempSen` entities whereas the query
string asks the service to consider only data points since 24 Mar 2021
coming from shop floor 2—`fromDate` and `geo*/coords` params, respectively.
The `geo*/coords` params specify a polygon enclosing shop floor 2. Plus,
the client wants the service to divide up the data into day-wide intervals
(`aggrPeriod`) and average the temperature (`temp`) values in each day
interval (`aggrMethod`). Under the bonnet, the service parses the URL
into an AST which then translates (interprets) to a SQL query as shown
by pseudo-code on the diagram which computes a sequence `a` of average
temperatures indexed by day `d` where `d` runs from 24 Mar 2021 and
each `a[d]` is the average of the set of temperatures `T(d)` recorded
on `d` such that `t` is in `T(d)` just in case it comes from an entity
of type `TempSen` and a location lying within the client-specified
polygon.




[dia.ql]: ./quantumleap.png
