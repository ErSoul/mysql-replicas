# MYSQL REPLICAS

## DESCRIPTION

This repository contains the three ways that MYSQL allows to setup a group of replica's arquitecture.

- Simple Replication
- Group Replication
- InnoDB Cluster

### Simple Replication

As you may guess this is the more straight forward way to go. In this mode you can have only one instance as a replica, and the other as the source node.

The disadvantage of this mode is that you'll have to enter each replica instance that you want to setup, copy the required files (certs, keys, etc), and it's not fault-tolerant (if any of the instances crashes, you'll have to set it up manually, after detecting at what point the instance crashed).

### Group  Replication (WIP)

This is how a real replication arquitecture should work. In fact, the *InnoDB Cluster* uses this under-the-hood.

The problem is that is somehow complicated to get things done, and it is not fault-tolerant (refer to *Simple Replication*).

### InnoDB Cluster

When talking about replication, this should be the defacto way to go.

It's fault tolerant, and very simple to setup all of the instances through the primary node. The only "drawback" (in comparison with the *Simple Replica* mode) is that you need to have at least 3 servers up.

For production environment, use this.