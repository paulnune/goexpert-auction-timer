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
help: ## Display the list of available make commands with descriptions
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# ---------- COMPOSE
.PHONY: up
up: ## Start the Docker Compose containers in detached mode
	docker compose up -d

.PHONY: down
down: ## Stop and remove the Docker Compose containers
	docker compose down

.PHONY: restart
restart: down up ## Restart the Docker Compose containers by stopping and starting them again

.PHONY: logs
logs: ## Tail the logs of Docker Compose containers in real-time
	docker compose logs -f

# ---------- TESTS
.PHONY: create
create: ## Send a POST request to create an auction
	curl -X POST http://localhost:8080/auction \
		-H "Content-Type: application/json" \
		-d '{"product_name": "celular", "category": "eletronicos", "description": "Iphone 1 8GB", "condition": 0}'

.PHONY: list
list: ## Send a GET request to list auctions with status=0
	curl -X GET http://localhost:8080/auction?status=0 \
		-H "Content-Type: application/json"

.PHONY: check
check: ## Send a GET request to check auctions with status=1
	curl -X GET http://localhost:8080/auction?status=1 \
		-H "Content-Type: application/json"

.PHONY: clear
clear: ## Remove all Docker containers, images, and volumes, and clean up the system
	@if [ "$(shell docker ps -a -q)" != "" ]; then \
		sudo docker rm -f $(shell docker ps -a -q); \
	else \
		echo "No containers to remove."; \
	fi
	@if [ "$(shell docker images -q)" != "" ]; then \
		sudo docker rmi -f $(shell docker images -q); \
	else \
		echo "No images to remove."; \
	fi
	@if [ "$(shell docker volume ls -q)" != "" ]; then \
		sudo docker volume prune -f; \
	else \
		echo "No volumes to remove."; \
	fi
	sudo docker system prune -af

.PHONY: test
test: ## Run a specific test file or package.
	go test -v internal/infra/database/auction/create_auction_test.go

.PHONY: all
all: ## Run all commands in sequence: clear, up, create, list, check, test
	$(MAKE) clear
	sleep 5
	$(MAKE) up
	sleep 5
	$(MAKE) create
	sleep 5
	$(MAKE) list
	sleep 5
	$(MAKE) check
	sleep 5
	$(MAKE) test
