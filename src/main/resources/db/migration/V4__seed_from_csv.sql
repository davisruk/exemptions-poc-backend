-- DEV/POC seed reset (idempotent enough for local use)
-- Order matters due to FKs
DELETE FROM exemption;
DELETE FROM store;
DELETE FROM region;

-- Regions
INSERT INTO region(name) VALUES
  ('England'),
  ('Scotland'),
  ('Wales'),
  ('Northern Ireland');

-- Single store: IoM (assign to England as its base region)
INSERT INTO store(name, region_id)
SELECT 'IoM', r.id FROM region r WHERE r.name = 'England';

-- =========================
-- England (region-scoped)
-- =========================
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '1','A - is 60 years of age or over or is under 16 years of age', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '2','B - is 16, 17 or 18 and in full-time education', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '3','A - is 60 years of age or over or is under 16 years of age.', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '4','D - has a valid maternity exemption certificate', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '5','E - has a valid medical exemption certificate', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '6','F - has a valid pre-payment certificate', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '7','G - Prescription Exemption Certificate issued by the Ministry of Defence', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '8','H - gets Income Support or Income Related Employment and Support Allowance', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '9','K - gets Income-based Jobseeker''s Allowance (JSA (IB))', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10','L - is named on a current HC2 charges certificate', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '12','S - Pension Credit Guarantee Credit (including partners)', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '15','Levy', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '35','Northern Ireland Exemption', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10015','U - Universal Credit and meets the criteria', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '13','X - was prescribed free-of-charge contraceptives', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10016','Y - free supply of sexual health treatment', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '14','To Be Confirmed', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10017','W - HRT only Prescription prepayment certificate', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '36','To Be Confirmed', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '16','Prescribed free-of-charge HMP/prisoners/persons detained in other secure accommodation medication', r.id, NULL FROM region r WHERE r.name='England';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '11','M - is entitled to, or named on, a valid NHS Tax Credit Exemption Certificate', r.id, NULL FROM region r WHERE r.name='England';

-- =========================
-- Northern Ireland (region-scoped)
-- =========================
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '33','Exempt as Northern Irish Patient', r.id, NULL FROM region r WHERE r.name='Northern Ireland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '37','N/A', r.id, NULL FROM region r WHERE r.name='Northern Ireland';

-- =========================
-- Scotland (region-scoped)
-- =========================
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10001','B - Is 16, 17 or 18 and in full-time education', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10003','D - Has a valid maternity or medical exemption certificate (EC92)', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10004','E - Has a valid prescription pre-payment certificate', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10005','F - Has a valid War Pension exemption certificate', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10006','G - Gets, or has a partner who gets, Income Support', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10007','H - Has a partner who gets ''Pension Credit guarantee credit'' (PCGC)', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10008','I - Gets, or has a partner who gets, income based Jobseeker''s Allowance', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10009','J - Is entitled to, or named on, a valid NHS Tax Credit Exemption Certificate', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10010','K - Is named on a current HC2 charges certificate', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10011','L - Was prescribed free-of-charge contraceptives', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10012','M - Gets, or has a partner who gets, income related Employment and Support Allowance', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10013','N - [Mark specific items as ''no charge'' ] Was prescribed free of charge medication to treat tuberculosis (or Pandemic Flu - mark as PF)', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10014','W - Not Exempt', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10000','A – is under 16 years of age', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10002','C – is 60 years of age or over', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '24','H - Has a partner who gets ''Pension Credit guarantee credit'' (PCGC)', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '25','I - Gets, or has a partner who gets, income based Jobseeker''s Allowance', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '30','N - [Mark specific items as ''no charge'' ] Was prescribed free of charge medication to treat tuberculosis (or Pandemic Flu - mark as PF)', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '28','L - Was prescribed free-of-charge contraceptives', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '31','W - Not Exempt', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '17','A - Is under 16 years of age', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '18','B - Is 16, 17 or 18 and in full-time education', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '19','C - Is 60 years of age or over', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '20','D - Has a valid maternity or medical exemption certificate (EC92)', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '21','E - Has a valid prescription pre-payment certificate', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '22','F - Has a valid War Pension exemption certificate', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '23','G - Gets, or has a partner who gets, Income Support', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '26','J - Is entitled to, or named on, a valid NHS Tax Credit Exemption Certificate', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '27','K - Is named on a current HC2 charges certificate', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '29','M - Gets, or has a partner who gets, income related Employment and Support Allowance', r.id, NULL FROM region r WHERE r.name='Scotland';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '34','Exempt as Scottish Prescriber', r.id, NULL FROM region r WHERE r.name='Scotland';

-- =========================
-- Wales (region-scoped)
-- =========================
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10033','M - is entitled to, or named on, a valid NHS Tax Credit Exemption Certificate', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10020','To Be Confirmed', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10021','Welsh Prescription Welsh Dispenser - No Charge', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10022','Welsh Entitlement Card', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10023','A - is 60 years of age or over or is under 16 years of age', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10024','B - is 16, 17 or 18 and in full-time education', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10025','A - is 60 years of age or over or is under 16 years of age.', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10026','D - has a valid maternity exemption certificate', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10027','E - has a valid medical exemption certificate', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10028','F - has a valid pre-payment certificate', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10029','G - Prescription Exemption Certificate issued by the Ministry of Defence', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10030','H - gets Income Support or Income Related Employment and Support Allowance', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10031','K - gets Income-based Jobseeker''s Allowance (JSA (IB))', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10032','L - is named on a current HC2 charges certificate', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10034','S - Pension Credit Guarantee Credit (including partners)', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10035','U - Universal Credit and meets the criteria', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10036','W - HRT only Prescription prepayment certificate', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10037','X - was prescribed free-of-charge contraceptives', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10038','Y - free supply of sexual health treatment', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10039','Prescribed free-of-charge HMP/prisoners/persons detained in other secure accommodation medication', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '10040','Levy', r.id, NULL FROM region r WHERE r.name='Wales';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '32','Exempt as Welsh Prescriber', r.id, NULL FROM region r WHERE r.name='Wales';

-- =========================
-- IoM (store-scoped, REPLACE behaviour)
-- =========================
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '2000','Patient has paid appropriate charges at old rate (Isle of Man only)', NULL, s.id FROM store s WHERE s.name='IoM';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '2001','Patient has paid appropriate charges (Isle of Man only)', NULL, s.id FROM store s WHERE s.name='IoM';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '2002','Is under 16 years (Isle of Man only)', NULL, s.id FROM store s WHERE s.name='IoM';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '2003','Is a full-time student under 19 years (Isle of Man only)', NULL, s.id FROM store s WHERE s.name='IoM';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '2004','is of state-retirement age (Isle of Man only)', NULL, s.id FROM store s WHERE s.name='IoM';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '2005','Is a person in receipt of Income Support (or their dependent) (Isle of Man only)', NULL, s.id FROM store s WHERE s.name='IoM';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '2006','In receipt of incapacity benefit for a period in excess of 6 months (Isle of Man only)', NULL, s.id FROM store s WHERE s.name='IoM';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '2007','In receipt of Employed Persons Allowance (Isle of Man only)', NULL, s.id FROM store s WHERE s.name='IoM';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '2008','In receipt of Income Based Job Seeker''s Allowance (Isle of Man only)', NULL, s.id FROM store s WHERE s.name='IoM';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '2009','Is in possession of a pre-payment certificate (Isle of Man only)', NULL, s.id FROM store s WHERE s.name='IoM';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '2010','Is in possession of a medical exemption certificate (Isle of Man only)', NULL, s.id FROM store s WHERE s.name='IoM';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '2011','Is a War Service disablement pensioner (Isle of Man only)', NULL, s.id FROM store s WHERE s.name='IoM';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '2012','Is a registered blind person (Isle of Man only)', NULL, s.id FROM store s WHERE s.name='IoM';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '2013','Is pregnant (Isle of Man only)', NULL, s.id FROM store s WHERE s.name='IoM';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '2014','Has given birth within the last 12 months (Isle of Man only)', NULL, s.id FROM store s WHERE s.name='IoM';
INSERT INTO exemption(code, name, region_id, store_id)
SELECT '2015','Was prescribed a free of charge contraception only (Isle of Man only)', NULL, s.id FROM store s WHERE s.name='IoM';
