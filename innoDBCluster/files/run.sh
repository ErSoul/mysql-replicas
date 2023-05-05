#!/bin/sh

mysqlsh --no-password -- dba configure-local-instance --interactive=false
mysqlsh --no-password -- dba create-cluster my-net --interactive=false

mysqlsh --no-password -- cluster setup-admin-account supercow --password'chicken' --interactive=false
mysqlsh --no-password -- cluster add-instance instance-node