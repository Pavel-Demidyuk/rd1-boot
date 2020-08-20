#!/usr/bin/env bash
git pull && \
docker system prune -f && \
docker build -t paveldemidyuk/rd1-app:arm .

