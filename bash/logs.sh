#!/usr/bin/env bash
docker logs -f $(docker ps -a -q --filter="ancestor=paveldemidyuk/rd1-app:arm")
