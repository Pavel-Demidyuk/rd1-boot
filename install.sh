#!/usr/bin/env bash
# step 1: login to dietpi and setup internet connection
# step 2: run this file

TODO enable i2c
investigate dietpi-backup

# install docker
/boot/dietpi/dietpi-software install 162 || exit 1
# install avahi
/boot/dietpi/dietpi-software install 152 || exit 1
# install chromium
/boot/dietpi/dietpi-software install 113 || exit 1
#install fbi
sudo apt-get install -y fbi

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

#setup hassio
sudo apt-get -y install python3 python3-dev python3-venv python3-pip libffi-dev libssl-dev autoconf build-essential
sudo useradd -rm homeassistant -G dialout,gpio,i2c
cd /srv
sudo mkdir homeassistant
sudo chown homeassistant:homeassistant homeassistant
su homeassistant <<'EOF'
cd /srv/homeassistant
python3 -m venv .
source bin/activate
python3 -m pip install wheel
pip3 install homeassistant
EOF

#enable hassio service
cp /root/rd1-boot/services/home-assistant@homeassistant.service /etc/systemd/system/
sudo systemctl --system daemon-reload
sudo systemctl enable home-assistant@homeassistant

# register rd1 service
cp /root/rd1-boot/services/rd1.service /etc/systemd/system/
sudo systemctl --system daemon-reload
sudo systemctl enable rd1

# install display driver
chmod -R 755 LCD-show
bash LCD-show/LCD35-show

reboot
