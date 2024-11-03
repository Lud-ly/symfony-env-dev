# Base image
FROM php:8.3-cli

# Install dependencies
RUN apt-get update \
    && apt-get install -y \
        git \
        libicu-dev \
        libpq-dev \
        libzip-dev \
        unzip \
        wget \
        zip \
        curl \
        docker.io \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# PHP Extensions
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions \
    bcmath \
    gd \
    intl \
    pdo_pgsql \
    zip

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Symfony CLI
RUN wget https://get.symfony.com/cli/installer -O - | bash \
    && mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

# Working directory
WORKDIR /workspace
