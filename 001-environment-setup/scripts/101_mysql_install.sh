#!/usr/bin/env bash

export DEBIAN_FRONTEND="noninteractive"

apt-get update
apt-get install -y mysql-server

systemctl daemon-reload
systemctl status mysql.service
systemctl enable mysql

# Set up Mysql bind-address
MYSQL_CONFIG_FILE="/etc/mysql/mysql.conf.d/mysqld.cnf"

echo "Modifying bind-address in MySQL configuration..."
sudo sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' "$MYSQL_CONFIG_FILE"

echo "Restarting MySQL service..."
systemctl restart mysql

# Set up MySQL Password
MYSQL_ROOT_PASSWORD="demomysql"
echo "Setting MySQL root password and enabling remote access..."
mysql -h localhost -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY '$MYSQL_ROOT_PASSWORD';"
mysql -h localhost -u root -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
mysql -h localhost -u root -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

MYSQL_SUPERUSER_NAME="superuser"
MYSQL_SUPERUSER_PASS="superuser1234"
echo "Setting MySQL Superuser password and enabling remote access..."
mysql -h localhost -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER '${MYSQL_SUPERUSER_NAME}'@'%' IDENTIFIED BY '${MYSQL_SUPERUSER_PASS}';"
mysql -h localhost -u root -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_SUPERUSER_NAME}'@'%' WITH GRANT OPTION;"

echo "MySQL installation and configuration completed successfully."
