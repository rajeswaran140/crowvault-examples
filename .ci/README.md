# CI harness (hand-written)

Used only by `.github/workflows/validate.yml`. None of this is CrowVault output.

- `unit/src/orders/calculateTotal.ts`: a small reference implementation so the generated Jest tests in `08-unit-tests-jest` can actually run.
- `ts/tsconfig.json`: strict type-checking settings for the generated TypeScript.
