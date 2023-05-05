#!/bin/sh

set -e

main() {
	local NUM_INSTANCES=2
	
	[ -z $1 ] || NUM_INSTANCES=$1

	case $NUM_INSTANCES in
		# POSIX if empty or not a number
		# src: https://stackoverflow.com/a/3951175/8962524
		''|*[!0-9]*)
			echo "ERROR: NUM_INSTANCES should be a number." >&2
			exit 1
		;;
		*)
			[ $NUM_INSTANCES -lt 2 ] && echo "ERROR: NUM_INSTANCES should be >= 2" >&2 && exit 1
		;;
	esac

	docker compose up -d --scale instance-node=$NUM_INSTANCES

	REPLICA_CONTAINERS=`get_replica_containers`

	echo -e "Replica Instances:\n$REPLICA_CONTAINERS"

	for CONTAINER in $REPLICA_CONTAINERS
	do
		restart_container $CONTAINER &
	done

	# Wait for all containers to be successfuly restarted
	until [ -z "$(jobs -r)" ]; do true; done
}

get_replica_containers() {
	docker ps --filter "name=innodbcluster-instance" --format "{{.ID}}"
}

restart_container() {
	local ID=$1
	echo "Restarting container ${ID}..."
	until [ -n "$(docker ps --filter="id=$ID" --filter="status=exited" --format "{{.ID}}")" ]; do true; done
	docker start $ID
	echo "Container $ID restarted."
}

main "$@"