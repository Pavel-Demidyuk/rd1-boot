#!/usr/bin/env bash
name='rd1-app'
docker stop $name && echo $name 'service stopped'
docker kill $name && echo $name 'service killed'
docker rm $name && echo $name 'service removed'
docker system prune -f
echo $name 'service stopped'
