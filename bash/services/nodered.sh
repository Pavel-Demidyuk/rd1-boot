#!/usr/bin/env bash
name='node-red'
sudo docker stop $name && echo $name 'service stopped'
sudo docker rm $name && echo $name 'service removed'
sudo docker run -d \
    --name=$name \
	--network=host \
	--restart=always \
	-v  /root/rd1/boot/nodered/data:/data \
	nodered/node-red:latest && echo $name 'service started'
