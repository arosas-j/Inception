FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y nginx openssl

EXPOSE 443

COPY ./conf/default.conf /etc/nginx/sites-enabled/default.conf
COPY ./tools/nginx_script.sh /var/www

RUN chmod +x /var/www/nginx_script.sh

ENTRYPOINT [ "/var/www/nginx_script.sh" ]

CMD ["nginx", "-g", "daemon off;"]