#!/bin/sh

mysql -u root -e "SET GLOBAL host_cache_size=0"

echo "Connecting to master..."
while ! mysql -h master-node -u root -e "SELECT 1" >/dev/null
do
	sleep 5s
	echo "Retrying connection to master..."
done


BINLOG_FILE=`mysql -h master-node -u root -e "SHOW MASTER STATUS\G" | awk '$1 == "File:" {print $2}'`
BINLOG_POSITION=`mysql -h master-node -u root -e "SHOW MASTER STATUS\G" | awk '$1 == "Position:" {print $2}'`

mysql -uroot -e "CHANGE REPLICATION SOURCE TO \
			SOURCE_HOST='master-node',
			SOURCE_USER='${REPLICA_USER}',
			SOURCE_PASSWORD='${REPLICA_USER_PASSWORD}',
			SOURCE_LOG_FILE='${BINLOG_FILE}',
			SOURCE_LOG_POS=${BINLOG_POSITION},
			SOURCE_SSL=1,
			SOURCE_SSL_CA='/certs/ca.pem',
			SOURCE_SSL_CERT='/certs/client-cert.pem',
			SOURCE_SSL_KEY='/certs/client-key.pem'"
			
mysql -uroot -e "START REPLICA"