# Consumer contract (Pact)

One test per interaction against the Pact mock server, writing `pacts/orders-web-orders-service.json`, plus the provider verification.

## Generated with

Tool `generate_pact_contract_test` (CrowVault `testing` server) with:

```json
{
  "consumer": "orders-web",
  "provider": "orders-service",
  "interactions": [
    "GET /orders/1 200",
    {
      "description": "creates an order",
      "state": "a cart exists",
      "method": "POST",
      "path": "/orders",
      "requestBody": {
        "sku": "A1",
        "qty": 2
      },
      "responseBody": {
        "id": "o-1",
        "status": "pending"
      }
    }
  ]
}
```

From Claude Code, Cursor or any MCP client connected to CrowVault, ask for it in plain words, or call the API:

```bash
curl -s https://api.crowvault.ai/v1/tools/call \
  -H "Authorization: Bearer $CROWVAULT_API_KEY" -H 'Content-Type: application/json' \
  -d '{"server": "testing-mcp", "tool": "generate_pact_contract_test", "args": {"consumer": "orders-web", "provider": "orders-service", "interactions": ["GET /orders/1 200", {"description": "creates an order", "state": "a cart exists", "method": "POST", "path": "/orders", "requestBody": {"sku": "A1", "qty": 2}, "responseBody": {"id": "o-1", "status": "pending"}}]}}'
```

## Files

- [`test/orders-web.pact.test.ts`](test/orders-web.pact.test.ts)
- [`test/orders-service.verify.test.ts`](test/orders-service.verify.test.ts)

## Checked with

Run with @pact-foundation/pact: 3/3 passed
