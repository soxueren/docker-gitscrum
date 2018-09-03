FROM yewill/docker-gitscrum

RUN useradd www-data -g www-data -m
    
#Install laravel-gitscrum
RUN git clone https://github.com/soxueren/laravel-gitscrum.git /var/www/html/laravel-gitscrum

ADD .env /var/www/html/laravel-gitscrum

RUN chown -R www-data:www-data /home/www-data && \
    chown -R www-data:www-data /tmp && \
    chown -R www-data:www-data /var/www/html/ && \
    chmod -R 755 /var/www/html/laravel-gitscrum
 
USER www-data

RUN cd /var/www/html/laravel-gitscrum \
    && composer update \
    && composer run-script post-root-package-install
    
USER root

RUN mkdir /var/log/php-fpm
RUN mkdir /var/log/nginx

EXPOSE 9200 9000 9090

CMD ["php-fpm"]
