# CLASSIC MYSQL REPLICA

## DESCRIPTION

This is the simplest replication topology available for MySQL. Must keep in mind the following:

- All MySQL server instances must have a unique SERVER_ID.
- There can only be one source, but there can be n-replicas.
- If changes to the data are committed in any of the replicas, it wont be replicated to all other instances.

In this lab we'll have one source instance, and n-replicas of MySQL. You can run any number of replicas with the following command:

`docker compose --scale 2 slave`

To test that replication is working correctly, you must enter to a master's TTY shell, and execute the script `/db_scripts/db-populate.sh`. Then, you can check that the database on the replicas has been populated too.

## NOTES

The certificates used by the client should belong to the same Certificate Authority (CA). All servers generate their server and client certificates when deployed. You could use the `client-cert.pem` and `client-key.pem` on the source's `/var/lib/mysql`directory, and move them to all the replica instances.

To avoid warnings the following decisions were made:

- The `--relay-log` variable must be set at startup. For convenience, the name should be the same for all instances.
- Remove the flag `--skip-host-cache` from the configuration file (`/etc/my.cnf`), and set it at runtime with `SET GLOBAL host_cache_size=0`