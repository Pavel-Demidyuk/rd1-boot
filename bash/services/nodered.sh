#!/usr/bin/env bash
name='node-red'
image='eu.gcr.io/rd1-build/node-red:latest'
sudo docker stop $name && echo $name 'service stopped'
sudo docker rm $name && echo $name 'service removed'
sudo docker run -d \
    --name=$name \
	--network=host \
	--restart=always \
	--privileged=true \
	-v  /root/rd1/boot/nodered/data:/data \
	$image && echo $name 'service started'
