#!/usr/bin/env bash
name=rd1-app
image=eu.gcr.io/rd1-build/$name:arm
docker pull $image
sudo docker stop $name && echo $name 'service stopped'
sudo docker kill $name && echo $name 'service killed'
sudo docker rm $name && echo $name 'service removed'
sudo docker run -d --name=$name \
	--network=host \
	--restart=on-failure \
	-v /home/pi/rd1-data/homebridge/:/usr/src/app/configs/homebridge \
	-e "NODE_ENV=prod" \
    -e "APP_PORT=5051" \
    -e "DEBUG=boot,debug,app,db,warning,info,esp,homebridge,matcher" \
    -e "DEVICE_MODEL=0.1" \
    -e "HASSIO_TOKEN_SECRET_NAME=hassio" \
    -e "HOMEBRIDGE_CONFIG_UI_PORT=8080" \
    -e "OWSERVER_HOST=127.0.0.1" \
    -e "OWSERVER_PORT=4304" \
    -e "POLLING_DISABLED=false" \
    --health-cmd='rm -rf index.html && wget --spider -q http://localhost:5051/health && exit 0 || exit 1' \
	--health-timeout=10s \
	--health-retries=3 \
	--health-interval=2m \
	$image && echo $name 'service started'
