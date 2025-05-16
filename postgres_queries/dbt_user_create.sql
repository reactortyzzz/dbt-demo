-- 1) create the dbt role
CREATE ROLE dbt_user
  WITH LOGIN
       PASSWORD 'dbt_forever123'
       NOSUPERUSER
       NOCREATEDB
       NOCREATEROLE;

-- 2) switch to your target DB
\c defaultdb

-- 3) allow dbt_user to connect
GRANT CONNECT ON DATABASE defaultdb TO dbt_user;

-- 4) schema privileges
--   raw: read-only
GRANT USAGE ON SCHEMA dbt_demo TO dbt_user;
-- --   staging & analytics: read + write (create new models)
-- GRANT USAGE, CREATE ON SCHEMA staging TO dbt_user;
-- GRANT USAGE, CREATE ON SCHEMA analytics TO dbt_user;

-- 5) table privileges on existing objects
--   raw (sources)
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA dbt_demo TO dbt_user;
--   staging & analytics (models)
-- GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE
--   ON ALL TABLES IN SCHEMA staging TO dbt_user;
-- GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE
--   ON ALL TABLES IN SCHEMA analytics TO dbt_user;

-- 6) sequence privileges for serial/identity columns
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA dbt_demo TO dbt_user;
-- GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA analytics TO dbt_user;

-- 7) default privileges for any future objects created by other roles
ALTER DEFAULT PRIVILEGES IN SCHEMA dbt_demo
  GRANT SELECT ON TABLES TO dbt_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA dbt_demo
  GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON TABLES TO dbt_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA dbt_demo
  GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON TABLES TO dbt_user;

ALTER DEFAULT PRIVILEGES IN SCHEMA dbt_demo
  GRANT USAGE, SELECT ON SEQUENCES TO dbt_user;

