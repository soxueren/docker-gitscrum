FROM yewill/docker-gitscrum

#add user
RUN groupadd www-deploy && \
    useradd -m -r www-deploy -g www-deploy   
    
#Install laravel-gitscrum
RUN git clone https://github.com/soxueren/laravel-gitscrum.git /var/www/html/laravel-gitscrum
ADD .env /var/www/html/laravel-gitscrum

RUN mkdir /var/log/php-fpm

RUN chown -R www-data:www-data /tmp && \
    chmod -R 777 /home/www-deploy && \
    chmod -R 777 /var/www/html && \
    chmod -R 777 /var/log/php-fpm
    
#composer run-script    
USER www-deploy

RUN cd /var/www/html/laravel-gitscrum \
    && composer update \
    && composer run-script post-root-package-install
    
USER root

EXPOSE 9200 9000 9090

CMD ["php-fpm"]
