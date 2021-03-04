#!/usr/bin/env bash


# Provision service groups.

curl -v -X POST \
     'http://localhost:4041/iot/services' \
     -H 'Content-Type: application/json' \
     -H 'fiware-service: manufracture' \
     -H 'fiware-servicepath: /' \
     -d @manufracture.service-group.json

curl -v 'http://localhost:4041/iot/services' \
     -H 'fiware-service: manufracture' \
     -H 'fiware-servicepath: /'


curl -v -X POST \
     'http://localhost:4041/iot/services' \
     -H 'Content-Type: application/json' \
     -H 'fiware-service: smithereens' \
     -H 'fiware-servicepath: /' \
     -d @smithereens.service-group.json

curl -v 'http://localhost:4041/iot/services' \
     -H 'fiware-service: smithereens' \
     -H 'fiware-servicepath: /'


# Provision devices.

curl -v -X POST \
     'http://localhost:4041/iot/devices' \
     -H 'Content-Type: application/json' \
     -H 'fiware-service: manufracture' \
     -H 'fiware-servicepath: /' \
     -d @manufracture.devices.json

curl -v 'http://localhost:4041/iot/devices' \
     -H 'fiware-service: manufracture' \
     -H 'fiware-servicepath: /'

curl -v localhost:1026/v2/entities -H 'fiware-service: manufracture'


curl -v -X POST \
     'http://localhost:4041/iot/devices' \
     -H 'Content-Type: application/json' \
     -H 'fiware-service: smithereens' \
     -H 'fiware-servicepath: /' \
     -d @manufracture.devices.json

curl -v 'http://localhost:4041/iot/devices' \
     -H 'fiware-service: smithereens' \
     -H 'fiware-servicepath: /'

curl -v localhost:1026/v2/entities -H 'fiware-service: smithereens'
