# Terraform: AWS RDS module

PostgreSQL 16 on RDS: encrypted storage, password managed in Secrets Manager, private subnets, Multi-AZ, backups and deletion protection in production.

## Generated with

Tool `generate_terraform_module` (CrowVault `devops` server) with:

```json
{
  "resourceType": "rds",
  "provider": "aws",
  "moduleName": "orders-db",
  "environment": "production"
}
```

From Claude Code, Cursor or any MCP client connected to CrowVault, ask for it in plain words, or call the API:

```bash
curl -s https://api.crowvault.ai/v1/tools/call \
  -H "Authorization: Bearer $CROWVAULT_API_KEY" -H 'Content-Type: application/json' \
  -d '{"server": "devops-mcp", "tool": "generate_terraform_module", "args": {"resourceType": "rds", "provider": "aws", "moduleName": "orders-db", "environment": "production"}}'
```

## Files

- [`main.tf`](main.tf)
- [`variables.tf`](variables.tf)
- [`outputs.tf`](outputs.tf)

## Checked with

`terraform validate` (AWS provider ~> 5.0)
