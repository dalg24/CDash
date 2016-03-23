FROM php:5.6-apache

RUN apt-get update && apt-get install -y \
        libxslt-dev libpng-dev libcurl4-openssl-dev \
        git

# Install PHP extensions using the helper scripts.
RUN docker-php-ext-install pdo mysql xsl curl gd

# Set up time zone
RUN echo "America/New_York" > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Checkout CDash using GIT.
RUN cd /var/www/html && \
    git clone https://github.com/Kitware/CDash.git && \
    cd CDash && git checkout release && \
    chown -R www-data:www-data /var/www/html/CDash

# Add a cdash/config.local.php file to connect to the database.
ADD cdash-config.local.php /var/www/html/CDash/cdash/config.local.php

ADD apache-cdash.conf /etc/apache2/sites-available/cdash.conf
# Enable the CDash apache2 site.
RUN a2ensite cdash

EXPOSE 80
