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
npm -s restart
echo "done updating dashboard"
