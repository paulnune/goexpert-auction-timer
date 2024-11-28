# ---------- CONFIGURATION
ENV_FILE := cmd/auction/.env
ifneq ("$(wildcard $(ENV_FILE))","")
    include $(ENV_FILE)
    export $(shell sed 's/=.*//' $(ENV_FILE))
else
    $(error Environment file $(ENV_FILE) not found. Please ensure it exists.)
endif

# ---------- UTILS
.PHONY: help
help: ## Show this menu
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: clean
clean: ## Clean all temp files
	@rm -f coverage.*

# ---------- COMPOSE
.PHONY: up
up: ## Put the compose containers up
	docker compose up -d

.PHONY: down
down: ## Put the compose containers down
	docker compose down

.PHONY: restart
restart: down up ## Restart the compose containers

.PHONY: logs
logs: ## Show the logs of compose containers
	docker compose logs -f

# ---------- TESTS
.PHONY: test
test: ## Run all tests
	go test ./...

.PHONY: coverage
coverage: ## Generate test coverage report
	go test ./... -coverprofile=coverage.out
	go tool cover -html=coverage.out
