FROM ubuntu:rolling
ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt upgrade -y 
RUN apt install -y php-fpm nginx php-sqlite3 nodejs npm sqlite3 tor

RUN mkdir /base
COPY pomf /base
COPY resources/default /etc/nginx/sites-available/default

RUN mkdir -p /var/db/pomf/
RUN sqlite3 /var/db/pomf/pomf.sq3 -init /base/sqlite_schema.sql

WORKDIR /base
RUN make MODULES="php"
RUN make install DESTDIR="/code"

WORKDIR /code
RUN mkdir /code/files
RUN chown -R www-data:www-data /code
RUN chown -R www-data:www-data /var/db/pomf
RUN echo "HiddenServiceDir /var/lib/tor/hidden_service/" >> /etc/tor/torrc
RUN echo "HiddenServicePort 80 127.0.0.1:80" >> /etc/tor/torrc

COPY run.sh /root/run.sh
RUN chmod +x /root/run.sh

RUN mkdir -p /data/configs
RUN mkdir /pwd
RUN touch /pwd/.htpasswd

CMD "/root/run.sh"