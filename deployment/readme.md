## Deployment Tutorial

In this tutorial we will create an authorization token to access the Grafana API and deploy a dashboard.

### Prerequisites
- Docker
- Running Grafana Container
- jq
- Jsonnet
- Grafonnet
- Git Bash (Other consoles work too, but the commands may differ)

### Initial Configuration

#### Authorization Token

Create or request an Authorization Token to use the Grafana API to import dashboards.
This step is necessary to use the Grafana API.
To get create a token insert a name for the token in \<Tokenname\> and execute in Git Bash:
```shell
curl -X POST -H "Content-Type: application/json" -d '{"name":"<Tokenname>", "role": "Admin"}' http://admin:admin@localhost:3000/api/auth/keys
```
This returns a respone.
```shell
{"id":3,"name":"Token","key":"eyJrIjoidlVaem9QaDlldDVyd0hvNlZCVzBzZVM4VnJFdU00cnYiLCJuIjoiVG9rZW4iLCJpZCI6MX0="}
```
_eyJrIjoidlVaem9QaDlldDVyd0hvNlZCVzBzZVM4VnJFdU00cnYiLCJuIjoiVG9rZW4iLCJpZCI6MX0=_ is our Authorizazion Token. Save it somewhere, because you will not be able to invoke it again.
For easy access to your token create a user variable. I called mine AUTH.

### Deploying a dashboard

To deploy a dashboard with the Grafana API execute the command below in the directory where your dashboard is.

```shell
JSONNET_PATH=$grafonnet \
jsonnet helloDashboard.jsonnet > dashboard.json

payload="{\"dashboard\": $(jq . dashboard.json), \"overwrite\": true}"
curl -X POST --insecure -H "Authorization: Bearer $AUTH" \
-H "Content-Type: application/json" \
-d "${payload}" \
http://localhost:3000/api/dashboards/db
```
Go to the dashboard overview in Grafana and refresh it. Your dashboard is now deployed.

### Additional Notes 

Most of the code does not have to be changed when working in a different environment,but you can think of some parts of the code as parameters.
- **helloDashboard.jsonnet** is the dashboard you want to deploy.
- The JSON will be saved to a file **dashboard.json**. The file will be created in your current directory.
- **$AUTH** is the variable for our Authorization Token.
- **ht<span>tp://</span>://localhost:3000/api/dashboards/db** is the URL to our Grafana API. 

So if some of the listed things differ in your environment, change them accordingly.

You are now ready to programm with Grafonnet. To see some examples of advanced dashboards look into the folders of the repository.

