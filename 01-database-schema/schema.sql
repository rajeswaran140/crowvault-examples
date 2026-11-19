-- Order aggregate schema (postgresql)
CREATE TYPE order_status AS ENUM ('pending', 'paid', 'shipped', 'cancelled');

CREATE TABLE orders (
  id                       UUID          NOT NULL DEFAULT gen_random_uuid()  PRIMARY KEY,
  customer_id              UUID  NOT NULL,
  status                   order_status  NOT NULL,
  total_cents              INTEGER  NOT NULL,
  currency                 CHAR(3)  NOT NULL,
  created_at               TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
  updated_at               TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
  deleted_at               TIMESTAMPTZ  NULL
);

-- Add once table customers exists (pass existingModels: ["Customer"] to include it):
-- ALTER TABLE orders ADD CONSTRAINT fk_orders_customer_id
--   FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE RESTRICT;

CREATE INDEX idx_orders_customer_id ON orders(customer_id);
