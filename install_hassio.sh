#!/usr/bin/env bash
ls /srv/homeassistant/ && echo "Homeassistant already installed" && exit 0
sudo apt-get -y install python3 python3-dev python3-venv python3-pip libffi-dev libssl-dev autoconf build-essential
sudo useradd -rm homeassistant -G dialout,gpio,i2c
cd /srv
sudo mkdir homeassistant
sudo chown homeassistant:homeassistant homeassistant
sudo -u homeassistant -H -s <<'EOF'
cd /srv/homeassistant
python3 -m venv .
source bin/activate
python3 -m pip install wheel
pip3 install homeassistant
EOF
cd /home/pi/rd1-boot
#enable hassio service
sudo cp /home/pi/rd1-boot/install-data/home-assistant@homeassistant.service /etc/systemd/system/
sudo systemctl --system daemon-reload
sudo systemctl enable home-assistant@homeassistant
