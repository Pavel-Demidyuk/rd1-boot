#!/usr/bin/env bash
name=rd1-dashboard
image=eu.gcr.io/rd1-build/$name:arm
sudo docker stop $name && echo $name 'service stopped'
sudo docker kill $name && echo $name 'service killed'
sudo docker rm $name && echo $name 'service removed'
sudo docker run -d --name=$name \
	--restart=on-failure \
	--priveleged \
	-v /proc/sysrq-trigger:/sysrq \
    --health-cmd='rm -rf index.html && wget --spider -q http://localhost:3000 && exit 0 || exit 1' \
	--health-timeout=10s \
	--health-retries=3 \
	--health-interval=2m \
	$image && echo $name 'service started'
