#!/usr/bin/env bash
name='mqtt'
sudo docker stop $name && echo $name 'service stopped'
sudo docker rm $name && echo $name 'service removed'
sudo docker run -d --name=$name \
	--network=host \
	--restart=always \
	--health-cmd='exit 0' \
	--health-timeout=10s \
	--health-retries=1 \
	--health-interval=10m \
	eclipse-mosquitto:latest && echo $name 'service started'
