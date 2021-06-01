## Test Dashboard Tutorial

In this tutorial we will learn a method to look at your dashboard without deploying them. This is useful to test or share dashboards before deploying.
To do this we make use of the Snapshot API.

### Prerequisites
- Running Grafana Container
- jq
- Jsonnet
- Grafonnet
- Git Bash
- Initial configuration from deployment tutorial 


### Initial Configuration

#### Bash script

I recommend to save the test.sh to your path variable, like you have done with the jq.exe. When you have done this, you will be able to access the bash script from any directory.
In the following step I will assume you have done this.

### Testing a dashboard

Now navigate into this directory and execute:

```shell
test.sh helloTest.jsonnet
```

A browser will open and display your dashboard.

To learn more about Snapshots and how they work visit [Grafana Snapshot](https://grafana.com/docs/grafana/latest/sharing/share-dashboard/#publish-a-snapshot).

### The script

If you are interested how the script works, this it what it looks like. Your jsonnet file is the only part of the script that has to change regularly,
this is why it's a parameter in the script.

```shell
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
```


You are now ready to programm with Grafonnet. To see some examples of advanced dashboards look into the folders of the repository.

