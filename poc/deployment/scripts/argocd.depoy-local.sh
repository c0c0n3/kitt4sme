#!/usr/bin/env bash

#
# Force ArgoCD to do a backdoor local deployment.
# We deploy any files in the local `../auto/` dir, recursively.
#


set -e

SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOTDIR="$(dirname "$SCRIPTPATH")"
SCRIPTSDIR="${ROOTDIR}/scripts"
DEPLOYDIR="${ROOTDIR}/auto"


source "${SCRIPTSDIR}/env.sh"


argocd app sync kitt4sme \
       --server "${K4S_ARGOCD_ADDR}" --plaintext \
       --local "${DEPLOYDIR}"
