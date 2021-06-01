![Logo of the project](https://cdn.freelogovectors.net/wp-content/uploads/2018/07/grafana-logo.png)

# Grafana with Grafonnet

Everything you need to get started with Grafonnet. 

## Overview

[Prerequisites](#prerequisites)

[Installation Guide](#Installation-guide)


[HelloWorld](#helloworld)

[Troubleshooting](#troubleshooting)



## Prerequisites

### For HelloWorld
- Jsonnet
- Grafonnet
- Git Bash (Other consoles work too, but the commands my differ)
- Running Grafana Container

## Installation Guide

First clone this repository. You will need the files for later steps.

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

jq is to read JSON files. We need jq to deploy dashboards with the Grafana API in another tutorial.

1. Download jq here: https://stedolan.github.io/jq/download/
2. Choose a folder and put the jq-win64.exe there
3. Rename jq-win64.exe to jq.exe
4. Copy the directory path of jq.exe
5. Add the directory path to the PATH variable
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

## HelloWorld

Use the HelloWorld to validate the installation of the tools and get a first look at Grafonnet.

### HelloDashboard!

This is a minimal dashboard with a single text panel written with the Grafonnet library that will generate the equivalent dashboard in JSON.

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
To convert the Grafonnet Code into JSON execute the following command in Git Bash in the same directoy as your jsonnet file.

```shell
jsonnet -J $grafonnet helloTest.jsonnet 
```
You will get a dashboard JSON that is ready to be imported into Grafana.

If you are new to Grafana or need to refresh your basic knowledge, I recommend working through the official [Grafana Tutorials](https://grafana.com/tutorials/grafana-fundamentals/).

Next we learn to [deploy a dashboard with the Grafana API](https://github.com/Sarabor/Grafana/tree/main/deployment).

For full documentation of Grafonnet visist [Grafonnet API Docs](https://grafana.github.io/grafonnet-lib/api-docs/)

## Troubleshooting

If you have any troubles you might find your problem in [Troubleshooting](https://github.com/Sarabor/Grafana/tree/main/troubleshooting).





