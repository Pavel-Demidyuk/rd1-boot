#!/usr/bin/env bash
FILE='/tmp/rd1-status-docker.json'
COMMAND="sudo docker container ls -a --format '{{.Names}}***{{.Status}}'"
truncate -s 0 $FILE
DATA=$($COMMAND)
echo $DATA >> $FILE
