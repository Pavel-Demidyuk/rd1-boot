#!/usr/bin/env bash
# step 1: login to dietpi and setup internet connection
# step 2: bash -c "$(wget --no-check-certificate https://cutt.ly/rd1-start && cat rd1-start)"

#TODO enable i2c

sudo apt-get update --yes && sudo apt-get upgrade  --yes || exit 1
docker -v || curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh

# install chromium
chromium-browser --version || sudo apt-get install chromium-browser --yes

#install fbi
fbi --version || sudo apt-get install -y fbi

# pull rd1-app
docker pull eu.gcr.io/rd1-build/rd1-app:arm || exit 1  &
# pull rd1-dashboard
docker pull eu.gcr.io/rd1-build/rd1-dashboard:arm || exit 1  &
# pull rd1-owserver
docker pull eu.gcr.io/rd1-build/rd1-owserver:arm || exit 1 &
# pull mqtt
docker pull eclipse-mosquitto:latest || exit 1 &
# pull nodered
docker pull nodered/node-red:latest || exit 1 &
wait

##setup hassio
bash install_hassio.sh || exit 1

# register rd1 service
cp /home/pi/rd1-boot/services/rd1.service /etc/systemd/system/
sudo systemctl --system daemon-reload
sudo systemctl enable rd1

# install display driver
chmod -R 755 /home/pi/rd1-boot/Lroot/rd1-bootCD-show || exit 1
cd /home/pi/rd1-boot/LCD-show/ && ./LCD35-show || exit 1

reboot
