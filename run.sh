#!/usr/bin/env bash

set -o errexit
sudo true
sudo docker build -t jupyter -f ./Dockerfile ./
sudo docker-compose --file ./docker-compose.yml up
sudo -k
