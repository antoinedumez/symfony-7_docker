#!/bin/bash

pwd && \
docker compose -f docker/global/docker-compose.yml down && \
docker compose --env-file ./bin/staging/.env.staging -f docker/global/docker-compose.yml  up