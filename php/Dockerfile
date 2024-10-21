# php/Dockerfile

FROM php:8.2-fpm-alpine

# Install system dependencies
RUN apk add --no-cache \
    oniguruma-dev \
    libxml2-dev \
    zip \
    unzip \
    bash \
    git \
    curl \
    libpng-dev

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html/rte-mis

# Install Drupal dependencies
RUN composer install --no-dev --optimize-autoloader

# Permissions
RUN chown -R www-data:www-data /var/www/html/rte-mis

# Expose port 9000
EXPOSE 9000

CMD ["php-fpm"]
