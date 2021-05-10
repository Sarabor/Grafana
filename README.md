![Logo of the project](https://cdn.freelogovectors.net/wp-content/uploads/2018/07/grafana-logo.png)

# Grafana with Grafonnet

Everything you need to get started with Grafonnet.

## Overview

[Requirements](#requirements)

[Installation Guide](#Installation-guide)

[Quick Start](#quick-start)

[Advanced usage](#advanced-usage)



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

I recommend chocolatey for installing the tools, but you can install them however you want.

To install chocolatey visit https://chocolatey.org/install

### Docker Desktop, jq and Golang
Here are the commands in chocolatey to download the required tools

      choco install jq
      choco install docker-desktop
      choco install golang

### Grafana installation

Execute
```shell
docker-compose up -d
```
This will create a Grafana image and start a Grafana container with persistent storage.

### Jsonnet
Execute

```shell
go get github.com/google/go-jsonnet/cmd/jsonnet
```

Choose an installation directory and execute
```shell
git clone https://github.com/google/go-jsonnet.git
cd go-jsonnet
go build ./cmd/jsonnet
go build ./cmd/jsonnetfmt
go build ./cmd/jsonnet-deps
```

### Grafonnet

Choose a folder for the Grafonnet Library and clone the repository.

```shell
git clone https://github.com/grafana/grafonnet-lib.git
```


## Quick start

When you only want to use or test grafonnet without any additional tools or utility.


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

## Advanced Usage

This is when you want to get a smoother development experience and make use of the Grafana API. 

### Initial Configuration

To use the Grafonnet library effectively, I recommend some configuration. 

#### Path to Grafonnet

Set a environment variable with the path to your Grafonnet Library and call it 'grafonnet'.

#### Authorization Token

Create or request an Authorization Token to use the Grafana API to import dashboards.
This step is necessary to use the Grafana API.
To get create a token execute:
```shell
curl -X POST -H "Content-Type: application/json" -d '{"name":"<Tokenname>", "role": "Admin"}' http://admin:admin@localhost:3000/api/auth/keys
```
Insert a name for the token in \<Tokenname\>. You will get a token. Save it somewhere, because you will not be able to access it again.

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






