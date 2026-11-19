# GitHub Actions CI/CD

Build and test on every PR, build and push the image to GHCR, deploy to Kubernetes on main.

## Generated with

Tool `generate_github_actions` (CrowVault `devops` server) with:

```json
{
  "service": "orders-service",
  "runtime": "node",
  "deployTarget": "kubernetes",
  "withDockerBuild": true
}
```

From Claude Code, Cursor or any MCP client connected to CrowVault, ask for it in plain words, or call the API:

```bash
curl -s https://api.crowvault.ai/v1/tools/call \
  -H "Authorization: Bearer $CROWVAULT_API_KEY" -H 'Content-Type: application/json' \
  -d '{"server": "devops-mcp", "tool": "generate_github_actions", "args": {"service": "orders-service", "runtime": "node", "deployTarget": "kubernetes", "withDockerBuild": true}}'
```

## Files

- [`.github/workflows/ci.yml`](.github/workflows/ci.yml)

## Checked with

actionlint
