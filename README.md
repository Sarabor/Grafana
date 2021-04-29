# Grafana
Everything you need to get started to use Grafana


Zum Einrichten von Grafana

Für Container

1. docker-compose up -d auszuführen, um Grafana Image zu installieren und Container zu starten.

Für Jsonnet

2. go lang installieren https://golang.org/
   
3. Speicherort für Library wählen und in der Konsole folgende Befehle ausführen 
   
   Package Downloaden
   
        go get github.com/google/go-jsonnet/cmd/jsonnet
   Zum Builden
   
        git clone https://github.com/google/go-jsonnet.git
        cd go-jsonnet
        go build ./cmd/jsonnet
        go build ./cmd/jsonnetfmt
        go build ./cmd/jsonnet-deps

Für Grafonnet

4. Speicherort für Library wählen und in der Konsole folgenden Befehl ausführen 
   
         git clone https://github.com/grafana/grafonnet-lib.git
   
5. Grafonnet Speicherort als Umgebungsvariable anlegen. Variable "grafonnet" nennen

Provisioning Testdatenbank Oder Bash Script Testdatenbank?


Wie erstelle ich eine Dashboard.json aus einer Dashboard.jsonnet?

1. Dashboard.jsonnet schreiben
2. In Windows Powershell
   
         jsonnet -J $env:grafonnet dashboard.jsonnet > dashboard.json

3. Dashboard.json liegt nun im gleichen Ordner als Datei vor

Wie deploye ich eine Dashboard.json in Grafana?

      

Entwicklerworkflow


Schritt für Schritt anleitung, um Dashboards und deployen
