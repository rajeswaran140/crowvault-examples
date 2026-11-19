# Terraform: AWS RDS module

PostgreSQL 16 on RDS: ingress only from the app's security groups, encrypted storage with autoscaling, password managed in Secrets Manager, Performance Insights, Multi-AZ, backups, deletion protection and a uniquely named final snapshot in production.

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

- `terraform init -backend=false && terraform validate` (Terraform 1.9.8, AWS provider ~> 5.0): valid
- Not applied (no `plan` against an AWS account)
