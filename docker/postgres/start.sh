#!/bin/sh

echo "kernel.shmmax = 301989888" >> /etc/sysctl.conf

if [ ! -d "/opt/db/nuxeodb" ]; then
echo "yoyo"
    # PostgreSQL setup
    LC_ALL=en_US.UTF-8 su postgres --preserve-environment -c "/usr/lib/postgresql/9.3/bin/initdb -D /opt/db/nuxeodb"

    pgconf="/opt/db/nuxeodb/postgresql.conf"

    perl -p -i -e "s/^#?shared_buffers\s*=.*$/shared_buffers = 100MB/" $pgconf
    perl -p -i -e "s/^#?max_prepared_transactions\s*=.*$/max_prepared_transactions = 32/" $pgconf
    perl -p -i -e "s/^#?effective_cache_size\s*=.*$/effective_cache_size = 1GB/" $pgconf
    perl -p -i -e "s/^#?work_mem\s*=.*$/work_mem = 32MB/" $pgconf
    perl -p -i -e "s/^#?wal_buffers\s*=.*$/wal_buffers = 8MB/" $pgconf
    perl -p -i -e "s/^#?lc_messages\s*=.*$/lc_messages = 'en_US.UTF-8'/" $pgconf
    perl -p -i -e "s/^#?lc_time\s*=.*$/lc_time = 'en_US.UTF-8'/" $pgconf
    perl -p -i -e "s/^#?log_line_prefix\s*=.*$/log_line_prefix = '%t [%p]: [%l-1] '/" $pgconf
    perl -p -i -e "s/^#?listen_addresses\s*=.*$/listen_addresses = '*'/" $pgconf

    cp /root/pg_hba.conf /opt/db/nuxeodb/pg_hba.conf
fi

# Start expecting cmd
chown postgres:postgres /opt/db/nuxeodb/
su postgres -c "/usr/lib/postgresql/9.3/bin/postgres -D /opt/db/nuxeodb"
