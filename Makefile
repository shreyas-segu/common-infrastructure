.PHONY: help start all-before stop status clean start-network stop-network

help: ## Show help for each of the Makefile recipes.
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

start: start-network $(patsubst %.yaml,start-%,$(wildcard *.yaml))  ## Start all containers

stop: $(patsubst %.yaml,stop-%,$(wildcard *.yaml)) stop-network ## Stop and remove all containers

status: ## Status of all containers running 
	@docker ps --format "table {{.ID}} \t {{.Ports}} \t {{.State}} \t {{.Names}}" --filter network=local-environment

clean: stop ## Stop and remove all containers and the data directory
	@rm -r data

start-network: ## Create the local-environment network
	@docker network create local-environment || echo true

stop-network: ## Remove the local-environment network
	@docker network rm local-environment

start-%: start-network ## Start a container based on a YAML file
	@docker compose -f $*.yaml up -d

stop-%: ## Stop a container based on a YAML file
	@docker compose -f $*.yaml down

