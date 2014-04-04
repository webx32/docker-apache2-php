FROM rootlogin/ubuntu-base:12.04
MAINTAINER Simon Erhardt <me@rootlogin.ch>

# Change sources.list and update packages
RUN echo "deb http://ppa.launchpad.net/ondrej/php5/ubuntu precise main" >> /etc/apt/sources.list && \
    apt-key adv --recv-keys --keyserver keyserver.ubuntu.com e5267a6c && \
    apt-get update

# Install everything needed
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y upgrade && \
    apt-get -y install apache2 libapache2-mod-php5 php5 php5-cli php5-curl php5-gd php5-imagick php5-sqlite php5-intl php5-mcrypt php5-xdebug php5-apcu

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add source and application directory
ADD src /src

# Run the installer
RUN /src/installer.sh
VOLUME ["/var/www"]

# Set environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV LANG C

# Make port 80 accessible
EXPOSE 80

# Let's run the apache
ENTRYPOINT ["/usr/sbin/apache2"]
CMD ["-D", "FOREGROUND"]