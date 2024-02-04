# README

# Description

This template is made to create a symfony project with a docker environment.
In local, staging or production, the project will run with docker.

# Requirements

- docker
- docker-compose
- make (a Makefile is provided to simplify the use of this template)

# Development

- Clone the repository


- Create a .env file from the .env.local.exemple file
  - You have to define your application name
  - If needed you can change the services ports
  - If needed you can change the database credentials
  - If needed you can change the pgadmin credentials
 

- Modify the networks name in `./docker/local/docker-compose.yml` file (replace YOUR_APP_NAME by your application name, let the '_network' suffix)
 

- create a docker network with the following command:
`docker network create YOUR_APP_NAME_network` (replace YOUR_APP_NAME by your application name)
 

- Run `make local-up` to build the docker environment


- Run `make help` to see the available commands
# Staging

# Production