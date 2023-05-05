# GROUP REPLICATION MYSQL (WIP)

## DESCRIPTION

WIP - Can't authenticate the replica with the source through RSA encryption. No error dropped, but getting Permission Denied.

## NOTES

It is good practice to start the bootstrap member first, and let it create the group. Then make it the seed member for the rest of the members that are joining. This ensures that there is a group formed when joining the rest of the members.

Creating a group and joining multiple members at the same time is not supported. It might work, but chances are that the operations race and then the act of joining the group ends up in an error or a time out. [Source](https://dev.mysql.com/doc/refman/8.0/en/group-replication-configuring-instances.html)

Primary/Bootstrap server should set the variable `group_replication_bootstrap_group` to `on` on runtime (else, each time the server is restarted, it will create a new replication group). Also it don't need to set the `group_replication_group_seeds` variable.

Replicas should append current members of the group to `group_replication_group_seeds=node1:33061,node2:33061,etc:33061` and set `group_replication_bootstrap_group` to `off`

## DOCKER ENTRYPOINT

### THE PROBLEM

The official mysql image from docker hub have an entrypoint script named `/usr/local/bin/docker-entrypoint.sh`. This entrypoint execs `mysqld` **twice (restarts the daemon)** with the given arguments. At first, it will `--initialize-insecure` the daemon, and parse the given arguments to it. Some of the arguments needed for the **GROUP REPLICATION** plugin will conflict with this option, and the container will eventually fail.

Files in the `/docker-entrypoint-initdb.d` directory will be executed only on the first run of the daemon (as the `mysql` shell user), so setting configurations on runtime from SQL scripts won't work, as config will be lost on service reboot.

### SOLUTION

In order to mitigate this problem I had to create a `startup.sh` script that will be executed on the first run (after all the initialization of the database is done), which will append the required configuration to `/etc/my.cnf`. This way the **GROUP REPLICATION** configs will apply only for the second run.

Some tweaks were needed on build-time in order to accomplish this:

- Give write permissions to all users on the `/etc` directory (`sed` needs to create a temporary file in there)
- Change owner of `/etc/my.cnf` to `mysql`. (Remember that files in `/docker-entrypoint-initdb.d` will be executed with `mysql` user permissions)