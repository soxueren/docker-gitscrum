FROM php:7-fpm-alpine

RUN apk update && apk upgrade

#set timezone to locale
ENV TIMEZONE Asia/Shanghai
RUN apk add tzdata
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
RUN echo $TIMEZONE > /etc/timezone

# install nodejs
RUN apk add --no-cache -t deps curl nodejs git

#install php ext lib
RUN docker-php-ext-install mbstring opcache pdo pdo_mysql mysqli iconv mcrypt intl curl zip 
    
RUN apk del --purge deps \
    && rm /var/cache/apk/*
 
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN npm install --global gulp gulp-cli

# Install xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && sed -i '1 a xdebug.remote_autostart=1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.remote_port=9090' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.remote_host=127.0.0.1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.remote_enable=1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.profiler_enable=1' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.profiler_output_dir=/var/log/xdebug' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && sed -i '1 a xdebug.idekey=PHPSTORM' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install php-cs-fixer
RUN curl -L https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v2.0.0/php-cs-fixer.phar -o /usr/local/bin/php-cs-fixer
RUN chmod a+x /usr/local/bin/php-cs-fixer

# Install laravel-gitscrum
RUN git clone git@github.com:GitScrum-Community/laravel-gitscrum.git \
    && cd laravel-gitscrum \
    && composer update \
    && composer run-script post-root-package-install

EXPOSE 9200 9000 9090 80

CMD ["php-fpm"]
