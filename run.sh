chown debian-tor:debian-tor -R /var/lib/tor

service php7.3-fpm start
service nginx start
service tor start

cp /var/lib/tor/hidden_service/hostname /code/
chown www-data:www-data -R /code

tail -f /dev/null