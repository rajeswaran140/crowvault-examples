# Consumer contract (Pact)

One test per interaction against the Pact mock server, using the order fields from example 01 and the `/v1` paths from example 02. Running them writes the pact file (committed here as `pacts/orders-web-orders-service.json`); the provider verification test is included for orders-service to run.

## Generated with

Tool `generate_pact_contract_test` (CrowVault `testing` server) with:

```json
{
  "consumer": "orders-web",
  "provider": "orders-service",
  "interactions": [
    {
      "description": "gets an order",
      "state": "order 7f3c9a2e-0000-4000-8000-000000000001 exists",
      "method": "GET",
      "path": "/v1/orders/7f3c9a2e-0000-4000-8000-000000000001",
      "status": 200,
      "responseBody": {
        "id": "7f3c9a2e-0000-4000-8000-000000000001",
        "customer_id": "0b6d1f4a-0000-4000-8000-000000000002",
        "status": "pending",
        "total_cents": 2900,
        "currency": "USD"
      }
    },
    {
      "description": "creates an order",
      "state": "customer 0b6d1f4a-0000-4000-8000-000000000002 exists",
      "method": "POST",
      "path": "/v1/orders",
      "status": 201,
      "requestBody": {
        "customer_id": "0b6d1f4a-0000-4000-8000-000000000002",
        "status": "pending",
        "total_cents": 2900,
        "currency": "USD"
      },
      "responseBody": {
        "id": "7f3c9a2e-0000-4000-8000-000000000001",
        "customer_id": "0b6d1f4a-0000-4000-8000-000000000002",
        "status": "pending",
        "total_cents": 2900,
        "currency": "USD"
      }
    }
  ]
}
```

From Claude Code, Cursor or any MCP client connected to CrowVault, ask for it in plain words, or call the API:

```bash
curl -s https://api.crowvault.ai/v1/tools/call \
  -H "Authorization: Bearer $CROWVAULT_API_KEY" -H 'Content-Type: application/json' \
  -d '{"server": "testing-mcp", "tool": "generate_pact_contract_test", "args": {"consumer": "orders-web", "provider": "orders-service", "interactions": [{"description": "gets an order", "state": "order 7f3c9a2e-0000-4000-8000-000000000001 exists", "method": "GET", "path": "/v1/orders/7f3c9a2e-0000-4000-8000-000000000001", "status": 200, "responseBody": {"id": "7f3c9a2e-0000-4000-8000-000000000001", "customer_id": "0b6d1f4a-0000-4000-8000-000000000002", "status": "pending", "total_cents": 2900, "currency": "USD"}}, {"description": "creates an order", "state": "customer 0b6d1f4a-0000-4000-8000-000000000002 exists", "method": "POST", "path": "/v1/orders", "status": 201, "requestBody": {"customer_id": "0b6d1f4a-0000-4000-8000-000000000002", "status": "pending", "total_cents": 2900, "currency": "USD"}, "responseBody": {"id": "7f3c9a2e-0000-4000-8000-000000000001", "customer_id": "0b6d1f4a-0000-4000-8000-000000000002", "status": "pending", "total_cents": 2900, "currency": "USD"}}]}}'
```

## Files

- [`test/orders-web.pact.test.ts`](test/orders-web.pact.test.ts)
- [`test/orders-service.verify.test.ts`](test/orders-service.verify.test.ts)

## Checked with

- `tsc --noEmit --strict`: no errors
- Consumer tests run with @pact-foundation/pact 13.1.4: 2 passed; the pact file they wrote is committed in [`pacts/`](pacts/)
- Provider verification **not run**: it needs a running orders-service with the two provider states
