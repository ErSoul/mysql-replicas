#!/bin/sh

set -eu

mysqlsh --no-password -- dba configure-local-instance --interactive=false
mysqlsh --no-password -- dba create-cluster ${CLUSTER_NAME} --interactive=false
mysqlsh --no-password -- cluster setup-admin-account ${CLUSTER_ADMIN} --password=${CLUSTER_ADMIN_PASSWORD} --interactive=false

until curl --get \
	 --silent \
	 --data-urlencode 'filters={"name":{"innodbcluster-instance": true}, "status": {"running":true}}' \
	 --unix-socket /var/run/docker.sock http://docker/containers/json \
	 | grep Name > /dev/null 2>&1 # GREP is to make sure that at least an object has been returned
do
	sleep 1
done

# Print running replicas as an array
CONTAINERS=`curl --get \
	 --silent \
	 --data-urlencode 'filters={"name":{"innodbcluster-instance": true}, "status": {"running":true}}' \
	 --unix-socket /var/run/docker.sock http://docker/containers/json \
	 | python -c 'import sys, json
for cont in json.loads(sys.stdin.read().rstrip()):
  print(cont["Names"][0].split("/")[1])'`
  
for CONTAINER in $CONTAINERS
do
	until mysql -u root -h $CONTAINER -e exit
	do
		sleep 1
		echo "Connecting to ${CONTAINER}..." 1>&2
	done
	mysqlsh --no-password -- cluster add-instance ${CONTAINER} --label=${CONTAINER} --recoveryMethod=clone --interactive=false
	echo "Connected to ${CONTAINER}!"
done
