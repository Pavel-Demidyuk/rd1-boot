#!/usr/bin/env bash
#step 1: cleanup
echo "removing cached accessories"
rm -rf /root/rd1/configs/homebridge/accessories
rm -rf /root/rd1/configs/homebridge/persist
echo "done removing cached accessories"
echo "git cleanup"
cd /root/rd1/ && git clean -fd  && git checkout . && git reset --hard
echo "done git cleanup"
echo "docker cleanup"
docker system prune -f
echo "done docker cleanup"
