#!/usr/bin/env bash

#
# Open a browser window to navigate to the ArgoCD UI.
# Replace the value of `OPEN_URL_CMD` (defined in `env.sh`) with whatever
# works on your box, e.g. `firefox` to have Firefox open the ArgoCD UI's URL.
#

set -e

SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOTDIR="$(dirname "$SCRIPTPATH")"
SCRIPTSDIR="${ROOTDIR}/scripts"

source "${SCRIPTSDIR}/env.sh"


"${OPEN_URL_CMD}" "${K4S_ARGOCD_URL}"
