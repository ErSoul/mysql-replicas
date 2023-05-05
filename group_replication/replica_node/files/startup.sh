#!/bin/sh

echo "Waiting for primary-node to become online..."
while ! mysql -h primary-node -uroot -e "SELECT 1" > /dev/null 2>&1
do
	sleep 5s
	echo "Retrying connection to primary-node..."
done
echo "Primary-node online!"

sed -i /etc/my.cnf -e '/\[mysqld\]/r /etc/my.cnf.d/01-replication.conf'