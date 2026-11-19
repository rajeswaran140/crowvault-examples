# End-to-end tests (Playwright)

Smoke checks that hold on any site (status, title, console errors, failed requests, broken links, axe accessibility), the checkout steps as real code, and a mobile viewport check.

## Generated with

Tool `generate_playwright_test` (CrowVault `testing` server) with:

```json
{
  "testName": "checkout",
  "url": "https://shop.example.com",
  "actions": [
    "click #add-to-cart",
    "goto /cart",
    "fill \"input[name=email]\" jane@example.com",
    "click button[type=submit]"
  ],
  "assertions": [
    "url /order-confirmed",
    "text h1 Thank you"
  ],
  "mobile": true
}
```

From Claude Code, Cursor or any MCP client connected to CrowVault, ask for it in plain words, or call the API:

```bash
curl -s https://api.crowvault.ai/v1/tools/call \
  -H "Authorization: Bearer $CROWVAULT_API_KEY" -H 'Content-Type: application/json' \
  -d '{"server": "testing-mcp", "tool": "generate_playwright_test", "args": {"testName": "checkout", "url": "https://shop.example.com", "actions": ["click #add-to-cart", "goto /cart", "fill \"input[name=email]\" jane@example.com", "click button[type=submit]"], "assertions": ["url /order-confirmed", "text h1 Thank you"], "mobile": true}}'
```

## Files

- [`e2e/checkout.spec.ts`](e2e/checkout.spec.ts)
- [`playwright.config.ts`](playwright.config.ts)

## Checked with

esbuild (TypeScript); smoke checks run against a live site
