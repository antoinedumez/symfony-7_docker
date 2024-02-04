#!/bin/bash

docker build -f ./docker/global/Dockerfile --build-arg name=staging -t sid_test:staging .
