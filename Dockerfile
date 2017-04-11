FROM alephp/debian-apache
MAINTAINER Alexandre E Souza <alexandre@indev.net.br>
RUN apt update && apt-get -y install php5 libapache2-mod-php5 curl php5-cli php5-mysql php5-sqlite php5-pgsql nano
RUN mv  /var/www/html /var/www/public
COPY files/index.php /var/www/public/
RUN echo "ServerName DEBIAN" >> /etc/apache2/apache2.conf
RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf
RUN sed -i 's/DocumentRoot "\/var\/www\/html"/DocumentRoot "\/var\/www\/public"/g' /etc/apache2/apache2.conf
#------------------------------
# composer
#______________________________
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/bin/composer


EXPOSE 80 443
RUN a2enmod rewrite
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
