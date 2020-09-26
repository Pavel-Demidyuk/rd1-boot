#!/usr/bin/env bash
sudo docker pull eu.gcr.io/rd1-build/rd1-app:arm
sudo docker pull eu.gcr.io/rd1-build/rd1-owserver:arm
/home/pi/rd1-boot/bash/services/rd1-owserver.sh
/home/pi/rd1-boot/bash/services/rd1-app.sh
echo "done updating docker images"
