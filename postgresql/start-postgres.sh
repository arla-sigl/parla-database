#! /bin/sh

docker network create pgadmin
docker-compose up -d
docker exec postgres-12 psql -U sigl2020 -d hikedb -a -f /scripts/create-hike-database.sql
docker exec postgres-12 psql -U sigl2020 -d hikedb -a -f /scripts/load-test-data.sql
