# Kubernetes manifests

Deployment, ServiceAccount (token not mounted), Service, ConfigMap and HPA; non-root, read-only root filesystem with a writable /tmp.

## Generated with

Tool `generate_k8s_deployment` (CrowVault `devops` server) with:

```json
{
  "service": "orders-service",
  "image": "ghcr.io/acme/orders-service:1.0.0",
  "port": 3000,
  "replicas": 3,
  "withHPA": true
}
```

From Claude Code, Cursor or any MCP client connected to CrowVault, ask for it in plain words, or call the API:

```bash
curl -s https://api.crowvault.ai/v1/tools/call \
  -H "Authorization: Bearer $CROWVAULT_API_KEY" -H 'Content-Type: application/json' \
  -d '{"server": "devops-mcp", "tool": "generate_k8s_deployment", "args": {"service": "orders-service", "image": "ghcr.io/acme/orders-service:1.0.0", "port": 3000, "replicas": 3, "withHPA": true}}'
```

## Files

- [`k8s.yaml`](k8s.yaml)

## Checked with

kubeconform -strict
