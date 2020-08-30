#!/usr/bin/env bash
FILE='/tmp/rd1-status-date'
COMMAND="date"
truncate -s 0 $FILE
DATA=$($COMMAND)
echo $DATA >> $FILE
