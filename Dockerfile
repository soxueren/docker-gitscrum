FROM yewill/docker-gitscrum

RUN groupadd www-data \
    && useradd www-data -g www-data -m   
    
#Install laravel-gitscrum
RUN git clone https://github.com/soxueren/laravel-gitscrum.git /home/www-data/laravel-gitscrum

ADD .env /home/www-data/laravel-gitscrum/

RUN chown -R www-data:www-data /home/www-data && \
    chown -R www-data:www-data /tmp && \
    chmod -R 755 /home/www-data
 
USER www-data

RUN cd /home/www-data/laravel-gitscrum \
    && composer update \
    && composer run-script post-root-package-install
    
USER root

RUN mkdir /var/log/php-fpm
RUN mkdir /var/log/nginx
RUN mkdir /var/gitscrum-root

EXPOSE 9200 9000 9090

CMD ["php-fpm"]
