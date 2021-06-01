## Deployment Tutorial

In this tutorial we will create an authorization token to access the Grafana API and deploy a dashboard.

### Prerequisites
- Docker
- Running Grafana Container
- jq
- Jsonnet
- Grafonnet
- Git Bash 

### Initial Configuration

#### Authorization Token

Create or request an Authorization Token to use the Grafana API to import dashboards.
This step is necessary to use the Grafana API.
To create a token insert a name for the token in \<Tokenname\> and execute in Git Bash:
```shell
curl -X POST -H "Content-Type: application/json" -d '{"name":"<Tokenname>", "role": "Admin"}' http://admin:admin@localhost:3000/api/auth/keys
```
This returns a respone.
```shell
{"id":3,"name":"Token","key":"eyJrIjoidlVaem9QaDlldDVyd0hvNlZCVzBzZVM4VnJFdU00cnYiLCJuIjoiVG9rZW4iLCJpZCI6MX0="}
```
_eyJrIjoidlVaem9QaDlldDVyd0hvNlZCVzBzZVM4VnJFdU00cnYiLCJuIjoiVG9rZW4iLCJpZCI6MX0=_ is our Authorizazion Token. Save it somewhere, because you will not be able to invoke it again.
For easy access to your token create a user variable. I called mine AUTH.

#### Bash script

I recommend to save the deploy.sh to your path variable, like you have done with the jq.exe. When you have done this, you will be able to access the bash script from any directory.
In the following step I will assume you have done this.

#### Grafana Port Variable

The default Grafana port on docker is 3000. However it may differ, that's why I recommend creating a user environment variable, so you don't have to change the script, when you change your port. Create a user environment variable with the name GRAFANA and with the value <yourport>.

### Deploying a dashboard

Now navigate into this directory and execute:

```shell
deploy.sh helloDeployment.jsonnet
```

To verify that you can use deploy.sh from anywhere, try to deploy the helloDashboard.jsonnet from the parent directory.

**Also at this point you can use your console of choice. Executing the helloBash script will open a console capable of running the script by itself. Try using cmd or powershell to see how it works!**

Note: I assume you use the Port 3000 for Grafana, if not change it in the helloBash.sh. Below you will find a description of the script, so you know how to do it.

Go to the dashboard overview in Grafana and refresh it. Your dashboard is now deployed.


### The script

If you are interested how the script works, this it what it looks like. Your jsonnet file is the only part of the script that has to change regularly,
this is why it's a parameter in the script.

```shell
#!/bin/bash

: "${DASHBOARD:=${1:-}}"
if [[ -z "${DASHBOARD}" ]]; then
        echo 'Must provide DASHBOARD'
        read -n1 -s -r -p $'\nPress any button to continue...\n' key
        exit 1
fi

JSONNET_PATH="${grafonnet}" \
jsonnet "${DASHBOARD}" > dashboard.json

resp=$(mktemp)

payload="{\"dashboard\": $(jq . dashboard.json), \"overwrite\": true}"
resp=$(curl -X POST --insecure -H "Authorization: Bearer "${AUTH}"" \
-H "Content-Type: application/json" \
-d "${payload}" \
"http://localhost:"${GRAFANA}"/api/dashboards/db")


if [[ $resp = *success* ]]
then
    echo $'\n''Dashboard successfully deployed!'
else
    echo $'\n''Something went wrong. Full Message:'
    echo $'\n'$resp
fi


read -n1 -s -r -p $'\nPress any button to continue...\n' key
```

Most of the code does not have to be changed when working in a different environment,but you can think of some parts of the code as parameters.
- **${DASHBOARD}** is the dashboard you want to deploy.
- The JSON will be saved to a file **dashboard.json**. The file will be created in your current directory.
- **$AUTH** is the variable for our Authorization Token.
- **${GRAFANA}** is the Port of of our Grafana Grafana URL.

So if some of the listed things differ in your environment, change them accordingly.

The last line 
```bash
read -n1 -s -r -p $'\nPress any button to continue...\n' key
```
leaves the process open until you press a key. This is to make sure you have time to read the output if you start the console using the deploy.sh, because otherwise it would close itself immediately after executing the commands.
If you are working with a linux console anyway and you do not want to press a button for the process to end, feel free to delete this line.


Checkout the next [Tutorial](https://github.com/Sarabor/Grafana/tree/main/test) to learn how to test your dashboards without deploying them.

