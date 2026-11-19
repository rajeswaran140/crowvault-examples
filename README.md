# CrowVault examples

Real output from [CrowVault](https://crowvault.ai) for one project, **orders-service**, from database schema to deployment. Nothing here was edited by hand: each folder holds the generated files, the exact tool call that produced them, and the validator they were checked with.

| # | Example | What you get |
|---|---|---|
| 01 | [Database schema](01-database-schema/) | An `Order` aggregate as PostgreSQL DDL and a Prisma model, with audit timestamps, soft delete and an index on the foreign key. |
| 02 | [OpenAPI 3.0 spec](02-openapi-spec/) | CRUD endpoints for orders and customers with operationIds, pagination, JWT auth and 400/401/404 responses. |
| 03 | [Dockerfile](03-dockerfile/) | Multi-stage Node 20 build: slim runtime image, non-root user, health check. |
| 04 | [Docker Compose](04-docker-compose/) | The service with PostgreSQL and Redis from official images (with health checks), plus Prometheus and Grafana. |
| 05 | [Kubernetes manifests](05-kubernetes/) | Deployment, ServiceAccount (token not mounted), Service, ConfigMap and HPA; non-root, read-only root filesystem with a writable /tmp. |
| 06 | [GitHub Actions CI/CD](06-github-actions/) | Build and test on every PR, build and push the image to GHCR, deploy to Kubernetes on main. |
| 07 | [Terraform: AWS RDS module](07-terraform-aws-rds/) | PostgreSQL 16 on RDS: encrypted storage, password managed in Secrets Manager, private subnets, Multi-AZ, backups and deletion protection in production. |
| 08 | [Unit tests (Jest)](08-unit-tests-jest/) | Structured cases become real assertions (`toEqual`, `toThrow`); a described-only case becomes `it.todo` instead of a fake passing test. |
| 09 | [End-to-end tests (Playwright)](09-e2e-playwright/) | Smoke checks that hold on any site (status, title, console errors, failed requests, broken links, axe accessibility), the checkout steps as real code, and a mobile viewport check. |
| 10 | [Consumer contract (Pact)](10-contract-pact/) | One test per interaction against the Pact mock server, writing `pacts/orders-web-orders-service.json`, plus the provider verification. |
| 11 | [Azure Container App (Bicep)](11-azure-container-app/) | Log Analytics workspace, Container Apps environment and the app with ingress, scaling and health probes. |

## Try it

- No sign-up: [crowvault.ai/playground](https://crowvault.ai/playground)
- Free API key (50 calls/month): [crowvault.ai/register](https://crowvault.ai/register)
- MCP (Claude Code):

```bash
claude mcp add --transport http crowvault https://api.crowvault.ai/mcp \
  --header "Authorization: Bearer $CROWVAULT_API_KEY"
```

Listed in the official MCP Registry as `io.github.rajeswaran140/crowvault`.
