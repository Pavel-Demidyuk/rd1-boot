#!/usr/bin/env bash
name='rd1-app'
sudo docker stop $name && echo $name 'service stopped'
sudo docker kill $name && echo $name 'service killed'
sudo docker rm $name && echo $name 'service removed'
sudo docker system prune -f
echo $name 'service stopped'
