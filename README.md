# Grafana
Everything you need to get started to use Grafana


## Zum Einrichten von Grafana

### Für Container

1. Um Grafana Image zu installieren und Container zu starten
   
         docker-compose up -d auszuführen

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
      ),
   gridPos={
      x: 0,
      y: 0,
      w: 24,
      h: 3,
      }
      )
 ```
2. Zum Umwandeln vom JSONNET in JSON folgenden Befehl in der Powershell ausführen
   
         jsonnet -J $env:grafonnet dashboard.jsonnet > dashboard.json

3. Dashboard.json liegt nun im gleichen Ordner als Datei vor

### Wie deploye ich eine Dashboard.json in Grafana?

1. Über Grafana UI links im Menu mit der Maus über das Plus hovern
2. Den 3. Punkt "Import" auswählen
3. "Upload JSON file" auswählen und erstelltes JSON hochladen
4. Order für Dashboard auswählen und bestätigen
5. Dashboard liegt nun im ausgewählten Ordner vor und kann getestet werden

## Entwicklerworkflow

1. Dashboard.Jsonnet schreiben
2. Code commiten & pushen
3. Checkout aus Repository
4. Kompilieren
5. Testen
6. Kompilat hochladen
7. Kompilat deplyoen


