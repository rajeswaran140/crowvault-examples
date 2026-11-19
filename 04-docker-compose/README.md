# Docker Compose

The service (built from the Dockerfile in example 03) with PostgreSQL and Redis from official images, health checks, Prometheus and Grafana, plus an example env file and the `--env-file` command.

## Generated with

Tool `generate_docker_compose` (CrowVault `devops-mcp` server). The exact request is in [`request.json`](request.json):

```json
{
  "server": "devops-mcp",
  "tool": "generate_docker_compose",
  "args": {
    "services": [
      "orders-service",
      "postgres",
      "redis"
    ],
    "environment": "development",
    "withObservability": true
  }
}
```

From Claude Code, Cursor or any MCP client connected to CrowVault, ask for it in plain words, or call the API:

```bash
curl -s https://api.crowvault.ai/v1/tools/call \
  -H "Authorization: Bearer $CROWVAULT_API_KEY" -H 'Content-Type: application/json' \
  --data-binary @request.json
```

## Files

- [`docker-compose.yml`](docker-compose.yml)
- [`infra/prometheus/prometheus.yml`](infra/prometheus/prometheus.yml)
- [`.env.development.example`](.env.development.example)

## Checked with

- `docker compose --env-file .env.development config` with the example env file: valid
- Not started here: the `orders-service` build context is your service's folder
