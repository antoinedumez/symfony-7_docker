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


```
You have to define your application name
If needed you can change the services ports and database or pgadmin credentials
```

- Modify the networks name in `./docker/local/docker-compose.yml` file (replace YOUR_APP_NAME by your application name, let the '_network' suffix)
 

- Run `make local-init`


```
You can run make help to see the available commands
```
# Staging

# Production