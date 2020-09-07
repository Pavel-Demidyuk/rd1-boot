#!/usr/bin/env bash
name='mqtt'
image='eclipse-mosquitto:latest'
#image='eu.gcr.io/rd1-build/eclipse-mosquitto:arm'
sudo docker stop $name && echo $name 'service stopped'
sudo docker rm $name && echo $name 'service removed'
sudo docker run -d --name=$name \
	--network=host \
	--restart=always \
	--health-cmd='exit 0' \
	--health-timeout=10s \
	--health-retries=1 \
	--health-interval=10m \
	$image && echo $name 'service started'
