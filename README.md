# Common Infrastructure for local development

## Current Services
- Kafka
- MongoDB Replica Set
- Redis
- RabbitMQ
- Postgres
- MySQL

## Work with Services
```sh
# Show help
make help
```

```sh
# Start all services
make

# Stop all services
make stop

# Check status of all services
make ps
```

```sh
# Start a service
# make start-<service>
make start-kafka

# Stop a service
# make stop-<service>
make stop-kafka

# Check status of a service
# make ps-<service>
make ps-kafka
```

```sh
# Stop all services and clear data
make clean
```

## Pre Requisites
- Docker
- Docker Compose
- Make

### Add to /etc/hosts
```
127.0.0.1   kafka-1 kafka-2 kafka-3 mongo1 mongo2 mongo3
```