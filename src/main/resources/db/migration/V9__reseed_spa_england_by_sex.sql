-- Reseed England SPA schedule (by sex), including legacy women's equalisation bands.
-- Source: GOV.UK "State Pension age timetables", Tables 1–5.

-- 0) Wipe prior England rows
WITH eng AS (SELECT id AS region_id FROM region WHERE name = 'England')
DELETE FROM pension_spa_by_dob p USING eng
WHERE p.region_id = eng.region_id;

-- 1) Ensure an England SPA exemption exists for the PoC (code = 10050)
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10050', 'State Pension Age (England)', r.id, NULL
FROM region r
WHERE r.name = 'England'
  AND NOT EXISTS (SELECT 1 FROM exemption e WHERE e.code='10050' AND e.region_id=r.id AND e.store_id IS NULL);

-- 2) Bind rule (region-scope) to SPA_DOB evaluator
INSERT INTO eligibility_rule (exemption_code, region_id, kind, valid_from, priority, enabled)
SELECT '10050', r.id, 'SPA_DOB', DATE '1900-01-01', 0, true
FROM region r
WHERE r.name = 'England'
  AND NOT EXISTS (
    SELECT 1 FROM eligibility_rule er
    WHERE er.exemption_code='10050' AND er.region_id=r.id AND er.kind='SPA_DOB'
  );

-- Helper: region id & both sexes
WITH eng AS (SELECT id AS region_id FROM region WHERE name = 'England')
SELECT 1; -- placeholder to terminate the CTE scope above cleanly

-- ====== Legacy women’s equalisation (Table 1) ======
WITH eng AS (SELECT id AS region_id FROM region WHERE name = 'England')
INSERT INTO pension_spa_by_dob(region_id, store_id, sex, dob_from, dob_to, spa_fixed_date)
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1950-04-06', DATE '1950-05-05', DATE '2010-05-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1950-05-06', DATE '1950-06-05', DATE '2010-07-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1950-06-06', DATE '1950-07-05', DATE '2010-09-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1950-07-06', DATE '1950-08-05', DATE '2010-11-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1950-08-06', DATE '1950-09-05', DATE '2011-01-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1950-09-06', DATE '1950-10-05', DATE '2011-03-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1950-10-06', DATE '1950-11-05', DATE '2011-05-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1950-11-06', DATE '1950-12-05', DATE '2011-07-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1950-12-06', DATE '1951-01-05', DATE '2011-09-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1951-01-06', DATE '1951-02-05', DATE '2011-11-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1951-02-06', DATE '1951-03-05', DATE '2012-01-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1951-03-06', DATE '1951-04-05', DATE '2012-03-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1951-04-06', DATE '1951-05-05', DATE '2012-05-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1951-05-06', DATE '1951-06-05', DATE '2012-07-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1951-06-06', DATE '1951-07-05', DATE '2012-09-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1951-07-06', DATE '1951-08-05', DATE '2012-11-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1951-08-06', DATE '1951-09-05', DATE '2013-01-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1951-09-06', DATE '1951-10-05', DATE '2013-03-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1951-10-06', DATE '1951-11-05', DATE '2013-05-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1951-11-06', DATE '1951-12-05', DATE '2013-07-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1951-12-06', DATE '1952-01-05', DATE '2013-09-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1952-01-06', DATE '1952-02-05', DATE '2013-11-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1952-02-06', DATE '1952-03-05', DATE '2014-01-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1952-03-06', DATE '1952-04-05', DATE '2014-03-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1952-04-06', DATE '1952-05-05', DATE '2014-05-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1952-05-06', DATE '1952-06-05', DATE '2014-07-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1952-06-06', DATE '1952-07-05', DATE '2014-09-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1952-07-06', DATE '1952-08-05', DATE '2014-11-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1952-08-06', DATE '1952-09-05', DATE '2015-01-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1952-09-06', DATE '1952-10-05', DATE '2015-03-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1952-10-06', DATE '1952-11-05', DATE '2015-05-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1952-11-06', DATE '1952-12-05', DATE '2015-07-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1952-12-06', DATE '1953-01-05', DATE '2015-09-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1953-01-06', DATE '1953-02-05', DATE '2015-11-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1953-02-06', DATE '1953-03-05', DATE '2016-01-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1953-03-06', DATE '1953-04-05', DATE '2016-03-06' FROM eng;

-- ====== Women’s acceleration (Table 2) ======
WITH eng AS (SELECT id AS region_id FROM region WHERE name = 'England')
INSERT INTO pension_spa_by_dob(region_id, store_id, sex, dob_from, dob_to, spa_fixed_date)
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1953-04-06', DATE '1953-05-05', DATE '2016-07-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1953-05-06', DATE '1953-06-05', DATE '2016-11-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1953-06-06', DATE '1953-07-05', DATE '2017-03-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1953-07-06', DATE '1953-08-05', DATE '2017-07-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1953-08-06', DATE '1953-09-05', DATE '2017-11-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1953-09-06', DATE '1953-10-05', DATE '2018-03-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1953-10-06', DATE '1953-11-05', DATE '2018-07-06' FROM eng UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), 'F', DATE '1953-11-06', DATE '1953-12-05', DATE '2018-11-06' FROM eng;

-- ====== 65 → 66 (Table 3), both sexes ======
WITH eng AS (SELECT id AS region_id FROM region WHERE name = 'England'),
     sexes(sex) AS (VALUES ('M'), ('F'))
INSERT INTO pension_spa_by_dob(region_id, store_id, sex, dob_from, dob_to, spa_fixed_date)
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1953-12-06', DATE '1954-01-05', DATE '2019-03-06' FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1954-01-06', DATE '1954-02-05', DATE '2019-05-06' FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1954-02-06', DATE '1954-03-05', DATE '2019-07-06' FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1954-03-06', DATE '1954-04-05', DATE '2019-09-06' FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1954-04-06', DATE '1954-05-05', DATE '2019-11-06' FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1954-05-06', DATE '1954-06-05', DATE '2020-01-06' FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1954-06-06', DATE '1954-07-05', DATE '2020-03-06' FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1954-07-06', DATE '1954-08-05', DATE '2020-05-06' FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1954-08-06', DATE '1954-09-05', DATE '2020-07-06' FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1954-09-06', DATE '1954-10-05', DATE '2020-09-06' FROM eng CROSS JOIN sexes s;

WITH eng AS (SELECT id AS region_id FROM region WHERE name = 'England'),
     sexes(sex) AS (VALUES ('M'), ('F'))
INSERT INTO pension_spa_by_dob(region_id, store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1954-10-06', DATE '1960-04-05', 66, 0
FROM eng CROSS JOIN sexes s;

-- ====== 66 → 67 (Table 4), both sexes ======
WITH eng AS (SELECT id AS region_id FROM region WHERE name = 'England'),
     sexes(sex) AS (VALUES ('M'), ('F'))
INSERT INTO pension_spa_by_dob(region_id, store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1960-04-06', DATE '1960-05-05', 66, 1 FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1960-05-06', DATE '1960-06-05', 66, 2 FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1960-06-06', DATE '1960-07-05', 66, 3 FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1960-07-06', DATE '1960-08-05', 66, 4 FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1960-08-06', DATE '1960-09-05', 66, 5 FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1960-09-06', DATE '1960-10-05', 66, 6 FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1960-10-06', DATE '1960-11-05', 66, 7 FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1960-11-06', DATE '1960-12-05', 66, 8 FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1960-12-06', DATE '1961-01-05', 66, 9 FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1961-01-06', DATE '1961-02-05', 66,10 FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1961-02-06', DATE '1961-03-05', 66,11 FROM eng CROSS JOIN sexes s;

WITH eng AS (SELECT id AS region_id FROM region WHERE name = 'England'),
     sexes(sex) AS (VALUES ('M'), ('F'))
INSERT INTO pension_spa_by_dob(region_id, store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1961-03-06', DATE '1977-04-05', 67, 0
FROM eng CROSS JOIN sexes s;

-- ====== 67 → 68 (Table 5), both sexes ======
WITH eng AS (SELECT id AS region_id FROM region WHERE name = 'England'),
     sexes(sex) AS (VALUES ('M'), ('F'))
INSERT INTO pension_spa_by_dob(region_id, store_id, sex, dob_from, dob_to, spa_fixed_date)
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1977-04-06', DATE '1977-05-05', DATE '2044-05-06' FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1977-05-06', DATE '1977-06-05', DATE '2044-07-06' FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1977-06-06', DATE '1977-07-05', DATE '2044-09-06' FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1977-07-06', DATE '1977-08-05', DATE '2044-11-06' FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1977-08-06', DATE '1977-09-05', DATE '2045-01-06' FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1977-09-06', DATE '1977-10-05', DATE '2045-03-06' FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1977-10-06', DATE '1977-11-05', DATE '2045-05-06' FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1977-11-06', DATE '1977-12-05', DATE '2045-07-06' FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1977-12-06', DATE '1978-01-05', DATE '2045-09-06' FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1978-01-06', DATE '1978-02-05', DATE '2045-11-06' FROM eng CROSS JOIN sexes s UNION ALL
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1978-02-06', DATE '1978-03-05', DATE '2046-01-06' FROM eng CROSS JOIN sexes s;

WITH eng AS (SELECT id AS region_id FROM region WHERE name = 'England'),
     sexes(sex) AS (VALUES ('M'), ('F'))
INSERT INTO pension_spa_by_dob(region_id, store_id, sex, dob_from, dob_to, spa_fixed_date)
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1978-03-06', DATE '1978-04-05', DATE '2046-03-06'
FROM eng CROSS JOIN sexes s;

WITH eng AS (SELECT id AS region_id FROM region WHERE name = 'England'),
     sexes(sex) AS (VALUES ('M'), ('F'))
INSERT INTO pension_spa_by_dob(region_id, store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT eng.region_id, CAST(NULL AS bigint), s.sex, DATE '1978-04-06', NULL, 68, 0
FROM eng CROSS JOIN sexes s;
