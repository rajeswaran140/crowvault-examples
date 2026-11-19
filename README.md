# CrowVault examples

[![validate](https://github.com/rajeswaran140/crowvault-examples/actions/workflows/validate.yml/badge.svg)](https://github.com/rajeswaran140/crowvault-examples/actions/workflows/validate.yml)

Real output from [CrowVault](https://crowvault.ai) for one project, **orders-service**, from database schema to deployment. The examples share one data model (example 01: snake_case fields, a `status` enum, a 3-letter `currency`), one `/health` path, one image name and one API (`/v1`).

Nothing in the example folders is edited by hand: each holds the generated files, the `request.json` that produced them, and a README that says what was checked, and what was not run.

_Generated 2026-11-19 with CrowVault v2.2.0-36-g1807c0d._

| # | Example | What you get |
|---|---|---|
| 01 | [Database schema](01-database-schema/) | An `Order` aggregate as PostgreSQL DDL and the matching Prisma model: same table, snake_case columns (`@map`), UUID ids, a native `order_status` enum shared by both, `CHAR(3)` currency, audit timestamps, soft delete and an index on the foreign key. The foreign key to `customers` stays commented until that table exists. |
| 02 | [OpenAPI 3.0 spec](02-openapi-spec/) | CRUD for orders and customers with the fields from example 01 in snake_case: `status` enum, `currency` as a 3-letter code, `*Input` for create and `*Patch` (any subset) for PATCH, 400 on invalid ids, pagination, JWT auth and an MIT license. |
| 03 | [Dockerfile](03-dockerfile/) | Multi-stage Node 20 build: dev dependencies pruned, `NODE_ENV=production`, non-root user, health check on `/health`, and a `.dockerignore`. |
| 04 | [Docker Compose](04-docker-compose/) | The service (built from the Dockerfile in example 03) with PostgreSQL and Redis from official images, health checks, Prometheus and Grafana, plus an example env file and the `--env-file` command. |
| 05 | [Kubernetes manifests](05-kubernetes/) | Deployment, ServiceAccount (token not mounted), Service, ConfigMap, HPA (owns the replica count) and PodDisruptionBudget; non-root, seccomp RuntimeDefault, read-only root filesystem, startup/readiness/liveness probes on `/health`, and a required Secret for `DATABASE_URL`. |
| 06 | [GitHub Actions CI/CD](06-github-actions/) | Build and test on every push and PR. Only on pushes to main: push the image to GHCR, then deploy to Kubernetes behind a `production` environment, with the kubeconfig secret passed through `env` and a clear error if it is missing. |
| 07 | [Terraform: AWS RDS module](07-terraform-aws-rds/) | PostgreSQL 16 on RDS: ingress only from the app's security groups, encrypted storage with autoscaling, password managed in Secrets Manager; Multi-AZ, backups, deletion protection, Performance Insights and a uniquely named final snapshot in production. |
| 08 | [Unit tests (Jest)](08-unit-tests-jest/) | Structured cases become real assertions (`toEqual`, `toThrow`); a described-only case becomes `it.todo` instead of a fake passing test. |
| 09 | [End-to-end tests (Playwright)](09-e2e-playwright/) | Smoke checks that hold on any site (status, title, console errors, failed requests, broken links, axe accessibility), the checkout steps as real code, and a mobile check that runs as its own `mobile-safari` project. |
| 10 | [Consumer contract (Pact)](10-contract-pact/) | One test per interaction against the Pact mock server, with the snake_case order fields from examples 01 and 02 and the `/v1` paths. Running them writes the pact file committed in `pacts/`. The provider verification has a state handler for each provider state, ready for orders-service to seed. |
| 11 | [Azure Container App (Bicep)](11-azure-container-app/) | Log Analytics workspace, Container Apps environment and the app with ingress, CORS limited to the shop origin, at least one replica, HTTP scaling and probes on `/health`. |

## Reproduce

1. Each example folder has a `request.json`: the exact API request.
2. [`scripts/regenerate.sh`](scripts/regenerate.sh) posts every `request.json` to the CrowVault API and writes the returned files (file names per code block are in [`scripts/layout.json`](scripts/layout.json)):

   ```bash
   export CROWVAULT_API_KEY=...   # a free-plan key: paid plans add AI augmentation, which is not reproducible
   scripts/regenerate.sh && git diff --stat
   ```

3. [`.github/workflows/validate.yml`](.github/workflows/validate.yml) checks every example on each push, and its manual `reproduce` run regenerates everything and fails if the output differs from what is committed.

[`.ci/`](.ci/) holds the small hand-written harness the checks need (a reference `calculateTotal`, a tsconfig).

## Try it

- No sign-up: [crowvault.ai/playground](https://crowvault.ai/playground)
- Free API key (50 calls/month): [crowvault.ai/register](https://crowvault.ai/register)
- MCP (Claude Code):

```bash
claude mcp add --transport http crowvault https://api.crowvault.ai/mcp \
  --header "Authorization: Bearer $CROWVAULT_API_KEY"
```

Listed in the official MCP Registry as `io.github.rajeswaran140/crowvault`.

## License

[MIT](LICENSE)
