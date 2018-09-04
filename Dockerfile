FROM yewill/docker-gitscrum


    
#Install laravel-gitscrum
RUN git clone https://github.com/soxueren/laravel-gitscrum.git /var/www/html/laravel-gitscrum
ADD .env /var/www/html/laravel-gitscrum

RUN mkdir /var/log/php-fpm

#add user
RUN groupadd www-data && \
    useradd -m -r www-data -g www-data
    
RUN chown -R www-data:www-data /var/www/html && \    
	chmod -R 777 /home/www-data && \
	chmod -R 777 /var/www/html

#add user
RUN groupadd www-deploy && \
    useradd -m -r www-deploy -g www-deploy  
    
RUN chown -R www-deploy:www-deploy /tmp && \
    chmod -R 777 /home/www-deploy && \
    chmod -R 777 /var/log/php-fpm
    
#composer run-script    
USER www-deploy

RUN cd /var/www/html/laravel-gitscrum \
    && composer update \
    && composer run-script post-root-package-install
    
USER root

EXPOSE 9200 9000 9090

CMD ["php-fpm"]
