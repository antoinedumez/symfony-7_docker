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


- Create a .env file from the .env.local.exemple 


```
If needed you can change the services ports and database or pgadmin credentials
```
- Modify your application name in 3 places :
  - ```./.env```
  - ```./docker/local/docker-compose.yml```
  - ```./Makefile``` 
  

- Run `make local-init`


```
You can run make help to see the available commands
```
# Staging

# Production