#!/usr/bin/env bash
FILE='/tmp/rd1-status-public-ip'
COMMAND="curl icanhazip.com"
truncate -s 0 $FILE
DATA=$($COMMAND)
echo $DATA >> $FILE
