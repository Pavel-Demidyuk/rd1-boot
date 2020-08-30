#!/usr/bin/env bash
FILE='/tmp/rd1-status-local-ip'
COMMAND="hostname -I"
truncate -s 0 $FILE
DATA=$($COMMAND)
echo $DATA >> $FILE
