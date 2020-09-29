#!/bin/bash
set -exv
docker build  --no-cache \
              --force-rm \
              -t jiralert:latest  \
              -f ./Dockerfile .
