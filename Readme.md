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

- Run `make local-init`
- Follow the instructions 
- In the bash container opened, run `make local-watch`

```
Your application is available at http://localhost:1080 and your pgadmin at http://localhost:5050.

Next time you want to start your application, you can run `make local-start`.

You can run make help to see the available commands
```

# Staging

Build the image with `make staging-build`
Run the application with `make staging-start`
# Production