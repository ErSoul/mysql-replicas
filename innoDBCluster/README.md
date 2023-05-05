# InnoDBCluster

This should be the way to go when speaking about mysql's replicas.

## Usage

You should start the containers with the _start.sh_ script in the directory. The script accepts an optional argument that indicates the number of replica instances that will be deployed. The minimum and default value is 2, as the minimum number of instances needed to deploy an innoDB cluster are 3 nodes (including the primary node).

`./start [NUM_INSTANCES]`

You should stop the cluster with:

`./stop`

## Description

After all the containers are restarted, you should check who'll be the primary node (yes, it will change while more instances are added). Enter a container's shell and run:

`mysqlsh --no-password -- cluster status`

The one with the _memberRole:"PRIMARY"_ and _mode:"R/W"_ properties is the primary node.

Once identified the master node, you can add some schemas to that instance, and the other nodes will sync automatically.

# Notes

In this example I had to modify the original entrypoint script, to start the temporary server without a unix-socket. This way *group_replication* should set a valid TCP port. Also because the scripts inside the *docker-entrypoint.d* directory needs to be executed as a privileged user (default _mysql_ user can't access the */var/run/docker.socket* file)