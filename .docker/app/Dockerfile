FROM serversideup/php:8.1-fpm-nginx

# Install PHP Redis
ENV PHPREDIS_VERSION 5.3.4
RUN mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts

COPY ./y-override-php-defaults.conf /etc/php/8.1/fpm/pool.d/
