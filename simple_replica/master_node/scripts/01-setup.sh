#!/bin/sh

mysql -uroot -e "SET GLOBAL host_cache_size=0"

mysql -uroot -e "CREATE USER '${REPLICA_USER}'@'%' IDENTIFIED BY '${REPLICA_USER_PASSWORD}' REQUIRE SSL"
mysql -uroot -e "GRANT REPLICATION SLAVE ON *.* TO '${REPLICA_USER}'@'%'"

## OPTIONAL: uncomment when database is running on-the-fly.

# mysql -e "FLUSH TABLES WITH READ LOCK"
# mysqldump > dbdump.db#!/bin/sh