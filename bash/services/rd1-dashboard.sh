#!/usr/bin/env bash
name=rd1-dashboard
image=eu.gcr.io/rd1-build/$name:arm
docker stop $name && echo $name 'service stopped'
docker kill $name && echo $name 'service killed'
docker rm $name && echo $name 'service removed'
docker run -d --name=$name \
	-p 3000:3000 \
	--restart=on-failure \
    --health-cmd='rm -rf index.html && wget --spider -q http://localhost:3000 && exit 0 || exit 1' \
	--health-timeout=10s \
	--health-retries=3 \
	--health-interval=2m \
	$image && echo $name 'service started'
