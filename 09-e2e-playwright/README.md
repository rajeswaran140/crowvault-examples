# End-to-end tests (Playwright)

Smoke checks that hold on any site (status, title, console errors, failed requests, broken links, axe accessibility), the checkout steps as real code, and a mobile check that runs as its own `mobile-safari` project.

## Generated with

Tool `generate_playwright_test` (CrowVault `testing-mcp` server). The exact request is in [`request.json`](request.json):

```json
{
  "server": "testing-mcp",
  "tool": "generate_playwright_test",
  "args": {
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
}
```

From Claude Code, Cursor or any MCP client connected to CrowVault, ask for it in plain words, or call the API:

```bash
curl -s https://api.crowvault.ai/v1/tools/call \
  -H "Authorization: Bearer $CROWVAULT_API_KEY" -H 'Content-Type: application/json' \
  --data-binary @request.json
```

## Files

- [`e2e/checkout.spec.ts`](e2e/checkout.spec.ts)
- [`playwright.config.ts`](playwright.config.ts)

## Checked with

- `tsc --noEmit --strict`: no errors
- `playwright test --list` (Playwright 1.48.2): 5 tests load, 4 in `chromium` and 1 in `mobile-safari`
- Not run here: shop.example.com is a placeholder
