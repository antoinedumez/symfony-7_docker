#---Symfony and Docker Makefile---------------#
# License: MIT
#---------------------------------------------#

#---VARIABLES---------------------------------#
#---PROJECT---#
APP_NAME = sidtest
##=== 🐋  DOCKER ================================================
##- Global -----------------------------------------------------
make docker-network: ## Create docker network.
	docker network create ${DOCKER_NETWORK_NAME}
##- Local -------------------------------------------------------
local-down:	## Stop docker containers.
	docker compose --env-file .env -f docker/local/docker-compose.yml down

local-up: ## Start docker containers.
	docker compose --env-file .env -f docker/local/docker-compose.yml up --build

local-restart: ## Restart docker containers.
	make local-down && make local-up

local-bash: ## Start bash in php container.
	docker exec -it local_${APP_NAME}_app bash

local-migrate: ## Run migrations.
	php bin/console make:migration --no-interaction && \
	php bin/console d:m:m --no-interaction && \
	php bin/console cache:clear


##- Staging -----------------------------------------------------
staging-build: ## Build image.
	docker build -f ./docker/global/Dockerfile --build-arg name=staging -t ${APP_NAME}:staging .

staging-up: ## Start docker containers.
	docker compose --env-file .env.staging -f docker/global/docker-compose.yml down && \
	docker compose --env-file .env.staging -f docker/global/docker-compose.yml up

staging-down: ## Stop docker containers.
	docker compose --env-file ./bin/staging/.env.staging -f docker/global/docker-compose.yml down

staging-bash: ## Start bash in php container.
	docker exec -it staging_${APP_NAME}_app bash

staging-migrate: ## Run migrations.
	php bin/console d:m:m --no-interaction

##- Deploy -----------------------------------------------------
deploy: ## run migrations + composer install + cache clear.
	php bin/console d:m:m --no-interaction && \
	composer install && \
	php bin/console cache:clear && \
	exec apache2-foreground


##- Help -----------------------------------------------------
help: ## Show this help.
	@echo "Symfony and Docker Makefile"
	@echo "---------------------------"
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'