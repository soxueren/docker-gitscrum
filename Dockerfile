FROM php:7-fpm-alpine

RUN apk update && apk upgrade

#时区配置
ENV TIMEZONE Asia/Shanghai
RUN apk add tzdata
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
RUN echo $TIMEZONE > /etc/timezone

RUN apk add --no-cache python-software-properties nodejs

RUN docker-php-ext-install mbstring opcache pdo pdo_mysql mysqli iconv mcrypt intl curl
RUN apk add docker-php-ext-configure --with-zlib-dir=/usr && docker-php-ext-install zip

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


EXPOSE 9200 9000 9090 80

CMD ["php-fpm"]
