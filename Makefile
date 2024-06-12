connector=tdcfloripa2024-debezium-sqlserver-v1

.DEFAULT: help

.PHONY: help
help: 
	@echo "start - Start the project"
	@echo "stop - Stop the project"
	@echo "init-sqlserver - Init tables on SQL Server DB"
	@echo "populate-sqlserver - Populate tables on SQL Server DB"
	@echo "create-debezium-connector - Create Debezium SQL Server connector to ingest data on kafka"
	@echo "delete-debezium-connector - Delete Debezium SQL Server connector"
	@echo "check-connector-status - Check Debezium SQL Server connector status"
	@echo "clean-data - Clean up the project data folders"
	@echo "help - Show this help"

.PHONY: start
start:
	mkdir -p sqlserver_data kafka_data zoo_data
	docker-compose up -d

.PHONY: stop
stop:
	docker-compose down --remove-orphans

.PHONY: init-sqlserver
init-sqlserver:
	docker run --rm -v $(PWD)/scripts:/scripts mcr.microsoft.com/mssql-tools /opt/mssql-tools/bin/sqlcmd -S host.docker.internal -U sa -P Password123! -d master -i /scripts/init.sql

.PHONY: populate-sqlserver
populate-sqlserver:
	docker run --rm -v $(PWD)/scripts:/scripts mcr.microsoft.com/mssql-tools /opt/mssql-tools/bin/sqlcmd -S host.docker.internal -U sa -P Password123! -d master -i /scripts/populate.sql

.PHONY: create-debezium-connector
create-debezium-connector:
	curl -v -X POST -H "Content-Type: application/json" --data @./debezium.json http://localhost:8083/connectors | jq

.PHONY: delete-debezium-connector
delete-debezium-connector:
	curl -v -X DELETE http://localhost:8083/connectors/$(connector) | jq

.PHONY: check-connector-status
check-connector-status:
	curl -v http://localhost:8083/connectors/$(connector)/status | jq

.PHONY: clean-data
clean-data:
	@echo "Cleaning up the project data folders..."
	@rm -rf sqlserver_data kafka_data zoo_data