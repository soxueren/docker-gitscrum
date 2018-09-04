# Docker-GitScrum
Docker containers for Laravel GitScrum

# Build Containers
You can run the command on your bash to build the containers
```
docker-compose up --build
```
# docker image
docker pull soxueren/gitscrum:latest
# laravel-gitscrum php files
all files for php-fpm in /var/www/html/laravel-gitscrum of soxueren/gitscrum:latest 
can dir copy to nignx
# migrate database
cd /var/www/html/laravel-gitscrum
php artisan migrate
php artisan db:seed --class=SettingSeeder
# How to install Docker Compose
[Docker Compose](https://docs.docker.com/compose/install/)
# How to install kubernetes
## create configmap
kubectl create configmap gitscrum-config --from-file=./config/ --namespace=test
## create mysql-pvc
kubectl apply -f mysql-pvc.yml
## create development 
kubectl apply -f gitscrum-rc.yml
