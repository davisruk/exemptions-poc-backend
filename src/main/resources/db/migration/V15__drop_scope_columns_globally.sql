-- V15: Drop region_id / store_id from SPA-related tables (global SPA).
--------------------------------------------------------------------------------
-- 0) Safety check: refuse to proceed if any scoped SPA rows remain
--------------------------------------------------------------------------------
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM pension_spa_by_dob
    WHERE region_id IS NOT NULL OR store_id IS NOT NULL
  ) THEN
    RAISE EXCEPTION
      'Scoped rows remain in pension_spa_by_dob. Run the globalization migration first.';
  END IF;
END $$;

--------------------------------------------------------------------------------
-- 1) pension_spa_by_dob : drop constraints / indexes that reference scope cols
--------------------------------------------------------------------------------
DO $$
DECLARE c RECORD;
BEGIN
  FOR c IN
    SELECT conname
    FROM   pg_constraint pc
    JOIN   pg_class      t  ON t.oid = pc.conrelid
    JOIN   pg_namespace  ns ON ns.oid = t.relnamespace
    WHERE  ns.nspname = current_schema()
      AND  t.relname  = 'pension_spa_by_dob'
      AND  pc.contype IN ('f','c','u','p')
      AND (pg_get_constraintdef(pc.oid) ILIKE '%region_id%'
           OR pg_get_constraintdef(pc.oid) ILIKE '%store_id%')
  LOOP
    EXECUTE format('ALTER TABLE pension_spa_by_dob DROP CONSTRAINT %I', c.conname);
  END LOOP;
END $$;

DO $$
DECLARE idx RECORD;
BEGIN
  FOR idx IN
    SELECT schemaname, indexname
    FROM   pg_indexes
    WHERE  schemaname = current_schema()
      AND  tablename  = 'pension_spa_by_dob'
      AND (indexdef ILIKE '%region_id%' OR indexdef ILIKE '%store_id%')
  LOOP
    EXECUTE format('DROP INDEX IF EXISTS %I.%I', idx.schemaname, idx.indexname);
  END LOOP;
END $$;

-- Drop the columns (no-op if already gone)
ALTER TABLE pension_spa_by_dob
  DROP COLUMN IF EXISTS region_id,
  DROP COLUMN IF EXISTS store_id;

-- (Optional) Re-add band integrity checks only if they don’t exist already
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'ck_spa_dob_range'
      AND conrelid = 'pension_spa_by_dob'::regclass
  ) THEN
    ALTER TABLE pension_spa_by_dob
      ADD CONSTRAINT ck_spa_dob_range
      CHECK (dob_to IS NULL OR dob_to >= dob_from);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'ck_spa_band_kind'
      AND conrelid = 'pension_spa_by_dob'::regclass
  ) THEN
    ALTER TABLE pension_spa_by_dob
      ADD CONSTRAINT ck_spa_band_kind
      CHECK (
        (spa_fixed_date IS NOT NULL AND spa_age_years IS NULL AND spa_age_months IS NULL)
        OR
        (spa_fixed_date IS NULL AND (spa_age_years IS NOT NULL OR spa_age_months IS NOT NULL))
      );
  END IF;
END $$;

-- Helpful lookup index (idempotent)
CREATE INDEX IF NOT EXISTS ix_spa_global_sex_dob
  ON pension_spa_by_dob (sex, dob_from, dob_to);

--------------------------------------------------------------------------------
-- 2) eligibility_rule : drop scope constraints/indexes and columns
--    (we no longer use region/store for SPA; other rule kinds also won’t need scope now)
--------------------------------------------------------------------------------
DO $$
DECLARE c RECORD;
BEGIN
  FOR c IN
    SELECT conname
    FROM   pg_constraint pc
    JOIN   pg_class      t  ON t.oid = pc.conrelid
    JOIN   pg_namespace  ns ON ns.oid = t.relnamespace
    WHERE  ns.nspname = current_schema()
      AND  t.relname  = 'eligibility_rule'
      AND  pc.contype IN ('f','c','u','p')
      AND (pg_get_constraintdef(pc.oid) ILIKE '%region_id%'
           OR pg_get_constraintdef(pc.oid) ILIKE '%store_id%')
  LOOP
    EXECUTE format('ALTER TABLE eligibility_rule DROP CONSTRAINT %I', c.conname);
  END LOOP;
END $$;

DO $$
DECLARE idx RECORD;
BEGIN
  FOR idx IN
    SELECT schemaname, indexname
    FROM   pg_indexes
    WHERE  schemaname = current_schema()
      AND  tablename  = 'eligibility_rule'
      AND (indexdef ILIKE '%region_id%' OR indexdef ILIKE '%store_id%')
  LOOP
    EXECUTE format('DROP INDEX IF EXISTS %I.%I', idx.schemaname, idx.indexname);
  END LOOP;
END $$;

ALTER TABLE eligibility_rule
  DROP COLUMN IF EXISTS region_id,
  DROP COLUMN IF EXISTS store_id;

-- Optional: keep rules unique per (exemption_code, kind)
CREATE UNIQUE INDEX IF NOT EXISTS uq_elig_rule_code_kind
  ON eligibility_rule (exemption_code, kind);
