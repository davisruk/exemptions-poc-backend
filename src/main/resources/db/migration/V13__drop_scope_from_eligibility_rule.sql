-- Drop any FKs / CHECKs that reference region_id or store_id (names may vary).
-- This block finds and drops ONLY constraints that touch those columns.
DO $$
DECLARE
  c RECORD;
BEGIN
  FOR c IN
    SELECT conname
    FROM   pg_constraint pc
    JOIN   pg_class      tbl  ON tbl.oid = pc.conrelid
    JOIN   pg_namespace  nsp  ON nsp.oid = tbl.relnamespace
    WHERE  nsp.nspname = current_schema()
      AND  tbl.relname = 'eligibility_rule'
      AND  pc.contype IN ('f','c','u','p')  -- FK, CHECK, UNIQUE, PK (rarely on those cols, but safe)
      AND (
        -- any constraint whose definition mentions region_id or store_id
        pg_get_constraintdef(pc.oid) ILIKE '%region_id%'
        OR pg_get_constraintdef(pc.oid) ILIKE '%store_id%'
      )
  LOOP
    EXECUTE format('ALTER TABLE eligibility_rule DROP CONSTRAINT %I', c.conname);
  END LOOP;
END $$;

-- Now drop the columns
ALTER TABLE eligibility_rule
  DROP COLUMN IF EXISTS region_id,
  DROP COLUMN IF EXISTS store_id;

-- Optional: if you keep using eligibility_rule for other kinds,
-- tighten identity to avoid duplicates going forward.
-- Use a unique INDEX (safer than constraint when legacy duplicates might exist).
CREATE UNIQUE INDEX IF NOT EXISTS uq_elig_rule_code_kind
  ON eligibility_rule (exemption_code, kind);
