#!/usr/bin/env bash

#
# Start your Kitt4sme Minikube cluster and switch K8s context accordingly.
# If the cluster isn't there, make a new one.
# Broaden Minikube's port range to make sure it'll be able to expose any
# K8s node port we're going to use.
#

set -e

minikube start -p kitt4sme --memory=8192 --cpus=4 \
         --extra-config=apiserver.service-node-port-range=1-65535
kubectl config use-context kitt4sme
