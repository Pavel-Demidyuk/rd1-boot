#!/usr/bin/env bash

# update rd1-dashboard
sudo killall -9 node npm
cd /home/pi/
rm -rf rd1-dashboard
wget --no-check-certificate https://github.com/Pavel-Demidyuk/rd1-dashboard/archive/master.zip  && mv master.zip dashboard.zip
unzip dashboard.zip
rm -rf dashboard.zip
mv rd1-dashboard-master rd1-dashboard
cd /home/pi/rd1-dashboard && sudo npm install -g npm@latest && npm install
sudo docker pull eu.gcr.io/rd1-build/rd1-app:arm
sudo docker pull eu.gcr.io/rd1-build/rd1-owserver:arm
/home/pi/rd1-boot/services/rd1-owserver.sh
/home/pi/rd1-boot/services/rd1-app.sh
npm -s restart
echo "done"
