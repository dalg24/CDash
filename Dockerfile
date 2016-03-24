FROM php:5.6-apache

RUN apt-get update && apt-get install -y \
        libxslt-dev libpng-dev libcurl4-openssl-dev

# Install PHP extensions using the helper scripts.
RUN docker-php-ext-install pdo mysql xsl curl gd

# Set up time zone
RUN echo "America/New_York" > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    echo "date.timezone=\"America/New_York\"" \
        > /usr/local/etc/php/conf.d/php.ini

# Download CDash
RUN cd /var/www/html && mkdir /var/www/html/CDash && \
    curl -L https://github.com/Kitware/CDash/archive/Release-2-2-2.tar.gz | \
    tar -xzf - -C CDash --strip-components=1

# Add a cdash/config.local.php file to connect to the database.
ADD cdash-config.local.php /var/www/html/CDash/cdash/config.local.php

ADD apache-cdash.conf /etc/apache2/sites-available/cdash.conf
# Enable the CDash apache2 site.
RUN a2ensite cdash

ADD docker-entrypoint.sh /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
