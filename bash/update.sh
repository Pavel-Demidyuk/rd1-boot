#!/usr/bin/env bash
cd /root/rd1 && \
git pull && \
docker system prune -f && \
docker build -t paveldemidyuk/rd1-app:arm . && \
docker push paveldemidyuk/rd1-app:arm

