#!/usr/bin/env bash

#
# Env vars to keep our scripts tidy and avoid repetition.
#

set -e

# Command to open a browser window to navigate to a given URL.
# The default command opens your fave browser on MacOS, change it to
# suit your box's env / taste. E.g. if you have Firefox, you could set
# a value of: firefox.
OPEN_URL_CMD=open

# The IP to access the Minikube cluster.
K4S_CLUSTER_IP=$(minikube ip -p kitt4sme)

# The URLs to navigate to the ArgoCD, Crate, and Grafana UIs.
K4S_ARGOCD_URL="http://${K4S_CLUSTER_IP}:8080"
K4S_CRATE_URL="http://${K4S_CLUSTER_IP}:4200"
K4S_GRAFANA_URL="http://${K4S_CLUSTER_IP}:3000"

# ArgoCD server's socket address: IP and port.
K4S_ARGOCD_ADDR="${K4S_CLUSTER_IP}:8080"

# Orion, QuantumLeap and UL Agent endpoints.
K4S_ORION="http://${K4S_CLUSTER_IP}/orion"
K4S_QUANTUMLEAP="http://${K4S_CLUSTER_IP}/quantumleap"
K4S_IOTA_NORTH="http://${K4S_CLUSTER_IP}/iota-north"
K4S_IOTA_SOUTH="http://${K4S_CLUSTER_IP}/iota-south"



# ------------------------------------------------------------------------------
# Here's an example of doing the same thing when using Minikube dynamic
# ports---i.e. Crate, Grafana, etc. are still node port services but don't
# specify an explicit node port, so they get assigned a random port in the
# load balancer.
#

# K4S_INGRESS_HOST=$(minikube ip -p kitt4sme)
# K4S_INGRESS_HTTP_PORT=$(kubectl -n istio-system \
#                         get service istio-ingressgateway \
#                         -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
#
# K4S_BASE_URL="http://${K4S_INGRESS_HOST}:${K4S_INGRESS_HTTP_PORT}"
# K4S_GRAFANA_URL=$(minikube -p kitt4sme service grafana --url)
#    # ^ this works b/c we only have one Grafana port, but Crate has 3, so
#    #   we've got to pick the right one:
# CRATE_UI_PORT=$(kubectl get service crate \
#                 -o jsonpath='{.spec.ports[?(@.name=="crate-web")].nodePort}')
# K4S_CRATE_URL="http://${K4S_INGRESS_HOST}:${CRATE_UI_PORT}"
