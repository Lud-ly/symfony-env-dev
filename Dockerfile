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
        libpng-dev \       
        libjpeg-dev \    
        libfreetype6-dev \ 
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# PHP Extensions installation
RUN docker-php-ext-install bcmath gd intl pdo_pgsql zip

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Symfony CLI
RUN wget https://get.symfony.com/cli/installer -O - | bash \
    && mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

# Working directory
WORKDIR /workspace
