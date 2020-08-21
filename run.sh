#!/usr/bin/env bash

echo "starting custom rd1 scripts from /root/rd1-boot/custom.sh"
echo "Starting to load RD1 CUSTOM.SH"
fbi -a --noverbose -T 1 /root/rd1-boot/loading_images/loading1.png
#bash /root/rd1-boot/bash/resize.sh ; sleep 1

fbi -a --noverbose -T 1 /root/rd1-boot/loading_images/loading2.png
bash /root/rd1-boot/bash/dashboard.sh

fbi -a --noverbose -T 1 /root/rd1-boot/loading_images/loading3.png
bash /root/rd1-boot/bash/services/owserver_run.sh
fbi -a --noverbose -T 1 /root/rd1-boot/loading_images/loading4.png
bash /root/rd1-boot/bash/services/mqtt_run.sh
fbi -a --noverbose -T 1 /root/rd1-boot/loading_images/loading5.png
bash /root/rd1-boot/bash/services/nodered_run.sh
fbi -a --noverbose -T 1 /root/rd1-boot/loading_images/loading6.png
bash /root/rd1-boot/bash/upgrade.sh; bash /root/rd1-boot/bash/services/rd1_run.sh
fbi -a --noverbose -T 1 /root/rd1-boot/loading_images/loading7.png
sleep 1
bash /root/rd1-boot/bash/chromium.sh | tee /tmp/rd1-chromium-preboot.log
wait
echo "Finished custom rd1 scripts"
