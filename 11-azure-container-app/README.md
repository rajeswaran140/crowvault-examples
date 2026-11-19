# Azure Container App (Bicep)

Log Analytics workspace, Container Apps environment and the app with ingress, CORS limited to the shop origin, at least one replica, HTTP scaling and probes on `/health`.

## Generated with

Tool `generate_container_app` (CrowVault `azure-mcp` server). The exact request is in [`request.json`](request.json):

```json
{
  "server": "azure-mcp",
  "tool": "generate_container_app",
  "args": {
    "name": "orders-service",
    "location": "eastus",
    "image": "ghcr.io/acme/orders-service:1.0.0",
    "targetPort": 3000,
    "cpu": 0.5,
    "allowedOrigins": [
      "https://shop.example.com"
    ],
    "healthPath": "/health"
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

- [`main.bicep`](main.bicep)

## Checked with

- `bicep build` and `bicep lint` (Bicep CLI 0.48.1): no errors or warnings
- Not deployed
