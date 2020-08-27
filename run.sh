#!/usr/bin/env bash
echo -e "\e[42m\n\n\n ---- starting custom rd1 scripts from /home/pi/rd1-boot/custom.sh  ---- \n\e[0m"
echo -e "\e[42m\n\n\n Starting to load RD1 CUSTOM.SH ---- \n\e[0m"
#params="-a --noverbose -T 1"
params="-a"
fbi $params /home/pi/rd1-boot/loading_images/loading1.png
#bash /home/pi/rd1-boot/bash/resize.sh ; sleep 1

#dashboard
fbi $params /home/pi/rd1-boot/loading_images/loading2.png
bash /home/pi/rd1-boot/bash/services/rd1-dashboard.sh

#owserver
fbi $params /home/pi/rd1-boot/loading_images/loading3.png
bash /home/pi/rd1-boot/bash/services/rd1-owserver.sh

#mqtt
fbi $params /home/pi/rd1-boot/loading_images/loading4.png
bash /home/pi/rd1-boot/bash/services/mqtt.sh

#nodered
fbi $params /home/pi/rd1-boot/loading_images/loading5.png
bash /home/pi/rd1-boot/bash/services/nodered.sh

#rd1-app
fbi $params /home/pi/rd1-boot/loading_images/loading6.png
bash /home/pi/rd1-boot/bash/upgrade.sh; bash /home/pi/rd1-boot/bash/services/rd1-app.sh

# chromium
fbi $params /home/pi/rd1-boot/loading_images/loading7.png
bash /home/pi/rd1-boot/bash/chromium.sh | tee /tmp/rd1-chromium-preboot.log
wait
echo -e "\e[42m\n\n\n Finished custom rd1 scripts"
