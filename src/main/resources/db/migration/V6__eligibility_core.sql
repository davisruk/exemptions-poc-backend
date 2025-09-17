-- Rules that gate exemptions (store OR region scope; precedence: store > region)
CREATE TABLE eligibility_rule (
  id            BIGSERIAL PRIMARY KEY,
  exemption_code   VARCHAR(50) NOT NULL,
  region_id     BIGINT NULL REFERENCES region(id),
  store_id      BIGINT NULL REFERENCES store(id),
  kind          VARCHAR(40) NOT NULL,          -- e.g. 'SPA_DOB'
  expression    TEXT NULL,                      -- reserved for future generic rules
  valid_from    DATE NULL,
  valid_to      DATE NULL,
  priority      INT NOT NULL DEFAULT 0,
  enabled       BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT ck_elig_rule_scope_xor CHECK ((region_id IS NULL) <> (store_id IS NULL))
);

CREATE INDEX ix_elig_rule_lookup
  ON eligibility_rule (exemption_code, store_id, region_id, enabled, priority);

-- DOB-window schedule that yields either an age offset OR a fixed SPA calendar date.
CREATE TABLE pension_spa_by_dob (
  id              BIGSERIAL PRIMARY KEY,
  region_id       BIGINT NULL REFERENCES region(id),
  store_id        BIGINT NULL REFERENCES store(id),
  sex             VARCHAR(8) NOT NULL DEFAULT 'ANY',   -- 'M','F','ANY'
  dob_from        DATE NOT NULL,
  dob_to          DATE NULL,                            -- NULL = open-ended
  spa_age_years   INT NULL,
  spa_age_months  INT NULL,
  spa_fixed_date  DATE NULL,                            -- when the timetable specifies an exact SPA date for a DOB band
  CONSTRAINT ck_spa_scope_xor CHECK ((region_id IS NULL) <> (store_id IS NULL)),
  CONSTRAINT ck_spa_age_or_date CHECK (
    (spa_fixed_date IS NOT NULL AND spa_age_years IS NULL AND spa_age_months IS NULL) OR
    (spa_fixed_date IS NULL AND spa_age_years IS NOT NULL AND spa_age_months IS NOT NULL)
  ),
  CONSTRAINT ck_spa_dob_range CHECK (dob_from <= COALESCE(dob_to, dob_from))
);

CREATE INDEX ix_spa_lookup
  ON pension_spa_by_dob (store_id, region_id, sex, dob_from, dob_to);
