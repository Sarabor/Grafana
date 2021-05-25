![Logo of the project](https://cdn.freelogovectors.net/wp-content/uploads/2018/07/grafana-logo.png)

# Grafana with Grafonnet

Everything you need to get started with Grafonnet.

## Overview

[Requirements](#requirements)

[Installation Guide](#Installation-guide)

[Quick Start](#quick-start)

[Advanced usage](#advanced-usage)

[Troubleshooting](#troubleshooting)



## Requirements

### For Quickstart
- Jsonnet
- Grafonnet
- Any console that works for you. I used Git Bash

### For advanced usage
- Docker
- Running Grafana Container
- jq
- Jsonnet
- Grafonnet
- Any console that works for you. I used Git Bash

## Installation Guide

First clone this repository. You will need the files for later steps.
I used git bash for all command lines. So if you use another command line tool the commands may differ.

### Jsonnet
I use go-jsonnet, so first download and install go https://golang.org/dl/

Once you have go, you can download jsonnet.

Execute
```
go get github.com/google/go-jsonnet/cmd/jsonnet
```
If you have a proxy use:
```
HTTPS_PROXY=<proxy>:<port> go get github.com/google/go-jsonnet/cmd/jsonnet
```


Choose an installation folder and execute
```
git clone https://github.com/google/go-jsonnet.git
cd go-jsonnet
go build ./cmd/jsonnet
go build ./cmd/jsonnetfmt
go build ./cmd/jsonnet-deps
```
You can now use the jsonnet command.

### Grafonnet

Choose a folder for the Grafonnet Library and clone the repository: https://github.com/grafana/grafonnet-lib.git

For best usage create a user variable to grafonnet-lib. I called mine "grafonnet".

### jq

jq is to read json files. We will need that for our advanced usage.

1. Download jq here: https://stedolan.github.io/jq/download/
2. Choose a folder and put the jq-win64.exe there
3. Rename jq-win64.exe to jq.exe
4. Copy the path to the folder where you put jq.exe
5. Add the path to the folder to the path system variable
6. You can now use the jq command in your command line tool


### Grafana installation
Execute the docker-compose in this repository to create a Grafana container with persistent storage.
```shell
docker-compose up -d
```

### With chocolatey

If you have chocolatey you can install jq and go using:
```
choco install golang
choco install jq
```

## Quick start

When you only want to use or test grafonnet without any additional tools or utility.
I recommend trying this out first to verify your jsonnet and grafonnet installation.


### HelloDashboard!

This is a minimal dashboard with a single text panel written in Jsonnet that will generate the equivalent dashboard in JSON.

```jsonnet
local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local text = grafana.text;	            #import the tools you want to use				

dashboard.new('HelloPanel!')


.addPanel(				    #addPanel adds a row in which you can put panels via the parameters						
    text.new(				    #the first paramater is the panel type eg. text, graph, table
        title='HelloWorld',
        content='HelloWorld'
        ),
        gridPos={}			    #the second parameter is optional. It sets the position and the dimensions of the panel

)
 ```

Once you have your Jsonnet Code execute in this repository
```shell
jsonnet -J $grafonnet helloDashboard.jsonnet 
```
You will get a dashboard JSON that is ready to be imported into Grafana.

## Advanced Usage

This is when you want to get a smoother development experience and make use of the Grafana API. 

### Initial Configuration

#### Authorization Token

Create or request an Authorization Token to use the Grafana API to import dashboards.
This step is necessary to use the Grafana API.
To get create a token execute:
```shell
curl -X POST -H "Content-Type: application/json" -d '{"name":"<Tokenname>", "role": "Admin"}' http://admin:admin@localhost:3000/api/auth/keys
```
Insert a name for the token in \<Tokenname\>. You will get a token. Save it somewhere, because you will not be able to access it again.

For easy access to your token set a user variable. I called mine AUTH.

### Deploying a dashboard

To deploy a dashboard with the Grafana API execute in this repository

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

### Deploy a data source

WIP

For full documentation visit: https://grafana.github.io/grafonnet-lib/api-docs/

## Troubleshooting

### The curl commands don't give any response

Try changing the port of the docker container. In the docker-compose yaml in the repository. Delete the old container and start the new one.

```yaml
version: '3'

services:
  grafana:
    image: grafana/grafana:latest
    restart: always
    ports:
      - "<CHANGEPORTHERE>:3000"

```
Change the port until you get the desired respone. Don't forget to change the URL in the curl commands too.
For example, if you use port 4000, your URL is `http://localhost:4000/[...]`


