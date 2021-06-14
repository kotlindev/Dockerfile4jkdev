FROM php:7.2-apache

MAINTAINER jkdev <https://blog.jkdev.cn>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NOWARNINGS yes

RUN apt-get update && apt-get install -y \
        apt-transport-https \
        dialog \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql mysqli

WORKDIR /var/www/html
EXPOSE 80
CMD ["apache2-foreground"]