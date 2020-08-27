#!/usr/bin/env bash
name='mqtt'
image='eu.gcr.io/rd1-build/eclipse-mosquitto:latest'
sudo docker stop $image && echo $name 'service stopped'
sudo docker rm $image && echo $name 'service removed'
sudo docker run -d --name=$name \
	--network=host \
	--restart=always \
	--health-cmd='exit 0' \
	--health-timeout=10s \
	--health-retries=1 \
	--health-interval=10m \
	$image && echo $name 'service started'
