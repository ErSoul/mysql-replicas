#!/bin/sh

sed -i /etc/my.cnf -e '/\[mysqld\]/r /etc/my.cnf.d/01-replication.conf'
cp /etc/my.cnf.d/private_key.pem /var/lib/mysql