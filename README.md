# Grafana
Everything you need to get started with Grafana

# Real Cool Heading
[Go to Real Cool Heading section](#real-cool-heading)

- Docker
- Git Bash

## jq Installation

### Mit Chocolatey
1. Chocolatey per Anleitung installieren: https://chocolatey.org/install#individual
2. git bash als Administrator ausführen
3. Folgenden Befehl eingeben
   
         choco install jq
4. Befehle der Konsole mit bestätigen
5. jq ist installiert

## Zum Einrichten von Grafana

### Für Container

1. Um Grafana Image zu installieren und Container zu starten
   
         docker-compose up -d

### Für Jsonnet

2. go lang installieren https://golang.org/
   
3. Speicherort für Library wählen und in der Konsole folgende Befehle ausführen 
   
   #### Package Downloaden
   
        go get github.com/google/go-jsonnet/cmd/jsonnet
   
   #### Zum Builden
   
        git clone https://github.com/google/go-jsonnet.git
        cd go-jsonnet
        go build ./cmd/jsonnet
        go build ./cmd/jsonnetfmt
        go build ./cmd/jsonnet-deps

### Für Grafonnet

4. Speicherort für Library wählen und in der Konsole folgenden Befehl ausführen 
   
         git clone https://github.com/grafana/grafonnet-lib.git
   
5. Grafonnet Speicherort als Umgebungsvariable anlegen. Variable "grafonnet" nennen


### Wie erstelle ich eine Dashboard.json aus einer Dashboard.jsonnet?

1. Dashboard.jsonnet schreiben
   
Ein einfaches HelloDashboard könnte wie folgt aussehen:
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

### Wie deploye ich eine Dashboard.json in Grafana?

1. Authorization Token erstellen. \<Tokenname\> mit Namen für das Token austauschen.
   
```bash
curl -X POST -H "Content-Type: application/json" -d '{"name":"<Tokenname>", "role": "Admin"}' http://admin:admin@localhost:3000/api/auth/keys
```
   Für mehr Informationen zu Authorization Token siehe https://grafana.com/docs/grafana/latest/http_api/create-api-tokens-for-org/

2. Folgende Befehle in Git Bash ausführen. <Token> hier mit dem eigenen Token austauschen.
```bash
JSONNET_PATH=$grafonnet \
jsonnet dashboard.jsonnet > dashboard.json

payload="{\"dashboard\": $(jq . dashboard.json), \"overwrite\": true}"
curl -X POST --insecure -H "Authorization: Bearer <Token>" \
-H "Content-Type: application/json" \
-d "${payload}" \
http://localhost:3000/api/dashboards/db
```
3. Das Dashboard ist nun in Grafana deployed
## ToDo

- jq Installationsguide
- Alternative zu Git Bash
- HelloWorld verbessern
- Größeres Beispiel Jsonnet
- Datenbank über API deployen
- Auth Token erstellen/ Was sind Orgs?

## Entwicklerworkflow

1. Dashboard.Jsonnet schreiben
2. Code commiten & pushen
3. Checkout aus Repository
4. Kompilieren
5. Testen
6. Kompilat hochladen
7. Kompilat deplyoen


