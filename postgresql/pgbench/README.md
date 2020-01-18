# PgBench

Postgres database comes with a built-in benchmarking tool.

This is very useful to check limitation of the database.

Further reading to see what to benchmark:
- https://wiki.postgresql.org/wiki/Pgbenchtesting

## Start PostgreSQL and PgAdmin

Use the `docker-compose` file provided:

```bash
# Create a docker network for pgadmin to contact PostgreSQL
docker network create pgadmin
# Start both PostgreSQL and PgAdmin in background
docker-compose up -d
```

## Init your benchmark database
Pgbench will feed the database to be benchmarked.
It provides a `-i` option to create table and insert data for you, 
with a scaling factor `-s` depending of how much data we want to benchhmark on.

We follow the init command from the [pgbench testing wiki page](https://wiki.postgresql.org/wiki/Pgbenchtesting)

```bash
docker exec -it postgres-12-pgbench pgbench -U sigl2020 -i -s 70 bench2
```

## Try out a benchmark

> Note: you can monitor postgres stats while test are running by lanching 
> `docker stats` on another terminal. This will monitor postgres container stats

Let's see how well postgres perform on READ and WRITE, on your local machine with 2GB memory limitation (comes from docker-compose)

To understand commands you are typing, you can refer to [pgbench man page](https://www.postgresql.org/docs/10/pgbench.html)

```bash
# Read-Write Test

docker exec -it postgres-12-pgbench pgbench -U sigl2020 -c 4 -j 2 -T 60 bench2

# Read-Only Test

docker exec -it postgres-12-pgbench pgbench -U sigl2020 -c 4 -j 2 -T 60 -S bench2

# Simple Write Test

docker exec -it postgres-12-pgbench pgbench -U sigl2020 -c 4 -j 2 -T 60 -N bench2
```

## Tying out other benchmarks

You can complete other benchmarks mention in sections of [this doc](https://wiki.postgresql.org/wiki/Pgbenchtesting).
Just use `docker exec -it postgres-12-pgbench pgbench -U sigl2020` instead of `pgbench`, and `bench2` as a database.

Example:
```bash
# instead of pgbench -i -s 30 bench
docker exec -it postgres-12-pgbench pgbench -U sigl2020 -i -s 30 bench2
```
