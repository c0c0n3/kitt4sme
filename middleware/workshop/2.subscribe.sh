#!/usr/bin/env bash


# Make Orion notify QuantumLeap of entity updates.


curl -v -X POST \
     'http://localhost:1026/v2/subscriptions/' \
     -H 'Content-Type: application/json' \
     -H 'fiware-service: manufracture' \
     -H 'fiware-servicepath: /' \
     -d @quantumleap.subscription.json

curl -v http://localhost:1026/v2/subscriptions/ -H 'fiware-service: manufracture'


curl -v -X POST \
     'http://localhost:1026/v2/subscriptions/' \
     -H 'Content-Type: application/json' \
     -H 'fiware-service: smithereens' \
     -H 'fiware-servicepath: /' \
     -d @quantumleap.subscription.json

curl -v http://localhost:1026/v2/subscriptions/ -H 'fiware-service: smithereens'
