FROM alephp/debian-apache
MAINTAINER Alexandre E Souza <alexandre@indev.net.br>
RUN apt update && apt-get -y install php5 libapache2-mod-php5 curl php5-cli php5-mysql php5-sqlite php5-pgsql nano
COPY files/index.php /var/www/html/
RUN rm /var/www/html/index.html
RUN echo "ServerName DEBIAN" >> /etc/apache2/apache2.conf
RUN sed 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf
EXPOSE 80
