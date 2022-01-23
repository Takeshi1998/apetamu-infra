FROM php:7.4.26-fpm-alpine3.14

COPY --from=composer:2.0 /usr/bin/composer /usr/bin/composer

RUN set -eux \
    && apk add --update --no-cache git autoconf g++ vim tzdata libtool make libzip-dev libpng-dev libjpeg-turbo-dev freetype-dev nodejs npm  \
    && pecl install redis xdebug \
    && docker-php-ext-configure gd --with-jpeg=/usr \
    && docker-php-ext-install bcmath pdo_mysql gd exif zip \
    && docker-php-ext-enable redis \
    && docker-php-ext-enable xdebug \
    && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && apk del autoconf g++ libtool make tzdata \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*

COPY ./dev/php/php.ini /usr/local/etc/php/php.ini
COPY ./dev/php/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

WORKDIR /var/www/laravel



