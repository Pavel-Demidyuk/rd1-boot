#!/usr/bin/env bash
#docker run -d --network=host -e I2C=ALL:ALL -e HTTP_ENABLED=true -v /dev:/dev --privileged=true --restart=always paveldemidyuk/rd1-owserver:arm
name='owserver'
docker stop $name && echo $name 'service stopped'
docker rm $name && echo $name 'service removed'
#docker run -d --name=$name --network=host -e FAKE=DS2413,DS2413,DS2413,DS2406 -e HTTP_ENABLED=true -v /dev:/dev --privileged=true --restart=always paveldemidyuk/rd1-owserver:arm && echo 'service started'
# HEALTHCHECK --interval=30s --timeout=5s --retries=1 CMD wget -q http://localhost/ && exit 0 || exit 1
docker run -d --name=$name \
	-p 4304:4304 -p 80:2121 \
	-e I2C=ALL:ALL -e HTTP_ENABLED=true \
	-v /dev:/dev --privileged=true \
	--restart=on-failure \
	--health-cmd='rm -rf index.html && wget --spider -q http://localhost:2121 && exit 0 || exit 1' \
	--health-timeout=10s \
	--health-retries=3 \
	--health-interval=2m \
	paveldemidyuk/rd1-owserver:arm && echo $name 'service started'
docker system prune -f
