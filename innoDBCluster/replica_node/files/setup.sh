#!/bin/sh

while ! curl -s --unix-socket /var/run/docker.sock http://docker/containers/$HOSTNAME/json > /dev/null 2>&1
do
	sleep 1s
	echo "Trying to get docker container information..."
done

DOCKERINFO=$(curl -s --unix-socket /var/run/docker.sock http://docker/containers/$HOSTNAME/json)
CONTAINER_NAME=$(python3 -c "import sys, json; print(json.loads(sys.argv[1])[\"Name\"])" "$DOCKERINFO" | sed 's|/||')
ID=`echo ${CONTAINER_NAME} | cut -d '-' -f 4`


sed -i /etc/my.cnf -e "/\[mysqld\]/a \
server_id=${ID}\n\
disabled_storage_engines='MyISAM,BLACKHOLE,FEDERATED,ARCHIVE,MEMORY'\n\
gtid_mode=ON\n\
enforce_gtid_consistency=ON\n\
binlog_transaction_dependency_tracking=writeset\n"


#mysqlsh root@localhost --no-password -- dba configure-local-instance --interactive=false