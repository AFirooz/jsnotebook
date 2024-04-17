#!/usr/bin/env bash

set -o errexit
docker build -t jupyter -f ./docker/images/Dockerfile ./
docker-compose --file ./docker/compose/docker-compose.yml up