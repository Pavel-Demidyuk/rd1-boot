#!/usr/bin/env bash
name='node-red'
docker stop $name && echo $name 'service stopped'
docker rm $name && echo $name 'service removed'
docker run -d \
    --name=$name \
	--network=host \
	--restart=always \
	-v  /root/rd1/boot/nodered/data:/data \
	nodered/node-red:latest && echo $name 'service started'
