#!/usr/bin/env bash
# step 1: login to dietpi and setup internet connection
# step 2: bash -c "$(wget --no-check-certificate https://cutt.ly/rd1-start && cat rd1-start)"

#TODO enable i2c

echo -e "\e[42m\n\n\n ---- Update RPI ---- "
echo -e "\n \e[39m test"
sudo apt-get update --yes && sudo apt-get upgrade  --yes || exit 1

echo -e "\e[42m\n\n\n ---- Install DOCKER ---- \n\e[39m"
docker -v || (curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh)

echo -e "\e[42m\n\n\n ---- Install Chromium ---- \n\e[39m"
# install chromium
chromium-browser --version || sudo apt-get install chromium-browser --yes

echo -e "\e[42m\n\n\n ---- Install FBI ---- \n\e[39m"
#install fbi
fbi --version || sudo apt-get install -y fbi

echo -e "\e[42m\n\n\n ---- Pull DOCKER ---- \n\e[39m"
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

echo -e "\e[42m\n\n\n ---- Install HASSIO ---- \n\e[39m"
##setup hassio
bash install_hassio.sh || exit 1

echo -e "\e[42m\n\n\n ---- Register rd1 service ---- \n\e[39m"
# register rd1 service
cp /home/pi/rd1-boot/services/rd1.service /etc/systemd/system/
sudo systemctl --system daemon-reload
sudo systemctl enable rd1

echo -e "\e[42m\n\n\n ---- Install Display Drivers ---- \n\e[39m"
# install display driver
chmod -R 755 /home/pi/rd1-boot/Lroot/rd1-bootCD-show || exit 1
cd /home/pi/rd1-boot/LCD-show/ && ./LCD35-show || exit 1

echo -e "\e[42m\n\n\n ---- REBOOT!! ---- \n\e[39m"
sleep 3
reboot
