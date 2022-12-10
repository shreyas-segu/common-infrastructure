all: all-before mongodb-start rabbitmq-start kafka-start redis-start mysql-start postgresql-start

all-before: network-start

stop: mongodb-stop rabbitmq-stop kafka-stop redis-stop mysql-stop postgresql-stop network-stop

status: mongodb-ps rabbitmq-ps kafka-ps redis-ps mysql-ps postgresql-ps

clean: stop
	rm -r data

network-start:
	docker network create local-environment || true
network-stop:
	docker network rm local-environment

mongodb-start: network-start
	docker compose -f mongodb-cluster.yaml up -d
mongodb-stop:
	docker compose -f mongodb-cluster.yaml down
mongodb-ps:
	docker compose -f mongodb-cluster.yaml ps

rabbitmq-start: network-start
	docker compose -f rabbitmq.yaml up -d
rabbitmq-stop:
	docker compose -f rabbitmq.yaml down
rabbitmq-ps:
	docker compose -f rabbitmq.yaml ps

kafka-start: network-start
	docker compose -f 1Z-3K-kafka-cluster.yaml up -d
kafka-stop:
	docker compose -f 1Z-3K-kafka-cluster.yaml down
kafka-ps:
	docker compose -f 1Z-3K-kafka-cluster.yaml ps

redis-start: network-start
	docker compose -f cache.yaml up -d
redis-stop:
	docker compose -f cache.yaml down
redis-ps:
	docker compose -f cache.yaml ps

mysql-start: network-start
	docker compose -f mysql.yaml up -d
mysql-stop:
	docker compose -f mysql.yaml down
mysql-ps:
	docker compose -f mysql.yaml ps

postgresql-start: network-start
	docker compose -f postgres.yaml up -d
postgresql-stop: 
	docker compose -f postgres.yaml down
postgresql-ps:
	docker compose -f postgres.yaml ps