# OpenAPI 3.0 spec

CRUD endpoints for orders and customers using the fields from example 01, with operationIds, pagination, JWT auth and 400/401/404 responses.

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
  "withAuth": true,
  "fields": {
    "orders": [
      "customer_id:uuid",
      "status:string",
      "total_cents:integer",
      "currency:string"
    ],
    "customers": [
      "email:email",
      "name:string"
    ]
  }
}
```

From Claude Code, Cursor or any MCP client connected to CrowVault, ask for it in plain words, or call the API:

```bash
curl -s https://api.crowvault.ai/v1/tools/call \
  -H "Authorization: Bearer $CROWVAULT_API_KEY" -H 'Content-Type: application/json' \
  -d '{"server": "api-mcp", "tool": "generate_openapi_spec", "args": {"service": "orders-service", "resources": ["orders", "customers"], "version": "1.0.0", "withAuth": true, "fields": {"orders": ["customer_id:uuid", "status:string", "total_cents:integer", "currency:string"], "customers": ["email:email", "name:string"]}}}'
```

## Files

- [`openapi.yaml`](openapi.yaml)

## Checked with

- Redocly CLI 1.25.11 `lint`: valid, 3 warnings (no `info.license`; the server URLs use example.com)
