#!/usr/bin/env bash

#
# Make Orion notify QuantumLeap of any ManuFracture or Smithereens
# entity updates.
#


print_header () {
    echo "======================================================================="
    echo "        $1"
    echo "======================================================================="
}


set -e

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPODIR="$( cd "${SCRIPTDIR}/../../../" && pwd )"

source "${REPODIR}/poc/deployment/scripts/env.sh"


print_header "Creating catch-all ManuFracture entities subscription for QL."

curl -v "${K4S_ORION}/v2/subscriptions" \
     -H 'Content-Type: application/json' \
     -H 'fiware-service: manufracture' \
     -d @"${SCRIPTDIR}/quantumleap.subscription.json"

# NOTE. FIWARE service path.
# The way it behaves for subscriptions is a bit counter intuitive.
# You'd expect that with a header of 'fiware-servicepath: /' Orion would
# notify you of changes to *any* entities in the tree, similar to queries.
# But in actual fact, to do that you'd have to omit the service path header,
# which is what we do here. Basically the way it works is that if you
# specify a service path, then Orion only considers entities right under
# the last node in the service path, but not any other entities that might
# sit further down below. E.g. if your service tree looks like (e stands
# for entity)
#
#                        /
#                     p     q
#                  e1   r     e4
#                     e2 e3
#
# then a subscription with a service path of '/' won't catch any entities
# at all whereas one with a service path of '/p' will consider changes to
# e1 but not e2 nor e3.

print_header "Retrieving ManuFracture subscription from Context Broker."

curl -v "${K4S_ORION}/v2/subscriptions" \
     -H 'fiware-service: manufracture'


print_header "Creating catch-all Smithereens entities subscription for QL."

curl -v "${K4S_ORION}/v2/subscriptions" \
     -H 'Content-Type: application/json' \
     -H 'fiware-service: smithereens' \
     -d @"${SCRIPTDIR}/quantumleap.subscription.json"

print_header "Retrieving Smithereens subscription from Context Broker."

curl -v "${K4S_ORION}/v2/subscriptions" \
     -H 'fiware-service: smithereens'
