# TDC Floripa 2024 - CDC SQL Server with Debezium Kafka Connect

### Requirements before start
- Makefile
- Docker and Docker-compose
- jq (to format json outputs)

### How to start
All you needed is located on `Makefile`, just type `make` and you'll see the commands available. Follow the steps bellow and will be enough:

1. `make start` , wait until everything is running. SQL Server takes a bit more to start, so even after this step, you should wait for 30 seconds or more. 
2. `make init-sqlserver`, if you receive any timeout error likely the SQL Server is starting, so trying again in some seconds. It should create all you need to use the CDC on SQL Server side.
3. `make create-debezium-connector`, creates the debezium connector to extract data from SQL Server.
4. `make populate-sqlserver`, in order to see data being delivered to Kafka, you'll need a DML operation, so this recipe will insert some data for you.
5. Finally, see your data on [AKHQ](http://localhost:8080/ui/kafka/topic/cdc.tdcfloripa2024.dbo.events/data?sort=Oldest&partition=All).

That's all folks, enjoy !!!


### Clean up

If you want to start again, just execute `make stop` and `make clean-data`, this will clean up everything (containers and data folders) so you can start a fresh install.