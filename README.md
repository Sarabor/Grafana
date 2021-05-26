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

Use the Quick start to validate the installation of the tools and get a first look at Grafonnet.

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

If you are new to Grafana or need to refresh your basic knowledge, I recommend working through the official [Grafana Tutorials](.

For advanced usage look into the folder advancedUsage.




