FROM debian:bullseye

RUN apt-get update && \
	apt-get install -y \
	mariadb-server

COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

COPY ./tools/init_db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_db.sh

RUN mysql_install_db

ENTRYPOINT [ "/usr/local/bin/init_db.sh" ]