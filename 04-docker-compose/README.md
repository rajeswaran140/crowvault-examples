# Docker Compose

The service with PostgreSQL and Redis from official images (with health checks), plus Prometheus and Grafana.

## Generated with

Tool `generate_docker_compose` (CrowVault `devops` server) with:

```json
{
  "services": [
    "orders-service",
    "postgres",
    "redis"
  ],
  "environment": "development",
  "withObservability": true
}
```

From Claude Code, Cursor or any MCP client connected to CrowVault, ask for it in plain words, or call the API:

```bash
curl -s https://api.crowvault.ai/v1/tools/call \
  -H "Authorization: Bearer $CROWVAULT_API_KEY" -H 'Content-Type: application/json' \
  -d '{"server": "devops-mcp", "tool": "generate_docker_compose", "args": {"services": ["orders-service", "postgres", "redis"], "environment": "development", "withObservability": true}}'
```

## Files

- [`docker-compose.yml`](docker-compose.yml)
- [`infra/prometheus/prometheus.yml`](infra/prometheus/prometheus.yml)

## Checked with

`docker compose config`
