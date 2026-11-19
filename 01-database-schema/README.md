# Database schema

An `Order` aggregate as PostgreSQL DDL and the matching Prisma model: same table, snake_case columns (`@map`), UUID ids, a native `order_status` enum shared by both, `CHAR(3)` currency, audit timestamps, soft delete and an index on the foreign key. The foreign key to `customers` stays commented until that table exists.

## Generated with

Tool `design_schema` (CrowVault `database-mcp` server). The exact request is in [`request.json`](request.json):

```json
{
  "server": "database-mcp",
  "tool": "design_schema",
  "args": {
    "aggregate": "Order",
    "database": "postgresql",
    "fields": [
      "customer_id:uuid",
      "status:enum(pending,paid,shipped,cancelled)",
      "total_cents:integer",
      "currency:char(3)"
    ],
    "outputFormat": "both",
    "withTimestamps": true,
    "withSoftDelete": true
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

- [`schema.sql`](schema.sql)
- [`schema.prisma`](schema.prisma)

## Checked with

- Applied to PostgreSQL 16 with `psql -v ON_ERROR_STOP=1`: enum type, table and index created
- `prisma validate` (Prisma 5.22.0): valid
- `prisma migrate diff` from that database to `schema.prisma`: **No difference detected**, so the SQL and the Prisma model describe the same table
