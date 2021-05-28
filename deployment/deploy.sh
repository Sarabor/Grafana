#!/bin/bash
JSONNET_PATH=$grafonnet \
jsonnet $1 > dashboard.json

payload="{\"dashboard\": $(jq . dashboard.json), \"overwrite\": true}"
curl -X POST --insecure -H "Authorization: Bearer $AUTH" \
-H "Content-Type: application/json" \
-d "${payload}" \
http://localhost:3000/api/dashboards/db

read -n1 -s -r -p $'\nPress any button to continue...\n' key
