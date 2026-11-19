# Dockerfile

Multi-stage Node 20 build: dev dependencies pruned, `NODE_ENV=production`, non-root user, health check on `/health`, and a `.dockerignore`.

## Generated with

Tool `generate_dockerfile` (CrowVault `devops-mcp` server). The exact request is in [`request.json`](request.json):

```json
{
  "server": "devops-mcp",
  "tool": "generate_dockerfile",
  "args": {
    "service": "orders-service",
    "runtime": "node",
    "baseImageVersion": "20",
    "port": 3000,
    "withHealthCheck": true
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

- [`Dockerfile`](Dockerfile)
- [`.dockerignore`](.dockerignore)

## Checked with

- hadolint 2.12.0: no findings
- Not built here: it needs your service's source and `package.json`
