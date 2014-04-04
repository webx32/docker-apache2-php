#!/bin/sh

echo Welcome to rootLogins Apache/PHP Docker Container Installer

if [ -f "/src/app.conf" ]; then
    cp /src/app.conf /etc/apache2/sites-available/app.conf
    rm /etc/apache2/sites-enabled/*
    ln -s /etc/apache2/sites-available/app.conf /etc/apache2/sites-enabled/app.conf
fi

if [ ! -d "/var/www" ]; then
    mkdir /var/www
fi

rm -Rvf /var/www/*

if [ -f "/src/index.html" ]; then
    cp /src/index.html /var/www/
    chown www-data:www-data /var/www/index.html
    chmod 0666 /var/www/index.html
fi

echo Installation successfully