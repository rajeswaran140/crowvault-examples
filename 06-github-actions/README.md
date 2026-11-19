# GitHub Actions CI/CD

Build and test on every push and PR. Only on pushes to main: push the image to GHCR, then deploy to Kubernetes with cluster credentials from a secret, behind a `production` environment.

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

- actionlint 1.7.4: no findings
- Not run on GitHub: the deploy job needs a `KUBECONFIG_B64` secret and a `production` environment
