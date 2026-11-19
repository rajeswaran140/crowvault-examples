# Consumer contract (Pact)

One test per interaction against the Pact mock server, with the snake_case order fields from examples 01 and 02 and the `/v1` paths. Running them writes the pact file committed in `pacts/`. The provider verification has a state handler for each provider state, ready for orders-service to seed.

## Generated with

Tool `generate_pact_contract_test` (CrowVault `testing-mcp` server). The exact request is in [`request.json`](request.json):

```json
{
  "server": "testing-mcp",
  "tool": "generate_pact_contract_test",
  "args": {
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
}
```

From Claude Code, Cursor or any MCP client connected to CrowVault, ask for it in plain words, or call the API:

```bash
curl -s https://api.crowvault.ai/v1/tools/call \
  -H "Authorization: Bearer $CROWVAULT_API_KEY" -H 'Content-Type: application/json' \
  --data-binary @request.json
```

## Files

- [`test/orders-web.pact.test.ts`](test/orders-web.pact.test.ts)
- [`test/orders-service.verify.test.ts`](test/orders-service.verify.test.ts)
- [`pacts/orders-web-orders-service.json`](pacts/orders-web-orders-service.json)

## Checked with

- `tsc --noEmit --strict`: no errors
- Consumer tests with @pact-foundation/pact 13.1.4: 2 passed. CI reruns them and fails if the pact differs from the committed [`pacts/`](pacts/) file (metadata aside)
- Provider verification **not run**: it needs a running orders-service; its two state handlers are stubs to fill in
