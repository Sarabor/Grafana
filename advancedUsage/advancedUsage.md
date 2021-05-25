## Advanced Usage

This is when you want to get a smoother development experience and make use of the Grafana API.

### For advanced usage
- Docker
- Running Grafana Container
- jq
- Jsonnet
- Grafonnet
- Any console that works for you. I used Git Bash

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