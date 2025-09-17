-- 1) England SPA exemption code (PoC)
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10050', 'Z - State Pension Age (PoC)', r.id, NULL
FROM region r WHERE r.name='England'
  AND NOT EXISTS (SELECT 1 FROM exemption e JOIN region x ON x.id=e.region_id
                  WHERE e.code='10050' AND x.name='England');

-- 2) Rules: bind codes to SPA_DOB evaluator
INSERT INTO eligibility_rule (exemption_code, region_id, kind, valid_from, priority, enabled)
SELECT '10050', r.id, 'SPA_DOB', DATE '1900-01-01', 0, true
FROM region r WHERE r.name='England'
  AND NOT EXISTS (SELECT 1 FROM eligibility_rule er WHERE er.exemption_code='10050' AND er.region_id=r.id);

INSERT INTO eligibility_rule (exemption_code, store_id, kind, valid_from, priority, enabled)
SELECT '2004', s.id, 'SPA_DOB', DATE '1900-01-01', 0, true
FROM store s WHERE s.name='IoM'
  AND NOT EXISTS (SELECT 1 FROM eligibility_rule er WHERE er.exemption_code='2004' AND er.store_id=s.id);

-- 3) England SPA by DOB (sex-equalised; use 'ANY')
-- Table 4: 66 -> 67 monthly ramp (ages given in table)
WITH eng AS (SELECT id AS region_id FROM region WHERE name='England')
INSERT INTO pension_spa_by_dob(region_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT eng.region_id,'ANY', DATE '1960-04-06', DATE '1960-05-05', 66, 1 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1960-05-06', DATE '1960-06-05', 66, 2 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1960-06-06', DATE '1960-07-05', 66, 3 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1960-07-06', DATE '1960-08-05', 66, 4 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1960-08-06', DATE '1960-09-05', 66, 5 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1960-09-06', DATE '1960-10-05', 66, 6 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1960-10-06', DATE '1960-11-05', 66, 7 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1960-11-06', DATE '1960-12-05', 66, 8 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1960-12-06', DATE '1961-01-05', 66, 9 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1961-01-06', DATE '1961-02-05', 66,10 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1961-02-06', DATE '1961-03-05', 66,11 FROM eng;

-- Remaining Table 4 band to 67 on birthday
INSERT INTO pension_spa_by_dob(region_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT r.id,'ANY', DATE '1961-03-06', DATE '1977-04-05', 67, 0
FROM region r WHERE r.name='England';

-- Table 5: 67 -> 68 monthly ramp (mostly ages; one fixed-date band; then 68 on birthday)
WITH eng AS (SELECT id AS region_id FROM region WHERE name='England')
INSERT INTO pension_spa_by_dob(region_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT eng.region_id,'ANY', DATE '1977-04-06', DATE '1977-05-05', 67, 1 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1977-05-06', DATE '1977-06-05', 67, 2 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1977-06-06', DATE '1977-07-05', 67, 3 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1977-07-06', DATE '1977-08-05', 67, 4 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1977-08-06', DATE '1977-09-05', 67, 5 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1977-09-06', DATE '1977-10-05', 67, 6 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1977-10-06', DATE '1977-11-05', 67, 7 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1977-11-06', DATE '1977-12-05', 67, 8 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1977-12-06', DATE '1978-01-05', 67, 9 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1978-01-06', DATE '1978-02-05', 67,10 FROM eng UNION ALL
SELECT eng.region_id,'ANY', DATE '1978-02-06', DATE '1978-03-05', 67,11 FROM eng;

-- The one band where the timetable specifies a single SPA DATE for the whole DOB range:
INSERT INTO pension_spa_by_dob(region_id, sex, dob_from, dob_to, spa_fixed_date)
SELECT r.id,'ANY', DATE '1978-03-06', DATE '1978-04-05', DATE '2046-03-06'
FROM region r WHERE r.name='England';

-- 68 on birthday thereafter
INSERT INTO pension_spa_by_dob(region_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT r.id,'ANY', DATE '1978-04-06', NULL, 68, 0
FROM region r WHERE r.name='England';

-- 4) IoM: mirror England for PoC (replace later with true IoM timetable if needed)
WITH iim AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob(store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT iim.store_id,'ANY', DATE '1960-04-06', DATE '1960-05-05', 66, 1 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1960-05-06', DATE '1960-06-05', 66, 2 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1960-06-06', DATE '1960-07-05', 66, 3 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1960-07-06', DATE '1960-08-05', 66, 4 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1960-08-06', DATE '1960-09-05', 66, 5 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1960-09-06', DATE '1960-10-05', 66, 6 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1960-10-06', DATE '1960-11-05', 66, 7 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1960-11-06', DATE '1960-12-05', 66, 8 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1960-12-06', DATE '1961-01-05', 66, 9 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1961-01-06', DATE '1961-02-05', 66,10 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1961-02-06', DATE '1961-03-05', 66,11 FROM iim;

INSERT INTO pension_spa_by_dob(store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT s.id,'ANY', DATE '1961-03-06', DATE '1977-04-05', 67, 0 FROM store s WHERE s.name='IoM';

WITH iim AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob(store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT iim.store_id,'ANY', DATE '1977-04-06', DATE '1977-05-05', 67, 1 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1977-05-06', DATE '1977-06-05', 67, 2 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1977-06-06', DATE '1977-07-05', 67, 3 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1977-07-06', DATE '1977-08-05', 67, 4 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1977-08-06', DATE '1977-09-05', 67, 5 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1977-09-06', DATE '1977-10-05', 67, 6 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1977-10-06', DATE '1977-11-05', 67, 7 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1977-11-06', DATE '1977-12-05', 67, 8 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1977-12-06', DATE '1978-01-05', 67, 9 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1978-01-06', DATE '1978-02-05', 67,10 FROM iim UNION ALL
SELECT iim.store_id,'ANY', DATE '1978-02-06', DATE '1978-03-05', 67,11 FROM iim;

INSERT INTO pension_spa_by_dob(store_id, sex, dob_from, dob_to, spa_fixed_date)
SELECT s.id,'ANY', DATE '1978-03-06', DATE '1978-04-05', DATE '2046-03-06' FROM store s WHERE s.name='IoM';

INSERT INTO pension_spa_by_dob(store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT s.id,'ANY', DATE '1978-04-06', NULL, 68, 0 FROM store s WHERE s.name='IoM';
