FROM alephp/debian-apache
MAINTAINER Alexandre E Souza <alexandre@indev.net.br>
RUN apt-get update
RUN apt-get install -y wget nano curl git
RUN echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list
RUN echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list
RUN wget https://www.dotdeb.org/dotdeb.gpg
RUN apt-key add dotdeb.gpg
RUN rm dotdeb.gpg
RUN apt-get update
RUN apt-get install -y php7.0 libapache2-mod-php7.0 php7.0-fpm php7.0-common php7.0-cli php7.0-zip \
 php-pear php7.0-curl php7.0-gd php7.0-gmp php7.0-intl php7.0-imap php7.0-json php7.0-ldap \
 php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-ps php7.0-readline \
 php7.0-tidy php7.0-xmlrpc php7.0-xsl

RUN rm -rf  /var/www/html
RUN mkdir /var/www/public 
RUN echo "ServerName DEBIAN" >> /etc/apache2/apache2.conf
RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf
RUN rm /etc/apache2/sites-enabled/000-default.conf
COPY files/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY files/index.php  /var/www/public
#------------------------------
# composer
#______________________________
RUN curl -sS https://getcomposer.org/installer |  php -- --install-dir=/usr/local/bin --filename=composer

EXPOSE 80 443
RUN a2enmod rewrite
RUN service apache2 restart
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
