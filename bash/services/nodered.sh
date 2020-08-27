#!/usr/bin/env bash
name='node-red'
image='eu.gcr.io/rd1-build/node-red:latest'
sudo docker stop $image && echo $name 'service stopped'
sudo docker rm $image && echo $name 'service removed'
sudo docker run -d \
    --name=$name \
	--network=host \
	--restart=always \
	-v  /root/rd1/boot/nodered/data:/data \
	$image && echo $name 'service started'
