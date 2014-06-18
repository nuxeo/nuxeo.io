#/bin/sh -

# Delete holded backend activity
echo "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '${PG_DB_NAME}';" | psql -h ${DB_PORT_1337_TCP_ADDR} -p ${DB_PORT_1337_TCP_PORT} -U postgres

# Change table owner to delete if
echo "ALTER DATABASE ${PG_DB_NAME} OWNER TO postgres;" | psql -h ${DB_PORT_1337_TCP_ADDR} -p ${DB_PORT_1337_TCP_PORT} -U postgres
echo "DROP DATABASE ${PG_DB_NAME};" | psql -h ${DB_PORT_1337_TCP_ADDR} -p ${DB_PORT_1337_TCP_PORT} -U postgres

# Drop role
echo "DROP ROLE ${PG_ROLE_NAME};" | psql -h ${DB_PORT_1337_TCP_ADDR} -p ${DB_PORT_1337_TCP_PORT} -U postgres
