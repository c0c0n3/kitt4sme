#!/usr/bin/env bash

#
# Send values from the configured (fictitious) devices every second.
# (Use `Ctrl c` to stop.) Generate random integers between 1 and 10
# for each sensor:
#
#   ManuFracture (API key: 3z4w)
#     bardev -> b
#     foodev -> f
#
#  Smithereens (API key: 5d4z)
#    foobie -> b1, f1
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
source "${SCRIPTDIR}/tokens.sh"

cnt=0
while true
do
    print_header "Sending random values from bardev, foodev and foobie."

    curl -v "${K4S_IOTA_SOUTH}/iot/d?k=3z4w&i=bardev" \
         -H "Authorization: ${MANUFRACTURE_BEARER}" \
         -H 'fiware-service: manufracture' \
         -H 'Content-Type: text/plain' \
         -d "b|$((1 + $RANDOM % 10))"

    curl -v "${K4S_IOTA_SOUTH}/iot/d?k=3z4w&i=foodev" \
         -H "Authorization: ${MANUFRACTURE_BEARER}" \
         -H 'fiware-service: manufracture' \
         -H 'Content-Type: text/plain' \
         -d "f|$((1 + $RANDOM % 10))"

    curl -v "${K4S_IOTA_SOUTH}/iot/d?k=5d4z&i=foobie" \
         -H "Authorization: ${SMITHEREENS_BEARER}" \
         -H 'fiware-service: smithereens' \
         -H 'Content-Type: text/plain' \
         -d "b1|$((1 + $RANDOM % 10))|f1|$((1 + $RANDOM % 10))"

    cnt=$((cnt+1))
    print_header "Readings sent so far from each device: ${cnt}"

    sleep 1
done
