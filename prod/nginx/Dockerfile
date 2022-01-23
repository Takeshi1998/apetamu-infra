FROM node:14.18.1-alpine3.14 as frontend

RUN  npm uninstall -g npm \
 && rm -rf .npm \
 && apk add --update --no-cache npm 
WORKDIR /laravel

COPY ./laravel/package.json package.json 
COPY ./laravel/package-lock.json package-lock.json
RUN npm install

COPY ./laravel/resources/js ./resources/js
COPY ./laravel/resources/sass ./resources/sass
COPY ./laravel/webpack.mix.js webpack.mix.js
RUN npm run prod


FROM nginx:1.19-alpine

RUN apk --update add tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk del tzdata && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/* 

COPY ./prod/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./prod/nginx/nginx.conf /etc/nginx/nginx.conf

COPY ./laravel/public /var/www/laravel/public
COPY --from=frontend /laravel/node_modules/ /var/www/laravel/node_modules/
COPY --from=frontend /laravel/public/js/ /var/www/laravel/public/js/
COPY --from=frontend /laravel/public/css/ /var/www/laravel/public/css/

VOLUME ["/var/www/laravel/public"]

WORKDIR /var/www/laravel