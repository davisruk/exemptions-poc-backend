-- Wales
INSERT INTO store (name, region_id)
SELECT 'Cardiff', r.id
FROM region r
WHERE r.name = 'Wales'
  AND NOT EXISTS (SELECT 1 FROM store s WHERE s.name = 'Cardiff');

INSERT INTO store (name, region_id)
SELECT 'Swansea', r.id
FROM region r
WHERE r.name = 'Wales'
  AND NOT EXISTS (SELECT 1 FROM store s WHERE s.name = 'Swansea');

-- England
INSERT INTO store (name, region_id)
SELECT 'Nottingham', r.id
FROM region r
WHERE r.name = 'England'
  AND NOT EXISTS (SELECT 1 FROM store s WHERE s.name = 'Nottingham');

INSERT INTO store (name, region_id)
SELECT 'Leicester', r.id
FROM region r
WHERE r.name = 'England'
  AND NOT EXISTS (SELECT 1 FROM store s WHERE s.name = 'Leicester');

-- Scotland
INSERT INTO store (name, region_id)
SELECT 'Edinburgh', r.id
FROM region r
WHERE r.name = 'Scotland'
  AND NOT EXISTS (SELECT 1 FROM store s WHERE s.name = 'Edinburgh');

INSERT INTO store (name, region_id)
SELECT 'Glasgow', r.id
FROM region r
WHERE r.name = 'Scotland'
  AND NOT EXISTS (SELECT 1 FROM store s WHERE s.name = 'Glasgow');

-- Northern Ireland
INSERT INTO store (name, region_id)
SELECT 'Belfast', r.id
FROM region r
WHERE r.name = 'Northern Ireland'
  AND NOT EXISTS (SELECT 1 FROM store s WHERE s.name = 'Belfast');

INSERT INTO store (name, region_id)
SELECT 'Armagh', r.id
FROM region r
WHERE r.name = 'Northern Ireland'
  AND NOT EXISTS (SELECT 1 FROM store s WHERE s.name = 'Armagh');

-- Ensure IoM exists and remains in England region
INSERT INTO store (name, region_id)
SELECT 'IoM', r.id
FROM region r
WHERE r.name = 'England'
  AND NOT EXISTS (SELECT 1 FROM store s WHERE s.name = 'IoM');
