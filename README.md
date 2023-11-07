# PhxCluster

Example of how to run an Elixir Phoenix application with libcluster with Docker and the Gossip strategy.

First setup the database because I have decided to add one to the project

```sh
psql -h localhost -p 5432 -U postgres
CREATE DATABASE phx_cluster_prod
```

Now build the docker image and run it with a specific amount of instances

```sh
docker build . -t phx_cluster:latest
docker-compose up --scale app=2
```

Now in another terminal you can scale the number of instances

```sh
docker-compose up --scale app=5 -d
```
