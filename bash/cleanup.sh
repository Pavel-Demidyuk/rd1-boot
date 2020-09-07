#!/usr/bin/env bash
#step 1: cleanup
echo "removing cached accessories"
rm -rf /home/pi/rd1-data/homebridge/accessories
rm -rf /home/pi/rd1-data/homebridge/persist
echo "done removing cached accessories"
echo "docker cleanup"
docker system prune -f
echo "done docker cleanup"
