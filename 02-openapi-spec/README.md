# OpenAPI 3.0 spec

CRUD endpoints for orders and customers with operationIds, pagination, JWT auth and 400/401/404 responses.

## Generated with

Tool `generate_openapi_spec` (CrowVault `api` server) with:

```json
{
  "service": "orders-service",
  "resources": [
    "orders",
    "customers"
  ],
  "version": "1.0.0",
  "withAuth": true
}
```

From Claude Code, Cursor or any MCP client connected to CrowVault, ask for it in plain words, or call the API:

```bash
curl -s https://api.crowvault.ai/v1/tools/call \
  -H "Authorization: Bearer $CROWVAULT_API_KEY" -H 'Content-Type: application/json' \
  -d '{"server": "api-mcp", "tool": "generate_openapi_spec", "args": {"service": "orders-service", "resources": ["orders", "customers"], "version": "1.0.0", "withAuth": true}}'
```

## Files

- [`openapi.yaml`](openapi.yaml)

## Checked with

Redocly CLI lint
