#!/bin/bash

: "${DASHBOARD:=${1:-}}"
if [[ -z "${DASHBOARD}" ]]; then
        echo 'Must provide DASHBOARD'
        read -n1 -s -r -p $'\nPress any button to continue...\n' key
        exit 1
fi

JSONNET_PATH=$grafonnet \
jsonnet "${DASHBOARD}" > dashboard.json



resp=$(mktemp)

payload="{\"dashboard\": $(jq . dashboard.json), \"overwrite\": true}"
resp=$(curl -X POST --insecure -H "Authorization: Bearer $AUTH" \
-H "Content-Type: application/json" \
-d "${payload}" \
http://localhost:4000/api/dashboards/db)


if [[ $resp = *success* ]]
then
    echo $'\n''Dashboard successfully deployed!'
else
    echo $'\n''Something went wrong. Full Message:'
    echo $resp
fi


read -n1 -s -r -p $'\nPress any button to continue...\n' key
