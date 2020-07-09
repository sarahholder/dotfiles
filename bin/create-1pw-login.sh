#!/bin/bash

D=$(op get template login | jq -c ".fields[0].value = \"$2\"" | jq -c ".fields[1].value = \"$3\"" | op encode)
echo $D
op create item login $D --title "$1"
