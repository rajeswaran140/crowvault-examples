# CrowVault examples

Real output from [CrowVault](https://crowvault.ai) for one project, **orders-service**, from database schema to deployment. The examples share one data model (example 01), one `/health` path, one image name and one API (`/v1`). Nothing in the example folders was edited by hand: each holds the generated files, the exact tool call that produced them, and what was actually checked, including what was not run.

Every check reruns on each push in [`.github/workflows/validate.yml`](.github/workflows/validate.yml). [`.ci/`](.ci/) holds the small harness it needs (a reference `calculateTotal`, tsconfig files); that part is hand-written.

_Generated 2026-11-19._

| # | Example | What you get |
|---|---|---|
| 01 | [Database schema](01-database-schema/) | An `Order` aggregate as PostgreSQL DDL and the matching Prisma model (`@@map`/`@map` to the same table and columns, same UUID ids), with audit timestamps, soft delete and an index on the foreign key. The foreign key to `customers` is left commented until that table exists. |
| 02 | [OpenAPI 3.0 spec](02-openapi-spec/) | CRUD endpoints for orders and customers using the fields from example 01, with operationIds, pagination, JWT auth and 400/401/404 responses. |
| 03 | [Dockerfile](03-dockerfile/) | Multi-stage Node 20 build: dev dependencies pruned, `NODE_ENV=production`, non-root user, health check on `/health`, and a `.dockerignore`. |
| 04 | [Docker Compose](04-docker-compose/) | The service (built from the Dockerfile in example 03) with PostgreSQL and Redis from official images, health checks, plus Prometheus and Grafana. |
| 05 | [Kubernetes manifests](05-kubernetes/) | Deployment, ServiceAccount (token not mounted), Service, ConfigMap, HPA (owns the replica count) and PodDisruptionBudget; non-root, seccomp RuntimeDefault, read-only root filesystem, probes on `/health`, `DATABASE_URL` from a Secret. |
| 06 | [GitHub Actions CI/CD](06-github-actions/) | Build and test on every push and PR. Only on pushes to main: push the image to GHCR, then deploy to Kubernetes with cluster credentials from a secret, behind a `production` environment. |
| 07 | [Terraform: AWS RDS module](07-terraform-aws-rds/) | PostgreSQL 16 on RDS: ingress only from the app's security groups, encrypted storage with autoscaling, password managed in Secrets Manager, Performance Insights, Multi-AZ, backups, deletion protection and a uniquely named final snapshot in production. |
| 08 | [Unit tests (Jest)](08-unit-tests-jest/) | Structured cases become real assertions (`toEqual`, `toThrow`); a described-only case becomes `it.todo` instead of a fake passing test. |
| 09 | [End-to-end tests (Playwright)](09-e2e-playwright/) | Smoke checks that hold on any site (status, title, console errors, failed requests, broken links, axe accessibility), the checkout steps as real code, and a mobile check that runs as its own `mobile-safari` project. |
| 10 | [Consumer contract (Pact)](10-contract-pact/) | One test per interaction against the Pact mock server, using the order fields from example 01 and the `/v1` paths from example 02. Running them writes the pact file (committed here as `pacts/orders-web-orders-service.json`); the provider verification test is included for orders-service to run. |
| 11 | [Azure Container App (Bicep)](11-azure-container-app/) | Log Analytics workspace, Container Apps environment and the app with ingress, CORS limited to the shop origin, at least one replica, HTTP scaling and probes on `/health`. |

## Try it

- No sign-up: [crowvault.ai/playground](https://crowvault.ai/playground)
- Free API key (50 calls/month): [crowvault.ai/register](https://crowvault.ai/register)
- MCP (Claude Code):

```bash
claude mcp add --transport http crowvault https://api.crowvault.ai/mcp \
  --header "Authorization: Bearer $CROWVAULT_API_KEY"
```

Listed in the official MCP Registry as `io.github.rajeswaran140/crowvault`.
