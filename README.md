# Docker-GitScrum
Docker containers for Laravel GitScrum

# Build Containers
You can run the command on your bash to build the containers

```
docker-compose up --build
```

# How to install Docker Compose
[Docker Compose](https://docs.docker.com/compose/install/)

# How to install kubernetes
## create configmap
kubectl create configmap gitscrum-config --from-file=./config/ --namespace=test
## create mysql-pvc
kubectl apply -f mysql-pvc.yml
## create development 
kubectl apply -f gitscrum-rc.yml
