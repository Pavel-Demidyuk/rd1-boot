#!/usr/bin/env bash
echo -e "\e[42m\n\n\n ---- starting custom rd1 scripts from /home/pi/rd1-boot/custom.sh  ---- \n\e[0m"
echo -e "\e[42m\n\n\n Starting to load RD1 CUSTOM.SH ---- \n\e[0m"
#bash /home/pi/rd1-boot/bash/resize.sh ; sleep 1
#dashboard
bash /home/pi/rd1-boot/bash/services/rd1-dashboard.sh
#owserver
bash /home/pi/rd1-boot/bash/services/rd1-owserver.sh
#mqtt
bash /home/pi/rd1-boot/bash/services/mqtt.sh
#nodered
bash /home/pi/rd1-boot/bash/services/nodered.sh
#rd1-app
bash /home/pi/rd1-boot/bash/upgrade.sh; bash /home/pi/rd1-boot/bash/services/rd1-app.sh
