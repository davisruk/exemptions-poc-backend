-- Postgres: allow long display names from the CSV
ALTER TABLE exemption ALTER COLUMN name TYPE TEXT;
