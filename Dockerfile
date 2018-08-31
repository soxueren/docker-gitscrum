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

EXPOSE 9200 9000 9090 80

CMD ["php-fpm"]
