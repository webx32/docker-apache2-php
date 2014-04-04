#!/bin/sh

echo Welcome to rootLogins Apache/PHP Docker Container Installer

if [ -f "/src/app.conf" ]; then
    cp /src/app.conf /etc/apache2/sites-available/app.conf
    rm /etc/apache2/sites-enabled/*
    ln -s /etc/apache2/sites-available/app.conf /etc/apache2/sites-enabled/app.conf
fi

SECURITY_FILE=/etc/apache2/conf-available/security.conf
if [ -f $SECURITY_FILE ]; then

    sed -i \
        -e "s:ServerTokens OS:ServerTokens Minimal:g" \
        -e "s:ServerSignature On:ServerSignature Off:g" \
        $SECURITY_FILE

    echo "<Directory />" >> $SECURITY_FILE
    echo "AllowOverride None" >> $SECURITY_FILE
    echo "Order Deny,Allow" >> $SECURITY_FILE
    echo "Deny From All" >> $SECURITY_FILE
    echo "</Directory>" >> $SECURITY_FILE
fi

if [ ! -d "/var/www" ]; then
    mkdir /var/www
fi

rm -Rf /var/www/*

if [ -f "/src/index.html" ]; then
    cp /src/index.html /var/www/
    chown www-data:www-data /var/www/index.html
    chmod 0666 /var/www/index.html
fi

a2enmod rewrite

echo Installation successfully