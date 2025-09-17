-- V8__seed_spa_iom_men.sql
-- Isle of Man: State Pension Age schedule (MEN) from official timetable.
-- Sources: "State pension age for men" (IoM) – DOB bands and SPA dates. 
-- (Includes fixed-date bands and birthday-on-age bands.) 

-- 1) Bind IoM SPA exemption (code 2004) to SPA_DOB rule at STORE scope
INSERT INTO eligibility_rule (exemption_code, store_id, kind, valid_from, priority, enabled)
SELECT '2004', s.id, 'SPA_DOB', DATE '1900-01-01', 0, true
FROM store s
WHERE s.name = 'IoM'
  AND NOT EXISTS (
    SELECT 1 FROM eligibility_rule er
    WHERE er.exemption_code = '2004' AND er.store_id = s.id AND er.kind = 'SPA_DOB'
  );

-- 2) DOB → SPA schedule for IoM (MEN). sex='M'. 
-- Note: where “N th birthday” is given, we encode as (spa_age_years, spa_age_months).
-- Where a single SPA calendar date is given for a DOB band, we use spa_fixed_date.

-- Before 6 Dec 1953 → 65th birthday
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT iom.store_id, 'M', DATE '1900-01-01', DATE '1953-12-05', 65, 0
FROM iom
WHERE NOT EXISTS (
  SELECT 1 FROM pension_spa_by_dob p 
  WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1900-01-01' AND p.dob_to=DATE '1953-12-05'
);

-- Fixed SPA dates for late 1953–1954 cohorts
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_fixed_date)
SELECT iom.store_id, 'M', DATE '1953-12-06', DATE '1954-01-05', DATE '2019-03-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1953-12-06' AND p.dob_to=DATE '1954-01-05') UNION ALL
SELECT iom.store_id, 'M', DATE '1954-01-06', DATE '1954-02-05', DATE '2019-05-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1954-01-06' AND p.dob_to=DATE '1954-02-05') UNION ALL
SELECT iom.store_id, 'M', DATE '1954-02-06', DATE '1954-03-05', DATE '2019-07-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1954-02-06' AND p.dob_to=DATE '1954-03-05') UNION ALL
SELECT iom.store_id, 'M', DATE '1954-03-06', DATE '1954-04-05', DATE '2019-09-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1954-03-06' AND p.dob_to=DATE '1954-04-05') UNION ALL
SELECT iom.store_id, 'M', DATE '1954-04-06', DATE '1954-05-05', DATE '2019-11-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1954-04-06' AND p.dob_to=DATE '1954-05-05') UNION ALL
SELECT iom.store_id, 'M', DATE '1954-05-06', DATE '1954-06-05', DATE '2020-01-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1954-05-06' AND p.dob_to=DATE '1954-06-05') UNION ALL
SELECT iom.store_id, 'M', DATE '1954-06-06', DATE '1954-07-05', DATE '2020-03-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1954-06-06' AND p.dob_to=DATE '1954-07-05') UNION ALL
SELECT iom.store_id, 'M', DATE '1954-07-06', DATE '1954-08-05', DATE '2020-05-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1954-07-06' AND p.dob_to=DATE '1954-08-05') UNION ALL
SELECT iom.store_id, 'M', DATE '1954-08-06', DATE '1954-09-05', DATE '2020-07-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1954-08-06' AND p.dob_to=DATE '1954-09-05') UNION ALL
SELECT iom.store_id, 'M', DATE '1954-09-06', DATE '1954-10-05', DATE '2020-09-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1954-09-06' AND p.dob_to=DATE '1954-10-05');

-- 66th birthday band (6 Oct 1954 – 5 Apr 1960)
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT iom.store_id, 'M', DATE '1954-10-06', DATE '1960-04-05', 66, 0
FROM iom
WHERE NOT EXISTS (
  SELECT 1 FROM pension_spa_by_dob p 
  WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1954-10-06' AND p.dob_to=DATE '1960-04-05'
);

-- 66 years + 1..11 months (6 Apr 1960 – 5 Mar 1961)
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT iom.store_id,'M', DATE '1960-04-06', DATE '1960-05-05', 66, 1 FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1960-04-06' AND p.dob_to=DATE '1960-05-05') UNION ALL
SELECT iom.store_id,'M', DATE '1960-05-06', DATE '1960-06-05', 66, 2 FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1960-05-06' AND p.dob_to=DATE '1960-06-05') UNION ALL
SELECT iom.store_id,'M', DATE '1960-06-06', DATE '1960-07-05', 66, 3 FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1960-06-06' AND p.dob_to=DATE '1960-07-05') UNION ALL
SELECT iom.store_id,'M', DATE '1960-07-06', DATE '1960-08-05', 66, 4 FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1960-07-06' AND p.dob_to=DATE '1960-08-05') UNION ALL
SELECT iom.store_id,'M', DATE '1960-08-06', DATE '1960-09-05', 66, 5 FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1960-08-06' AND p.dob_to=DATE '1960-09-05') UNION ALL
SELECT iom.store_id,'M', DATE '1960-09-06', DATE '1960-10-05', 66, 6 FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1960-09-06' AND p.dob_to=DATE '1960-10-05') UNION ALL
SELECT iom.store_id,'M', DATE '1960-10-06', DATE '1960-11-05', 66, 7 FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1960-10-06' AND p.dob_to=DATE '1960-11-05') UNION ALL
SELECT iom.store_id,'M', DATE '1960-11-06', DATE '1960-12-05', 66, 8 FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1960-11-06' AND p.dob_to=DATE '1960-12-05') UNION ALL
SELECT iom.store_id,'M', DATE '1960-12-06', DATE '1961-01-05', 66, 9 FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1960-12-06' AND p.dob_to=DATE '1961-01-05') UNION ALL
SELECT iom.store_id,'M', DATE '1961-01-06', DATE '1961-02-05', 66,10 FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1961-01-06' AND p.dob_to=DATE '1961-02-05') UNION ALL
SELECT iom.store_id,'M', DATE '1961-02-06', DATE '1961-03-05', 66,11 FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1961-02-06' AND p.dob_to=DATE '1961-03-05');

-- 67th birthday band (6 Mar 1961 – 5 Apr 1977)
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT iom.store_id, 'M', DATE '1961-03-06', DATE '1977-04-05', 67, 0
FROM iom
WHERE NOT EXISTS (
  SELECT 1 FROM pension_spa_by_dob p 
  WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1961-03-06' AND p.dob_to=DATE '1977-04-05'
);

-- Fixed SPA dates for 1977–1978 monthly cohorts
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_fixed_date)
SELECT iom.store_id,'M', DATE '1977-04-06', DATE '1977-05-05', DATE '2044-05-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1977-04-06' AND p.dob_to=DATE '1977-05-05') UNION ALL
SELECT iom.store_id,'M', DATE '1977-05-06', DATE '1977-06-05', DATE '2044-07-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1977-05-06' AND p.dob_to=DATE '1977-06-05') UNION ALL
SELECT iom.store_id,'M', DATE '1977-06-06', DATE '1977-07-05', DATE '2044-09-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1977-06-06' AND p.dob_to=DATE '1977-07-05') UNION ALL
SELECT iom.store_id,'M', DATE '1977-07-06', DATE '1977-08-05', DATE '2044-11-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1977-07-06' AND p.dob_to=DATE '1977-08-05') UNION ALL
SELECT iom.store_id,'M', DATE '1977-08-06', DATE '1977-09-05', DATE '2045-01-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1977-08-06' AND p.dob_to=DATE '1977-09-05') UNION ALL
SELECT iom.store_id,'M', DATE '1977-09-06', DATE '1977-10-05', DATE '2045-03-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1977-09-06' AND p.dob_to=DATE '1977-10-05') UNION ALL
SELECT iom.store_id,'M', DATE '1977-10-06', DATE '1977-11-05', DATE '2045-05-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1977-10-06' AND p.dob_to=DATE '1977-11-05') UNION ALL
SELECT iom.store_id,'M', DATE '1977-11-06', DATE '1977-12-05', DATE '2045-07-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1977-11-06' AND p.dob_to=DATE '1977-12-05') UNION ALL
SELECT iom.store_id,'M', DATE '1977-12-06', DATE '1978-01-05', DATE '2045-09-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1977-12-06' AND p.dob_to=DATE '1978-01-05') UNION ALL
SELECT iom.store_id,'M', DATE '1978-01-06', DATE '1978-02-05', DATE '2045-11-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1978-01-06' AND p.dob_to=DATE '1978-02-05') UNION ALL
SELECT iom.store_id,'M', DATE '1978-02-06', DATE '1978-03-05', DATE '2046-01-06' FROM iom WHERE NOT EXISTS (SELECT 1 FROM pension_spa_by_dob p WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1978-02-06' AND p.dob_to=DATE '1978-03-05');

-- Special fixed-date band and then 68th birthday thereafter
WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_fixed_date)
SELECT iom.store_id, 'M', DATE '1978-03-06', DATE '1978-04-05', DATE '2046-03-06'
FROM iom
WHERE NOT EXISTS (
  SELECT 1 FROM pension_spa_by_dob p 
  WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1978-03-06' AND p.dob_to=DATE '1978-04-05'
);

WITH iom AS (SELECT id AS store_id FROM store WHERE name='IoM')
INSERT INTO pension_spa_by_dob (store_id, sex, dob_from, dob_to, spa_age_years, spa_age_months)
SELECT iom.store_id, 'M', DATE '1978-04-06', NULL, 68, 0
FROM iom
WHERE NOT EXISTS (
  SELECT 1 FROM pension_spa_by_dob p 
  WHERE p.store_id=(SELECT store_id FROM iom) AND p.sex='M' AND p.dob_from=DATE '1978-04-06' AND p.dob_to IS NULL
);
