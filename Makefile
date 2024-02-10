#---Symfony and Docker Makefile---------------#
# License: MIT
#---------------------------------------------#

#---VARIABLES---------------------------------#
#---PROJECT---#
APP_NAME = YOUR_APP_NAME
DOCKER_NETWORK_NAME = ${APP_NAME}_network

##=== 🐋  DOCKER ================================================
##- Global -----------------------------------------------------
make define-app-name: ## Define app name.
	./bin/test.sh

make docker-network: ## Create docker network.
	docker network create ${DOCKER_NETWORK_NAME}

migration-create: ## Create migrations.
	php bin/console make:migration --no-interaction

migration-migrate: ## Run migrations.
	php bin/console d:m:m --no-interaction && \
	php bin/console cache:clear

composer-install: ## Run composer install.
	composer install --no-interaction

deploy: ## run migrations + composer install + cache clear.
	make composer-install && \
	make migration-migrate


##- Local -------------------------------------------------------
local-down:	## Stop docker containers.
	docker compose --env-file .env -f docker/local/docker-compose.yml down

local-up: ## Start docker containers.
	docker compose --env-file .env -f docker/local/docker-compose.yml up --build -d

local-restart: ## Restart docker containers.
	make local-down && make local-up

local-bash: ## Start bash in php container.
	docker exec -it local_${APP_NAME}_app bash

local-deploy: ## Run deploy script.
	docker exec local_${APP_NAME}_app ./bin/deploy.sh

make local-init: ## Initialize env and start docker containers.
	cp .env.local.exemple .env && \
	./bin/modifyAppName.sh && \
	make docker-network && \
	make local-up && \
	chmod +x ./bin/deploy.sh && \
	make local-deploy && \

	make local-bash

##- Staging -----------------------------------------------------
staging-build: ## Build image.
	docker build -f ./docker/global/Dockerfile --build-arg name=staging -t ${APP_NAME}:staging .

staging-up: ## Start docker containers.
	docker compose --env-file .env.staging -f docker/staging-prod/docker-compose.yml down && \
	docker compose --env-file .env.staging -f docker/staging-prod/docker-compose.yml up

staging-down: ## Stop docker containers.
	docker compose --env-file ./bin/staging/.env.staging -f docker/staging-prod/docker-compose.yml down

staging-bash: ## Start bash in php container.
	docker exec -it staging_${APP_NAME}_app bash

staging-migrate: ## Run migrations.
	php bin/console d:m:m --no-interaction


##- Help -----------------------------------------------------
help: ## Show this help.
	@echo "Symfony and Docker Makefile"
	@echo "---------------------------"
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'