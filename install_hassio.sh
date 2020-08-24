#!/usr/bin/env bash
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
