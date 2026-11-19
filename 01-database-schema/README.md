# Database schema

An `Order` aggregate as PostgreSQL DDL and the matching Prisma model (`@@map`/`@map` to the same table and columns, same UUID ids), with audit timestamps, soft delete and an index on the foreign key. The foreign key to `customers` is left commented until that table exists.

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

- Applied to PostgreSQL 16 with `psql -v ON_ERROR_STOP=1` (table and index created)
- `prisma validate` (Prisma 5.22.0): valid
