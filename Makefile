# VARIABLES
DOCKER_COMPOSE = docker-compose
CONTAINER      = healthcheck-bundle
EXEC           = docker exec --user=root -ti $(CONTAINER)
EXEC_PHP       = $(EXEC) php
COMPOSER       = $(EXEC) composer
CURRENT-DIR    := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.DEFAULT_GOAL := deploy

deploy: build
	@echo "📦 Build done"

build: rebuild

deps: composer-install

update-deps: composer-update

# 🐘 Composer
composer-install ci: ACTION=install

composer-update cu: ACTION=update $(module)

composer-require cr: ACTION=require $(module)

composer composer-install ci composer-update cu composer-require cr:
	$(COMPOSER) $(ACTION) \
			--ignore-platform-reqs \
			--no-ansi
# 🐳 Docker Compose
start:
	@echo "🚀 Deploy!!!"
	$(DOCKER_COMPOSE) up -d
	make deps
stop:
	$(DOCKER_COMPOSE) stop
down:
	make stop
	$(DOCKER_COMPOSE) down -v
recreate:
	@echo "🔥 Recreate container!!!"
	$(DOCKER_COMPOSE) up -d --build --remove-orphans --force-recreate
	make deps
rebuild:
	@echo "🔥 Rebuild container!!!"
	$(DOCKER_COMPOSE) build --pull --force-rm --no-cache
	make start

test:
	@$(EXEC_PHP) vendor/bin/phpunit tests
