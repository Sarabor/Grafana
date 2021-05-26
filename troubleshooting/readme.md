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