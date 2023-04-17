help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

all: all-before start-mongodb-cluster start-mongodb start-rabbitmq start-kafka start-redis start-mysql start-postgresql start-kafka-ui start-wiremock # Start all containers

all-before: start-network

stop: stop-mongodb-cluster stop-mongodb stop-rabbitmq stop-kafka stop-redis stop-mysql stop-postgresql stop-kafka-ui stop-wiremock stop-network # Stop and remove all containers

status: ps-mongodb-cluster ps-mongodb ps-rabbitmq ps-kafka ps-redis ps-mysql ps-postgresql ps-kafka-ui ps-wiremock# Show status of all containers

clean: stop # Stop and remove all containers and the data directory
	rm -r data

start-network: # Create the local-environment network
	docker network create local-environment || true
stop-network: # Remove the local-environment network
	docker network rm local-environment

start-mongodb-cluster: start-network # Start the MongoDB cluster
	docker compose -f mongodb-cluster.yaml up -d
stop-mongodb-cluster: # Stop the MongoDB cluster
	docker compose -f mongodb-cluster.yaml down
ps-mongodb-cluster: # Show status of the MongoDB cluster
	docker compose -f mongodb-cluster.yaml ps

start-mongodb: start-network # Start MongoDB
	docker compose -f mongodb.yaml up -d
stop-mongodb: # Stop MongoDB
	docker compose -f mongodb.yaml down
ps-mongodb: # Show status of MongoDB
	docker compose -f mongodb.yaml ps

start-rabbitmq: start-network # Start the RabbitMQ cluster
	docker compose -f rabbitmq.yaml up -d
stop-rabbitmq: # Stop the RabbitMQ cluster
	docker compose -f rabbitmq.yaml down
ps-rabbitmq: # Show status of the RabbitMQ cluster
	docker compose -f rabbitmq.yaml ps

start-kafka: start-network # Start the Kafka cluster
	docker compose -f 1Z-3K-kafka-cluster.yaml up -d
stop-kafka: # Stop the Kafka cluster
	docker compose -f 1Z-3K-kafka-cluster.yaml down
ps-kafka: # Show status of the Kafka cluster
	docker compose -f 1Z-3K-kafka-cluster.yaml ps

start-redis: start-network # Start the Redis
	docker compose -f cache.yaml up -d
stop-redis: # Stop the Redis
	docker compose -f cache.yaml down
ps-redis: # Show status of the Redis
	docker compose -f cache.yaml ps

start-mysql: start-network # Start the MySQL
	docker compose -f mysql.yaml up -d
stop-mysql: # Stop the MySQL
	docker compose -f mysql.yaml down
ps-mysql: # Show status of the MySQL
	docker compose -f mysql.yaml ps

start-postgresql: start-network # Start the PostgreSQL
	docker compose -f postgres.yaml up -d
stop-postgresql: # Stop the PostgreSQL
	docker compose -f postgres.yaml down
ps-postgresql: # Show status of the PostgreSQL
	docker compose -f postgres.yaml ps


start-kafka-ui: start-network start-kafka # Start the Kafka UI
	docker compose -f kafka-ui.yaml up -d
stop-kafka-ui: # Stop the Kafka UI
	docker compose -f kafka-ui.yaml down
ps-kafka-ui: # Show status of the Kafka UI
	docker compose -f kafka-ui.yaml ps


start-wiremock: start-network start-kafka # Start the Kafka UI
	docker compose -f wiremock.yaml up -d
stop-wiremock: # Stop the Kafka UI
	docker compose -f wiremock.yaml down
ps-wiremock: # Show status of the Kafka UI
	docker compose -f wiremock.yaml ps