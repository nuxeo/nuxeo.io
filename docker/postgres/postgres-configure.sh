#!/bin/sh
CONFIG_DONE=/opt/db/nuxeodb/postgres-configure-done

# Prevent postgres-configure from being executed twice
if [ -f CONFIG_DONE ]; then
    exit 0
fi

# PostgreSQL setup
su postgres -c "psql -p 5432 template1 --quiet -t -f-" << EOF > /dev/null

CREATE LANGUAGE plpgsql;
CREATE FUNCTION pg_catalog.text(integer) RETURNS text STRICT IMMUTABLE LANGUAGE SQL AS 'SELECT textin(int4out(\$1));';
CREATE CAST (integer AS text) WITH FUNCTION pg_catalog.text(integer) AS IMPLICIT;
COMMENT ON FUNCTION pg_catalog.text(integer) IS 'convert integer to text';
CREATE FUNCTION pg_catalog.text(bigint) RETURNS text STRICT IMMUTABLE LANGUAGE SQL AS 'SELECT textin(int8out(\$1));';
CREATE CAST (bigint AS text) WITH FUNCTION pg_catalog.text(bigint) AS IMPLICIT;
COMMENT ON FUNCTION pg_catalog.text(bigint) IS 'convert bigint to text';
EOF

# Prevent postgres-configure from being executed twice
touch CONFIG_DONE
