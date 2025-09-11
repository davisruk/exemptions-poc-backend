-- Regions
INSERT INTO region(name) VALUES ('England'), ('Wales'), ('Scotland'), ('Northern Ireland');

-- Stores
INSERT INTO store(name, region_id)
SELECT 'ENG-001', r.id FROM region r WHERE r.name = 'England';
INSERT INTO store(name, region_id)
SELECT 'ENG-EX-001', r.id FROM region r WHERE r.name = 'England';  -- special store
INSERT INTO store(name, region_id)
SELECT 'WAL-001', r.id FROM region r WHERE r.name = 'Wales';

-- Region-scoped exemptions (examples)
-- England defaults
INSERT INTO exemption(code, name, region_id, store_id)
SELECT 'E1','England Exemption 1', r.id, NULL FROM region r WHERE r.name = 'England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT 'E2','England Exemption 2', r.id, NULL FROM region r WHERE r.name = 'England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT 'E3','England Exemption 3', r.id, NULL FROM region r WHERE r.name = 'England';

-- Wales defaults
INSERT INTO exemption(code, name, region_id, store_id)
SELECT 'W1','Wales Exemption 1', r.id, NULL FROM region r WHERE r.name = 'Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT 'W2','Wales Exemption 2', r.id, NULL FROM region r WHERE r.name = 'Wales';

-- Store-scoped (REPLACE behaviour for ENG-EX-001)
-- We only insert store rows for the special store, so the JPQL will use these instead of region rows
INSERT INTO exemption(code, name, region_id, store_id)
SELECT 'S1','Special Store Exemption 1', NULL, s.id FROM store s WHERE s.name = 'ENG-EX-001';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT 'S2','Special Store Exemption 2', NULL, s.id FROM store s WHERE s.name = 'ENG-EX-001';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT 'S3','Special Store Exemption 3', NULL, s.id FROM store s WHERE s.name = 'ENG-EX-001';
