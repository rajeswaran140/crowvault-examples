# Database schema

An `Order` aggregate as PostgreSQL DDL and a Prisma model, with audit timestamps, soft delete and an index on the foreign key.

## Generated with

Tool `design_schema` (CrowVault `database` server) with:

```json
{
  "aggregate": "Order",
  "database": "postgresql",
  "fields": [
    "customer_id:uuid",
    "status:string",
    "total_cents:integer",
    "currency:string"
  ],
  "outputFormat": "both",
  "withTimestamps": true,
  "withSoftDelete": true
}
```

From Claude Code, Cursor or any MCP client connected to CrowVault, ask for it in plain words, or call the API:

```bash
curl -s https://api.crowvault.ai/v1/tools/call \
  -H "Authorization: Bearer $CROWVAULT_API_KEY" -H 'Content-Type: application/json' \
  -d '{"server": "database-mcp", "tool": "design_schema", "args": {"aggregate": "Order", "database": "postgresql", "fields": ["customer_id:uuid", "status:string", "total_cents:integer", "currency:string"], "outputFormat": "both", "withTimestamps": true, "withSoftDelete": true}}'
```

## Files

- [`schema.sql`](schema.sql)
- [`schema.prisma`](schema.prisma)

## Checked with

PostgreSQL parser (sqlglot)
