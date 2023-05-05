#!/bin/sh

DOCKERINFO=`curl -s --unix-socket /run/docker.sock http://docker/containers/$HOSTNAME/json`

CONT_NAME=`python3 -c "import sys, json; print(json.loads(sys.argv[1])[\"Name\"].split(\"_\")[-1])" "$DOCKERINFO"`
