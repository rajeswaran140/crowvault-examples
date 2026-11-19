# Azure Container App (Bicep)

Log Analytics workspace, Container Apps environment and the app with ingress, scaling and health probes.

## Generated with

Tool `generate_container_app` (CrowVault `azure` server) with:

```json
{
  "name": "orders-service",
  "location": "eastus",
  "image": "ghcr.io/acme/orders-service:1.0.0",
  "targetPort": 3000,
  "cpu": 0.5
}
```

From Claude Code, Cursor or any MCP client connected to CrowVault, ask for it in plain words, or call the API:

```bash
curl -s https://api.crowvault.ai/v1/tools/call \
  -H "Authorization: Bearer $CROWVAULT_API_KEY" -H 'Content-Type: application/json' \
  -d '{"server": "azure-mcp", "tool": "generate_container_app", "args": {"name": "orders-service", "location": "eastus", "image": "ghcr.io/acme/orders-service:1.0.0", "targetPort": 3000, "cpu": 0.5}}'
```

## Files

- [`main.bicep`](main.bicep)

## Checked with

`bicep build` (Bicep CLI 0.48.1)
