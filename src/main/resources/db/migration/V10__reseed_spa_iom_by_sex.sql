-- V10__reseed_spa_iom_by_sex.sql
-- Reseed Isle of Man State Pension Age (SPA) schedule for BOTH sexes at STORE scope "IoM".
-- Assumptions:
--   - Exemption code '2004' is the IoM SPA exemption in your dataset
--   - Store table contains a row with name = 'IoM'
--   - pension_spa_by_dob has columns:
--       (store_id, region_id, sex, dob_from, dob_to, spa_age_years, spa_age_months, spa_fixed_date)

-- 0) Delete any existing IoM schedule rows (regardless of sex)
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
DELETE FROM pension_spa_by_dob p USING iom
WHERE p.store_id = iom.store_id;

-- 1) Ensure SPA rule exists for IoM (store-scoped)
INSERT INTO eligibility_rule (exemption_code, store_id, kind, valid_from, priority, enabled)
SELECT '2004', s.id, 'SPA_DOB', DATE '1900-01-01', 0, true
FROM store s
WHERE s.name='IoM'
  AND NOT EXISTS (
    SELECT 1 FROM eligibility_rule er
    WHERE er.exemption_code='2004' AND er.store_id=s.id AND er.kind='SPA_DOB'
  );

-----------------------------------------------------------------------
-- MEN (sex = 'M')
-----------------------------------------------------------------------

-- Before 6 Dec 1953 → 65th birthday
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT iom.store_id, 'M', DATE '1900-01-01', DATE '1953-12-05', 65, 0 FROM iom;

-- Fixed SPA dates (6 Dec 1953 – 5 Oct 1954)
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_fixed_date)
SELECT iom.store_id,'M', DATE '1953-12-06', DATE '1954-01-05', DATE '2019-03-06' FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1954-01-06', DATE '1954-02-05', DATE '2019-05-06' FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1954-02-06', DATE '1954-03-05', DATE '2019-07-06' FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1954-03-06', DATE '1954-04-05', DATE '2019-09-06' FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1954-04-06', DATE '1954-05-05', DATE '2019-11-06' FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1954-05-06', DATE '1954-06-05', DATE '2020-01-06' FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1954-06-06', DATE '1954-07-05', DATE '2020-03-06' FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1954-07-06', DATE '1954-08-05', DATE '2020-05-06' FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1954-08-06', DATE '1954-09-05', DATE '2020-07-06' FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1954-09-06', DATE '1954-10-05', DATE '2020-09-06' FROM iom;

-- 6 Oct 1954 – 5 Apr 1960 → 66th birthday
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT iom.store_id,'M', DATE '1954-10-06', DATE '1960-04-05', 66, 0 FROM iom;

-- 6 Apr 1960 – 5 Mar 1961 → 66 years + 1..11 months (monthly)
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT iom.store_id,'M', DATE '1960-04-06', DATE '1960-05-05', 66, 1 FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1960-05-06', DATE '1960-06-05', 66, 2 FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1960-06-06', DATE '1960-07-05', 66, 3 FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1960-07-06', DATE '1960-08-05', 66, 4 FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1960-08-06', DATE '1960-09-05', 66, 5 FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1960-09-06', DATE '1960-10-05', 66, 6 FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1960-10-06', DATE '1960-11-05', 66, 7 FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1960-11-06', DATE '1960-12-05', 66, 8 FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1960-12-06', DATE '1961-01-05', 66, 9 FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1961-01-06', DATE '1961-02-05', 66,10 FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1961-02-06', DATE '1961-03-05', 66,11 FROM iom;

-- 6 Mar 1961 – 5 Apr 1977 → 67th birthday
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT iom.store_id,'M', DATE '1961-03-06', DATE '1977-04-05', 67, 0 FROM iom;

-- 6 Apr 1977 – 5 Mar 1978 → fixed SPA dates (monthly)
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_fixed_date)
SELECT iom.store_id,'M', DATE '1977-04-06', DATE '1977-05-05', DATE '2044-05-06' FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1977-05-06', DATE '1977-06-05', DATE '2044-07-06' FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1977-06-06', DATE '1977-07-05', DATE '2044-09-06' FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1977-07-06', DATE '1977-08-05', DATE '2044-11-06' FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1977-08-06', DATE '1977-09-05', DATE '2045-01-06' FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1977-09-06', DATE '1977-10-05', DATE '2045-03-06' FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1977-10-06', DATE '1977-11-05', DATE '2045-05-06' FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1977-11-06', DATE '1977-12-05', DATE '2045-07-06' FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1977-12-06', DATE '1978-01-05', DATE '2045-09-06' FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1978-01-06', DATE '1978-02-05', DATE '2045-11-06' FROM iom UNION ALL
SELECT iom.store_id,'M', DATE '1978-02-06', DATE '1978-03-05', DATE '2046-01-06' FROM iom;

-- Special band and thereafter
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_fixed_date)
SELECT iom.store_id,'M', DATE '1978-03-06', DATE '1978-04-05', DATE '2046-03-06' FROM iom;

WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT iom.store_id,'M', DATE '1978-04-06', NULL, 68, 0 FROM iom;

-----------------------------------------------------------------------
-- WOMEN (sex = 'F')
-----------------------------------------------------------------------

-- Fixed SPA dates (6 Sep 1953 – 5 Oct 1954)
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_fixed_date)
SELECT iom.store_id,'F', DATE '1953-09-06', DATE '1953-10-05', DATE '2018-03-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1953-10-06', DATE '1953-11-05', DATE '2018-07-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1953-11-06', DATE '1953-12-05', DATE '2018-11-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1953-12-06', DATE '1954-01-05', DATE '2019-03-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1954-01-06', DATE '1954-02-05', DATE '2019-05-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1954-02-06', DATE '1954-03-05', DATE '2019-07-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1954-03-06', DATE '1954-04-05', DATE '2019-09-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1954-04-06', DATE '1954-05-05', DATE '2019-11-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1954-05-06', DATE '1954-06-05', DATE '2020-01-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1954-06-06', DATE '1954-07-05', DATE '2020-03-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1954-07-06', DATE '1954-08-05', DATE '2020-05-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1954-08-06', DATE '1954-09-05', DATE '2020-07-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1954-09-06', DATE '1954-10-05', DATE '2020-09-06' FROM iom;

-- 6 Oct 1954 – 5 Apr 1960 → 66th birthday
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT iom.store_id,'F', DATE '1954-10-06', DATE '1960-04-05', 66, 0 FROM iom;

-- 6 Apr 1960 – 5 Mar 1961 → 66 years + 1..11 months (monthly)
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT iom.store_id,'F', DATE '1960-04-06', DATE '1960-05-05', 66, 1 FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1960-05-06', DATE '1960-06-05', 66, 2 FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1960-06-06', DATE '1960-07-05', 66, 3 FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1960-07-06', DATE '1960-08-05', 66, 4 FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1960-08-06', DATE '1960-09-05', 66, 5 FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1960-09-06', DATE '1960-10-05', 66, 6 FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1960-10-06', DATE '1960-11-05', 66, 7 FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1960-11-06', DATE '1960-12-05', 66, 8 FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1960-12-06', DATE '1961-01-05', 66, 9 FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1961-01-06', DATE '1961-02-05', 66,10 FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1961-02-06', DATE '1961-03-05', 66,11 FROM iom;

-- 6 Mar 1961 – 5 Apr 1977 → 67th birthday
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT iom.store_id,'F', DATE '1961-03-06', DATE '1977-04-05', 67, 0 FROM iom;

-- 6 Apr 1977 – 5 Mar 1978 → fixed SPA dates (monthly)
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_fixed_date)
SELECT iom.store_id,'F', DATE '1977-04-06', DATE '1977-05-05', DATE '2044-05-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1977-05-06', DATE '1977-06-05', DATE '2044-07-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1977-06-06', DATE '1977-07-05', DATE '2044-09-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1977-07-06', DATE '1977-08-05', DATE '2044-11-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1977-08-06', DATE '1977-09-05', DATE '2045-01-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1977-09-06', DATE '1977-10-05', DATE '2045-03-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1977-10-06', DATE '1977-11-05', DATE '2045-05-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1977-11-06', DATE '1977-12-05', DATE '2045-07-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1977-12-06', DATE '1978-01-05', DATE '2045-09-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1978-01-06', DATE '1978-02-05', DATE '2045-11-06' FROM iom UNION ALL
SELECT iom.store_id,'F', DATE '1978-02-06', DATE '1978-03-05', DATE '2046-01-06' FROM iom;

-- Special band and thereafter
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_fixed_date)
SELECT iom.store_id,'F', DATE '1978-03-06', DATE '1978-04-05', DATE '2046-03-06' FROM iom;

WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT iom.store_id,'F', DATE '1978-04-06', NULL, 68, 0 FROM iom;
