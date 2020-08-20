#!/bin/bash
echo "starting rd1-dashboard"
cd /root/rd1-dashboard
git pull
pm2 delete rd1-dashboard ; pm2 --name rd1-dashboard start npm -- start | tee /tmp/rd1-dashboard-preboot.log
echo "done starting rd1-dashboard"
