#!/usr/bin/env bash
# step 1: login to dietpi and setup internet connection
# step 2: bash -c "$(wget --no-check-certificate https://cutt.ly/rd1-start && cat rd1-start)"



#sudo su
#RD1_STRING="#rd1 updates"
#grep -q $RD1_STRING /boot/config.txt || ( \
#echo $RD1_STRING >> /boot/config.txt && \
#echo "dtparam=i2s=on" >> /boot/config.txt && \
#echo "dtparam=spi=on" >> /boot/config.txt && \
#echo "dtoverlay=piscreen,speed=16000000,rotate=90" >> /boot/config.txt && \
#echo "dtparam=i2c_arm=on" >> /boot/config.txt)
#su pi



echo -e "\e[42m\n\n\n ---- Update RPI ---- \e[0m"
sudo apt-get update --yes && sudo apt-get upgrade  --yes || exit 1

echo -e "\e[42m\n\n\n ---- Install display driver ---- \e[0m"
cd LCD-SHOW
./LCD35-show
cd ..

echo -e "\e[35m\n\n\n ---- Desktop setup ---- \e[0m"
#sudo apt-get install lightdm || exit 1
#sudo apt-get install --no-install-recommends xserver-xorg x11-xserver-utils xinit openbox


echo -e "\e[42m\n\n\n ---- Install DOCKER ---- \n\e[0m"
docker -v || (curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh)

echo -e "\e[42m\n\n\n ---- Install Chromium ---- \n\e[0m"
# install chromium
chromium-browser --version || sudo apt-get install chromium-browser --yes

echo -e "\e[42m\n\n\n ---- Install FBI ---- \n\e[0m"
#install fbi
fbi --version || sudo apt-get install -y fbi

echo -e "\e[42m\n\n\n ---- Install Unclutter ---- \n\e[0m"
#install fbi
unclutter --version || sudo apt-get install -y unclutter

echo -e "\e[42m\n\n\n ---- Pull DOCKER ---- \n\e[0m"
# pull rd1-app
docker pull eu.gcr.io/rd1-build/rd1-app:arm || exit 1  &
# pull rd1-dashboard
docker pull eu.gcr.io/rd1-build/rd1-dashboard:arm || exit 1  &
# pull rd1-owserver
docker pull eu.gcr.io/rd1-build/rd1-owserver:arm || exit 1 &
# pull mqtt
docker pull eu.gcr.io/rd1-build/eclipse-mosquitto:latest || exit 1 &
# pull nodered
docker pull eu.gcr.io/rd1-build/node-red:latest || exit 1 &
wait

echo -e "\e[42m\n\n\n ---- Install HASSIO ---- \n\e[0m"
##setup hassio
bash install_hassio.sh || exit 1

echo -e "\e[42m\n\n\n ---- Register rd1 service ---- \n\e[0m"
# register rd1 service
cp /home/pi/rd1-boot/services/rd1.service /etc/systemd/system/
sudo systemctl --system daemon-reload
sudo systemctl enable rd1

echo -e "\e[42m\n\n\n ---- Install Display Drivers ---- \n\e[0m"
# install display driver
chmod -R 755 /home/pi/rd1-boot/LCD-show || exit 1
cd /home/pi/rd1-boot/LCD-show/ && ./LCD35-show || exit 1

echo -e "\e[42m\n\n\n ---- REBOOT!! ---- \n\e[0m"
sleep 3
reboot
