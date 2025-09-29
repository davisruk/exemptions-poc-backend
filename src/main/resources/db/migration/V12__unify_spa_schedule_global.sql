-- V12: Unify SPA schedule globally and relax scope constraint so global rows are allowed.

-- 0) Relax the schedule's scope constraint: from XOR to "≤ 1 set"
ALTER TABLE pension_spa_by_dob
  DROP CONSTRAINT IF EXISTS ck_spa_scope_xor;

ALTER TABLE pension_spa_by_dob
  ADD CONSTRAINT ck_spa_scope_le1
  CHECK (
    (CASE WHEN region_id IS NOT NULL THEN 1 ELSE 0 END) +
    (CASE WHEN store_id  IS NOT NULL THEN 1 ELSE 0 END)
    <= 1
  );

-- 1) Tag SPA exemptions once (skip if already done)
ALTER TABLE exemption ADD COLUMN IF NOT EXISTS eligibility_kind varchar(32);
UPDATE exemption SET eligibility_kind = 'SPA_DOB'
WHERE code IN ('10050','2004');  -- extend if you have more SPA-coded exemptions

-- 2) Build a single GLOBAL SPA timetable (no region/store scoping)
-- 2a) Clear existing global rows (safe if none exist)
DELETE FROM pension_spa_by_dob
WHERE region_id IS NULL AND store_id IS NULL;

-- 2b) Copy timetable from England → GLOBAL (England timetable == UK timetable)
WITH eng AS (SELECT id FROM region WHERE name='England')
INSERT INTO pension_spa_by_dob
  (region_id, store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months, spa_fixed_date)
SELECT
  NULL, NULL, p.sex, p.dob_from, p.dob_to, p.spa_age_years, p.spa_age_months, p.spa_fixed_date
FROM pension_spa_by_dob p
JOIN eng ON p.region_id = eng.id;

-- 2c) Remove all scoped SPA rows now that the GLOBAL table exists
DELETE FROM pension_spa_by_dob
WHERE region_id IS NOT NULL OR store_id IS NOT NULL;

-- 2d) Helpful index for global lookups
CREATE INDEX IF NOT EXISTS ix_spa_global_sex_dob
  ON pension_spa_by_dob (sex, dob_from, dob_to);

-- 3) We no longer use eligibility_rule for SPA at all
DELETE FROM eligibility_rule WHERE kind = 'SPA_DOB';
