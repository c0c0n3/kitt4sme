#!/usr/bin/env bash


curl -v -X POST \
     'http://localhost:7896/iot/d?k=manufracture&i=bot1' \
     -H 'Content-Type: text/plain' \
     -d "b|$((1 + $RANDOM % 10))"


curl -v -X POST \
     'http://localhost:7896/iot/d?k=manufracture&i=bot2' \
     -H 'Content-Type: text/plain' \
     -d "f|$((1 + $RANDOM % 10))"


curl -v -X POST \
     'http://localhost:7896/iot/d?k=smithereens&i=bot1' \
     -H 'Content-Type: text/plain' \
     -d "b1|$((1 + $RANDOM % 10))|f1|$((1 + $RANDOM % 10))"
