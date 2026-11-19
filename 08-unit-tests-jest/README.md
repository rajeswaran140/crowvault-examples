# Unit tests (Jest)

Structured cases become real assertions (`toEqual`, `toThrow`); a described-only case becomes `it.todo` instead of a fake passing test.

## Generated with

Tool `generate_jest_test` (CrowVault `testing` server) with:

```json
{
  "functionName": "calculateTotal",
  "modulePath": "../src/orders/calculateTotal",
  "testCases": [
    {
      "name": "sums line items",
      "input": [
        [
          {
            "priceCents": 1200,
            "qty": 2
          },
          {
            "priceCents": 500,
            "qty": 1
          }
        ]
      ],
      "expected": 2900
    },
    {
      "name": "returns 0 for an empty cart",
      "input": [
        []
      ],
      "expected": 0
    },
    {
      "name": "rejects a negative quantity",
      "input": [
        [
          {
            "priceCents": 1200,
            "qty": -1
          }
        ]
      ],
      "throws": "quantity"
    },
    "applies the loyalty discount"
  ]
}
```

From Claude Code, Cursor or any MCP client connected to CrowVault, ask for it in plain words, or call the API:

```bash
curl -s https://api.crowvault.ai/v1/tools/call \
  -H "Authorization: Bearer $CROWVAULT_API_KEY" -H 'Content-Type: application/json' \
  -d '{"server": "testing-mcp", "tool": "generate_jest_test", "args": {"functionName": "calculateTotal", "modulePath": "../src/orders/calculateTotal", "testCases": [{"name": "sums line items", "input": [[{"priceCents": 1200, "qty": 2}, {"priceCents": 500, "qty": 1}]], "expected": 2900}, {"name": "returns 0 for an empty cart", "input": [[]], "expected": 0}, {"name": "rejects a negative quantity", "input": [[{"priceCents": 1200, "qty": -1}]], "throws": "quantity"}, "applies the loyalty discount"]}}'
```

## Files

- [`calculateTotal.test.ts`](calculateTotal.test.ts)

## Checked with

esbuild (TypeScript)
