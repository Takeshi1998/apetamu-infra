FROM composer:2.0 as vendor

WORKDIR /laravel

COPY ./laravel/database/ database/
COPY ./laravel/composer.json composer.json
COPY ./laravel/composer.lock composer.lock

RUN composer install \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --no-dev \
    --prefer-dist \
    --optimize-autoloader


FROM php:7.4.26-fpm-alpine3.14

RUN addgroup -S nginx && adduser -S nginx -G nginx 
RUN set -eux \
 && apk add --update --no-cache git autoconf g++ vim tzdata libtool make libzip-dev libpng-dev libjpeg-turbo-dev freetype-dev \
 && pecl install redis \
 && docker-php-ext-configure gd --with-jpeg=/usr \
 && docker-php-ext-configure opcache --enable-opcache \
 && docker-php-ext-install opcache bcmath pdo_mysql gd exif zip \
 && docker-php-ext-enable redis \
 && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && apk del autoconf g++ libtool make tzdata \
 && rm -rf /tmp/* \
 && rm -rf /var/cache/apk/*
 

COPY ./prod/php/php.ini /usr/local/etc/php/php.ini
COPY ./prod/php/zz-docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf

COPY ./laravel /var/www/laravel/
#vendor,frontendコンテナから、ビルドファイルのみを実行コンテナにコピーする。
COPY --from=vendor /laravel/vendor/ /var/www/laravel/vendor/

WORKDIR /var/www/laravel
RUN php artisan config:clear \
 && php artisan route:cache \
 && chmod -R 777 ./bootstrap ./storage






