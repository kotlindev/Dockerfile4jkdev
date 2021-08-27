FROM php:7.3-fpm-alpine

MAINTAINER panhongyuan <https://blog.jkdev.cn>

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk update && apk add --no-cache freetype \
     libpng \
     libjpeg-turbo  \
     freetype-dev \
     libpng-dev \
     libjpeg-turbo-dev \
     libzip-dev \
     && docker-php-ext-configure gd \
        --with-gd --with-freetype-dir=/usr/include/ \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ && NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && docker-php-ext-install -j${NPROC} gd  \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && docker-php-ext-install exif \
    && docker-php-ext-install bcmath \
    && docker-php-ext-configure zip --with-libzip=/usr/include && docker-php-ext-install zip \

    && apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev libzip-dev


EXPOSE 9000
CMD ["php-fpm"]
