-- Regions
CREATE TABLE region (
  id   BIGSERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE
);

-- Stores
CREATE TABLE store (
  id        BIGSERIAL PRIMARY KEY,
  name      VARCHAR(100) NOT NULL UNIQUE,
  region_id BIGINT NOT NULL REFERENCES region(id)
);

-- Exemptions (region-scoped OR store-scoped)
CREATE TABLE exemption (
  id        BIGSERIAL PRIMARY KEY,
  code      VARCHAR(50) NOT NULL,
  name      VARCHAR(100) NOT NULL,
  region_id BIGINT NULL REFERENCES region(id),
  store_id  BIGINT NULL REFERENCES store(id),
  CONSTRAINT ck_exemption_scope_xor CHECK ((region_id IS NULL) <> (store_id IS NULL)),
  CONSTRAINT uq_exemption_code_scope UNIQUE (code, region_id, store_id)
);

CREATE INDEX idx_exemption_region ON exemption(region_id);
CREATE INDEX idx_exemption_store  ON exemption(store_id);
