# Dockerfile

Multi-stage Node 20 build: slim runtime image, non-root user, health check.

## Generated with

Tool `generate_dockerfile` (CrowVault `devops` server) with:

```json
{
  "service": "orders-service",
  "runtime": "node",
  "baseImageVersion": "20",
  "port": 3000,
  "withHealthCheck": true
}
```

From Claude Code, Cursor or any MCP client connected to CrowVault, ask for it in plain words, or call the API:

```bash
curl -s https://api.crowvault.ai/v1/tools/call \
  -H "Authorization: Bearer $CROWVAULT_API_KEY" -H 'Content-Type: application/json' \
  -d '{"server": "devops-mcp", "tool": "generate_dockerfile", "args": {"service": "orders-service", "runtime": "node", "baseImageVersion": "20", "port": 3000, "withHealthCheck": true}}'
```

## Files

- [`Dockerfile`](Dockerfile)

## Checked with

—
