-- Order aggregate schema (postgresql)
CREATE TABLE orders (
  id                       UUID          NOT NULL DEFAULT gen_random_uuid()  PRIMARY KEY,
  customer_id              UUID  NOT NULL,
  status                   VARCHAR(255)  NOT NULL,
  total_cents              INTEGER  NOT NULL,
  currency                 VARCHAR(255)  NOT NULL,
  created_at               TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
  updated_at               TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
  deleted_at               TIMESTAMPTZ  NULL
);

ALTER TABLE orders ADD CONSTRAINT fk_orders_customer_id
  FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE;

CREATE INDEX idx_orders_customer_id ON orders(customer_id);
