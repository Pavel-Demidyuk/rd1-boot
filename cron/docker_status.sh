#!/usr/bin/env bash
FILE='/tmp/rd1-status-docker.json'
truncate -s 0 $FILE
DATA=$(sudo docker container ls -a --format '{{.Names}}***{{.Status}}')
echo $DATA >> $FILE
