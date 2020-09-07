#!/usr/bin/env bash
name='node-red'
image='nodered/node-red'
sudo docker stop $name && echo $name 'service stopped'
sudo docker rm $name && echo $name 'service removed'
sudo docker run -d \
    --name=$name \
	--network=host \
	--restart=always \
	--privileged=true \
	-v  /home/pi/rd1-data/nodered/data:/data \
	$image && echo $name 'service started'
