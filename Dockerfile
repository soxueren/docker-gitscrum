FROM yewill/docker-gitscrum

# Install laravel-gitscrum
RUN git clone https://github.com/soxueren/laravel-gitscrum.git \
    && cd laravel-gitscrum \
    && composer update \
    && composer run-script post-root-package-install

EXPOSE 9200 9000 9090 80

CMD ["php-fpm"]
