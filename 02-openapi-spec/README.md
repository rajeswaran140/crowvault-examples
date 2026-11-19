# OpenAPI 3.0 spec

CRUD for orders and customers with the fields from example 01 in snake_case: `status` enum, `currency` as a 3-letter code, `*Input` for create and `*Patch` (any subset) for PATCH, 400 on invalid ids, pagination, JWT auth and an MIT license.

## Generated with

Tool `generate_openapi_spec` (CrowVault `api-mcp` server). The exact request is in [`request.json`](request.json):

```json
{
  "server": "api-mcp",
  "tool": "generate_openapi_spec",
  "args": {
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
        "status:enum(pending,paid,shipped,cancelled)",
        "total_cents:integer",
        "currency:char(3)"
      ],
      "customers": [
        "email:email",
        "name:string"
      ]
    },
    "naming": "snake_case"
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

- [`openapi.yaml`](openapi.yaml)

## Checked with

- Redocly CLI 1.25.11 `lint`: valid, 2 warnings (the server URLs use example.com)
