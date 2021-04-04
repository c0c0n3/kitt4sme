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
     -H 'fiware-servicepath: /' \
     -d @"${SCRIPTDIR}/quantumleap.subscription.json"

print_header "Retrieving ManuFracture subscription from Context Broker."

curl -v "${K4S_ORION}/v2/subscriptions" \
     -H 'fiware-service: manufracture'


print_header "Creating catch-all Smithereens entities subscription for QL."

curl -v "${K4S_ORION}/v2/subscriptions" \
     -H 'Content-Type: application/json' \
     -H 'fiware-service: smithereens' \
     -H 'fiware-servicepath: /' \
     -d @"${SCRIPTDIR}/quantumleap.subscription.json"

print_header "Retrieving Smithereens subscription from Context Broker."

curl -v "${K4S_ORION}/v2/subscriptions" \
     -H 'fiware-service: smithereens'
