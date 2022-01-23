FROM nginx:1.19-alpine

COPY ./dev/nginx/default.conf /etc/nginx/conf.d/default.conf

RUN apk --update add tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk del tzdata && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/* 

WORKDIR /var/www/laravel