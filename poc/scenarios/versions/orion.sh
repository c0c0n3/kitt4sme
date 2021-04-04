#!/usr/bin/env bash

#
# Get Orion's version.
#

set -e

SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPODIR="$( cd "${SCRIPTPATH}/../../../" && pwd )"

source "${REPODIR}/poc/deployment/scripts/env.sh"

curl -v "${K4S_ORION}/version"
