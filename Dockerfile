FROM alephp/debian-apache
MAINTAINER Alexandre E Souza <alexandre@indev.net.br>
RUN apt-get install -y wget nano
RUN echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list
RUN echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list
RUN wget https://www.dotdeb.org/dotdeb.gpg
RUN apt-key add dotdeb.gpg
RUN rm dotdeb.gpg
RUN apt-get update
RUN apt-get install -y php7.0 php7.0-mysql php7.0-sqlite
RUN mv  /var/www/html /var/www/public
COPY files/index.php /var/www/public/
RUN rm /var/www/public/index.html
RUN echo "ServerName DEBIAN" >> /etc/apache2/apache2.conf
RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf
RUN sed -i 's/DocumentRoot "\/var\/www\/html"/DocumentRoot "\/var\/www\/public"/g' /etc/httpd/conf/httpd.conf

#------------------------------
# composer
#______________________________
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/bin/composer



EXPOSE 80 443
RUN a2enmod rewrite
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
