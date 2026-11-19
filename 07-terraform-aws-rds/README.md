# Terraform: AWS RDS module

PostgreSQL 16 on RDS: ingress only from the app's security groups, encrypted storage with autoscaling, password managed in Secrets Manager; Multi-AZ, backups, deletion protection, Performance Insights and a uniquely named final snapshot in production.

## Generated with

Tool `generate_terraform_module` (CrowVault `devops-mcp` server). The exact request is in [`request.json`](request.json):

```json
{
  "server": "devops-mcp",
  "tool": "generate_terraform_module",
  "args": {
    "resourceType": "rds",
    "provider": "aws",
    "moduleName": "orders-db",
    "environment": "production"
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

- [`main.tf`](main.tf)
- [`variables.tf`](variables.tf)
- [`outputs.tf`](outputs.tf)

## Checked with

- `terraform fmt -check`: clean
- `terraform init -backend=false && terraform validate` (Terraform 1.9.8, AWS provider ~> 5.0): valid
- Not applied (no `plan` against an AWS account)
