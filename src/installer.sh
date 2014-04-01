#!/bin/sh

if [ -f "/src/app.conf" ]; then
    cp /src/app.conf /etc/apache2/sites-available/app.conf
    rm /etc/apache2/sites-enabled/*
    ln -s /etc/apache2/sites-available/app.conf /etc/apache2/sites-enabled/app.conf
fi