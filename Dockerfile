FROM yewill/docker-gitscrum

RUN mkdir /home/www-deploy

#Install laravel-gitscrum
RUN git clone https://github.com/soxueren/laravel-gitscrum.git /home/www-deploy/laravel-gitscrum

RUN groupadd www-deploy \
    && useradd www-deploy -g www-deploy -m   

RUN	chown -R www-deploy:www-deploy /home/www-deploy && \
	chown -R www-deploy:www-deploy /tmp && \
	chmod -R 755 /home/www-deploy
 
USER www-deploy
RUN cd /home/www-deploy/laravel-gitscrum \
    && composer update \
    && composer run-script post-root-package-install
    
USER root

RUN mkdir /var/log/php-fpm
RUN mkdir /var/log/nginx
RUN mkdir /var/gitscrum-root

EXPOSE 9200 9000 9090

CMD ["php-fpm"]
