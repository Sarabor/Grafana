![Logo of the project](https://cdn.freelogovectors.net/wp-content/uploads/2018/07/grafana-logo.png)

# Grafana with Grafonnet

Everything you need to get started with Grafana in a professional environment.

## Requirements

### For Quickstart
- Jsonnet

### For advanced usage
- Docker
- jq
- Git Bash
- Jsonnet

Installationguide

## Quick start

When you only want to use or test grafonnet without any additional tools or utility.

### How to install Grafonnet

Choose a folder for the Grafonnet Library and clone the repository.

```shell
git clone https://github.com/grafana/grafonnet-lib.git
```
### HelloDashboard!

This is a minimal dashboard with a single text panel written in Jsonnet that will generate the equivalent dashboard in JSON.

```jsonnet
local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local text = grafana.text;

dashboard.new('HelloPanel!')
   .addPanel(
      text.new(
      'HelloWorld',
      content='HelloWorld'
      ), gridPos={
        x: 0,
        y: 0,
        w: 24,
        h: 3,
      }
   )
 ```

Once you have your Jsonnet Code execute
```shell
jsonnet -J grafonnet-lib dashboard.jsonnet 
```
Grafonnet-lib must be exchanged for the path to the grafonnet-lib folder.
You will get a dashboard JSON that is ready to be imported into Grafana.

### Initial Configuration

To use the Grafonnet library effectively, I recommend some configuration.

Path to Grafonnet

Set a environment variable with the path to your Grafonnet Library and call it 'grafonnet'.

Authorization Token

Create or request an Authorization Token to use the Grafana API to import dashboards.
To get create a token execute:
```shell
curl -X POST -H "Content-Type: application/json" -d '{"name":"<Tokenname>", "role": "Admin"}' http://admin:admin@localhost:3000/api/auth/keys
```
Insert a name for the token in \<Tokenname\>. You will get a token. Save it somewhere, because you will not be able to access it again.


## How to use Grafana API

### Deploying a dashboard

To deploy a dashboard with the Grafana API execute

```shell
JSONNET_PATH=$grafonnet \
jsonnet dashboard.jsonnet > dashboard.json

payload="{\"dashboard\": $(jq . dashboard.json), \"overwrite\": true}"
curl -X POST --insecure -H "Authorization: Bearer <Token>" \
-H "Content-Type: application/json" \
-d "${payload}" \
http://localhost:3000/api/dashboards/db
```
Go to the dashboard overview in Grafana and refresh it. Your dashboard is now deployed.

### Deploy a data source

WIP






