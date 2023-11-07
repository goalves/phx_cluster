# PhxCluster

Example of how to run an Elixir Phoenix application with libcluster with Docker and the Gossip strategy.

```
docker build . -t phx_cluster:latest
docker-compose up --scale app=2
```
