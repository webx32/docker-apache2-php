FROM ubuntu:precise
MAINTAINER Simon Erhardt <me@rootlogin.ch>

# Change sources.list and update packages
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://archive.ubuntu.com/ubuntu precise-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://archive.ubuntu.com/ubuntu precise-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://ppa.launchpad.net/ondrej/php5/ubuntu precise main" >> /etc/apt/sources.list && \
    apt-key adv --recv-keys --keyserver keyserver.ubuntu.com e5267a6c && \
    apt-get update

# Install everything needed
RUN dpkg-divert --local --rename /usr/bin/ischroot && ln -sf /bin/true /usr/bin/ischroot && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y upgrade && \
    apt-get -y install apache2 libapache2-mod-php5 php5 php5-cli php5-curl php5-gd php5-imagick php5-sqlite php5-intl php5-mcrypt php5-xdebug wget nano vim curl php5-apcu

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer