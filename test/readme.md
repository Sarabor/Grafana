## Test Dashboard Tutorial

In this tutorial we will learn a method to look at your dashboard without deploying them. This is useful to test or share dashboards before deploying.
To do this we make use of the Snapshot API.

### Prerequisites
- Running Grafana Container
- jq
- Jsonnet
- Grafonnet
- Git Bash (Other consoles work too, but the commands may differ)
- Grafana Authorization Token Docker


### Initial Configuration

#### Bash script

I recommend to save the test.sh to your path variable, like you have done with the jq.exe. When you have done this, you will be able to access the bash script from any directory.
In the following step I will assume you have done this.

### Testing a dashboard

Now navigate into this directory and execute:

```shell
deploy.sh helloTest.jsonnet
```

A browser will open and display your dashboard.

To verify that you can use deploy.sh from anywhere, try to deploy the helloDashboard.jsonnet from the parent directory.

**Also at this point you can use your console of choice. Executing the bash script will open a console capable of running the script by itself. Try using cmd or powershell to see how it works!**

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

Most of the code does not have to be changed when working in a different environment,but you can think of some parts of the code as parameters.
- **$1** is the dashboard you want to deploy.
- The JSON will be saved to a file **dashboard.json**. The file will be created in your current directory.
- **$AUTH** is the variable for our Authorization Token.
- **ht<span>tp://</span>://localhost:3000/api/dashboards/db** is the URL to our Grafana API.

So if some of the listed things differ in your environment, change them accordingly.

The last line 
```bash
read -n1 -s -r -p $'\nPress any button to continue...\n' key
```
leaves the process open until you press a key. This is to make sure you have time to read the output if you start the console using the deploy.sh, because otherwise it would close itself immediately after executing the commands.
If you are working with a linux console anyway and you do not want to press a button for the process to end, feel free to delete this line.


You are now ready to programm with Grafonnet. To see some examples of advanced dashboards look into the folders of the repository.

