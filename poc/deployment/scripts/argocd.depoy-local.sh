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


# ------------------------------------------------------------------------------
# Here's an example of doing the same thing with vanilla ArgoCD.
# In this case, ArgoCD would have TLS on and no node port. So we have
# to set up K8s port forwarding to run the deploy command locally.
#

# kubectl port-forward svc/argocd-server -n argocd 8080:443 &> /dev/null &
# PORT_FW_PID=$!
#
# sleep 2
#
# argocd app sync kitt4sme --local "${DEPLOYDIR}"
#
# kill ${PORT_FW_PID}
