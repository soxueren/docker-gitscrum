FROM yewill/docker-gitscrum

RUN mkdir /home/www-deploy

#添加www-deploy用户:用户组
RUN groupadd www-deploy \
    && useradd www-deploy -g www-deploy -m
    
RUN echo 123456 | passwd --stdin www-deploy 

RUN	chown -R www-deploy:www-deploy /home/www-deploy && \
	chown -R www-deploy:www-deploy /tmp && \
	chmod -R 755 /home/www-deploy
    
# Install laravel-gitscrum
RUN g /home/www-deploy
    
USER www-deploy

RUN cd /home/www-deploy \
    && it clone https://github.com/soxueren/laravel-gitscrum.git \
    && cd laravel-gitscrum \
    && composer update \
    && composer run-script post-root-package-install

EXPOSE 9200 9000 9090 80

CMD ["php-fpm"]
