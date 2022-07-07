ARG PHP_VERSION=8.1

FROM php:${PHP_VERSION}-apache-buster

# Update
RUN apt-get -y update --fix-missing && \
    apt-get upgrade -y && \
    apt-get --no-install-recommends install -y apt-utils && \
    rm -rf /var/lib/apt/lists/*

# Install useful tools and install important libraries
RUN apt-get -y update && \
    apt-get -y --no-install-recommends install nano wget dialog libsqlite3-dev libsqlite3-0 unzip && \
    apt-get -y --no-install-recommends install zlib1g-dev libzip-dev libicu-dev && \
    apt-get -y --no-install-recommends install --fix-missing apt-utils build-essential git curl && \
    apt-get -y --no-install-recommends install --fix-missing libcurl4 libcurl4-openssl-dev zip openssl libssl-dev && \
    apt-get -y --no-install-recommends install --fix-missing libonig-dev openssh-client && \
    rm -rf /var/lib/apt/lists/*

# Install xdebug
RUN pecl install xdebug-3.1.2 && \
    docker-php-ext-enable xdebug

# Copy composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

COPY . /var/www/html

WORKDIR /var/www/html

CMD ["apache2-foreground"]