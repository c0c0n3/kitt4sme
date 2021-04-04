#!/usr/bin/env bash

#
# Provision ManuFracture and Smithereens service groups and devices.
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


#
# Provision ManuFracture and Smithereens service groups.
#


print_header "Provisioning ManuFracture service group."

curl -v "${K4S_IOTA_NORTH}/iot/services" \
     -H 'Content-Type: application/json' \
     -H 'fiware-service: manufracture' \
     -H 'fiware-servicepath: /floor1' \
     -d @"${SCRIPTDIR}/manufracture.service-group.json"


print_header "Retrieving ManuFracture service group."

curl -v "${K4S_IOTA_NORTH}/iot/services" \
     -H 'fiware-service: manufracture' \
     -H 'fiware-servicepath: /floor1'


print_header "Provisioning Smithereens service group."

curl -v "${K4S_IOTA_NORTH}/iot/services" \
     -H 'Content-Type: application/json' \
     -H 'fiware-service: smithereens' \
     -H 'fiware-servicepath: /' \
     -d @"${SCRIPTDIR}/smithereens.service-group.json"


print_header "Retrieving Smithereens service group."

curl -v "${K4S_IOTA_NORTH}/iot/services" \
     -H 'fiware-service: smithereens' \
     -H 'fiware-servicepath: /'


#
# Provision ManuFracture and Smithereens devices in the above service groups.
#


print_header "Provisioning ManuFracture devices."

curl -v "${K4S_IOTA_NORTH}/iot/devices" \
     -H 'Content-Type: application/json' \
     -H 'fiware-service: manufracture' \
     -H 'fiware-servicepath: /floor1' \
     -d @"${SCRIPTDIR}/manufracture.devices.json"


print_header "Retrieving ManuFracture devices from Agent."

curl -v "${K4S_IOTA_NORTH}/iot/devices" \
     -H 'fiware-service: manufracture' \
     -H 'fiware-servicepath: /floor1'

print_header "Retrieving ManuFracture devices from Context Broker."

curl -v "${K4S_ORION}/v2/entities" \
     -H 'fiware-service: manufracture'


print_header "Provisioning Smithereens devices."

curl -v "${K4S_IOTA_NORTH}/iot/devices" \
     -H 'Content-Type: application/json' \
     -H 'fiware-service: smithereens' \
     -H 'fiware-servicepath: /' \
     -d @"${SCRIPTDIR}/smithereens.devices.json"


print_header "Retrieving Smithereens devices from Agent."

curl -v "${K4S_IOTA_NORTH}/iot/devices" \
     -H 'fiware-service: smithereens' \
     -H 'fiware-servicepath: /'

print_header "Retrieving Smithereens devices from Context Broker."

curl -v "${K4S_ORION}/v2/entities" \
     -H 'fiware-service: smithereens'
