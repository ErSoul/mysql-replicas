#!/bin/sh

mysql -u root -e "CHANGE REPLICATION SOURCE TO
					SOURCE_USER='${MYSQL_REPLICA_USER}',
					SOURCE_PASSWORD='${MYSQL_REPLICA_USER_PASSWORD}'
					FOR CHANNEL 'group_replication_recovery'"

mysql -u root -e "START GROUP_REPLICATION"

sed -i /etc/my.cnf -e 's/group_replication_start_on_boot=off/group_replication_start_on_boot=on/'
rm -- "$0" # self-destroy as it should not be needed anymore