#!/bin/bash

: "${DASHBOARD:=${1:-}}"
: "${GRAFANA:=${2:-}}"
if [[ -z "${DASHBOARD}" ]]; then
        echo 'Must provide DASHBOARD'
        read -n1 -s -r -p $'\nPress any button to continue...\n' key
        exit 1
fi

dbjson=$(mktemp)
jsonnet -J ""${grafonnet}"" -J . "${DASHBOARD}" > "${dbjson}"

json=$(mktemp)
jq "{ \"dashboard\": ., \"expires\": 300 }" < "${dbjson}" > "${json}"

resp=$(curl -X POST --insecure -H "Authorization: Bearer "${AUTH}"" \
-H 'Content-type: application/json' -H 'Accept: application/json' \
"http://localhost:"${GRAFANA}"/api/snapshots" --data-binary "@${json}")

 url=$(echo "${resp}" | jq -r ".url | sub(\"http://localhost:3000\"; \"http://localhost:"${GRAFANA}"\")")

start "${url}"

read -n1 -s -r -p $'\nPress any button to continue...\n' key