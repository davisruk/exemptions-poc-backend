-- V11__exemption_rule_kind.sql
ALTER TABLE exemption ADD COLUMN IF NOT EXISTS eligibility_kind varchar(32);

-- Tag your SPA exemptions (extend this list as needed)
UPDATE exemption SET eligibility_kind = 'SPA_DOB'
WHERE code IN ('10050', '2004');  -- 10050 = England SPA (your PoC), 2004 = IoM SPA
