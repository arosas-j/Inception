#!/bin/bash

MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_PASSWORD=$(cat /run/secrets/db_password)

# Initialize the MariaDB data directory
mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Start the MariaDB server
mysqld_safe --datadir=/var/lib/mysql &

# Wait for the MariaDB server to start
sleep 5

# Create a new database and user
if [ ! -d /var/lib/mysql/${MYSQL_DATABASE} ];
then
	mysql -u ${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE $MYSQL_DATABASE;"
	mysql -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'"
	mysql -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;"
	mysql -e "FLUSH PRIVILEGES;"
	mysql -e "ALTER USER '${MYSQL_ROOT_USER}'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
fi

# Keep the container running
wait