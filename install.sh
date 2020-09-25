#!/usr/bin/env bash

echo -e "\e[42m\n\n\n ---- Update RPI ---- \e[0m"
sudo apt-get update --yes && sudo apt-get upgrade  --yes || exit 1

echo -e "\e[42m\n\n\n ---- Install display driver ---- \e[0m"
cd LCD-show
./LCD35-show
cd ..

echo -e "\e[42m\n\n\n ---- Autostart setup ---- \e[0m"
# this will start static index.html page on pre boot
mkdir -p /home/pi/.config/lxsession/LXDE-pi/
cp /home/pi/rd1-boot/install-data/autostart /home/pi/.config/lxsession/LXDE-pi/

echo -e "\e[42m\n\n\n ---- Install DOCKER ---- \n\e[0m"
sudo apt-get --fix-broken install --yes
docker -v || (curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh)

echo -e "\e[42m\n\n\n ---- Install Chromium ---- \n\e[0m"
# install chromium
dpkg -s chromium-browser || sudo apt-get install chromium-browser --yes

echo -e "\e[42m\n\n\n ---- Install NPM ---- \n\e[0m"
# install npm
npm -v || (sudo apt-get install npm --yes)

echo -e "\e[42m\n\n\n ---- Install RD1-DASHBOARD ---- \n\e[0m"
# install rd1-dashboard
cd /home/pi/
wget --no-check-certificate https://github.com/Pavel-Demidyuk/rd1-dashboard/archive/master.zip  && mv master.zip dashboard.zip
unzip dashboard.zip
rm -rf dashboard.zip
mv rd1-dashboard-master rd1-dashboard
cd /home/pi/rd1-dashboard && sudo npm install -g npm@latest && npm install
cd /home/pi/rd1-boot

#echo -e "\e[42m\n\n\n ---- Install FBI ---- \n\e[0m"
##install fbi
#dpkg -s fbi || sudo apt-get install -y fbi

echo -e "\e[42m\n\n\n ---- Install Unclutter ---- \n\e[0m"
#install unclutter
dpkg -s unclutter || sudo apt-get install -y unclutter

echo -e "\e[42m\n\n\n ---- Pull DOCKER ---- \n\e[0m"
# pull rd1-app
sudo docker pull eu.gcr.io/rd1-build/rd1-app:arm || exit 1 &
# pull rd1-dashboard
#sudo docker pull eu.gcr.io/rd1-build/rd1-dashboard:arm || exit 1  &
# pull rd1-owserver
sudo docker pull eu.gcr.io/rd1-build/rd1-owserver:arm || exit 1 &
# pull mqtt
#sudo docker pull eu.gcr.io/rd1-build/eclipse-mosquitto:arm || exit 1 &
sudo docker pull eclipse-mosquitto:latest || exit 1 &
# pull nodered
sudo docker pull nodered/node-red:latest || exit 1 &
wait

echo -e "\e[42m\n\n\n ---- Install HASSIO ---- \n\e[0m"
##setup hassio
bash install_hassio.sh || exit 1

echo -e "\e[42m\n\n\n ---- Creating user data  ---- \e[0m"
mkdir -p /home/pi/rd1-data/nodered/
cp -r /home/pi/rd1-boot/install-data/nodered/data /home/pi/rd1-data/nodered/
cp -r /home/pi/rd1-boot/install-data/homebridge /home/pi/rd1-data/homebridge
sudo -u homeassistant mkdir -p /home/homeassistant/.homeassistant
sudo -u homeassistant cp -r /home/pi/rd1-boot/install-data/.homeassistant /home/homeassistant/

echo -e "\e[42m\n\n\n ---- Register rd1 service ---- \n\e[0m"
# register rd1 service
sudo cp /home/pi/rd1-boot/install-data/rd1.service /etc/systemd/system/
sudo systemctl --system daemon-reload
sudo systemctl enable rd1

echo -e "\e[42m\n\n\n ---- REBOOT!! ---- \n\e[0m"
sleep 3
sudo reboot
