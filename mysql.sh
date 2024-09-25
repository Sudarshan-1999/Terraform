#!/bin/bash

# Check if script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 
   sudo su -
fi

# Prompt for MySQL root password, new database name, and user credentials
root_pass="Password@1234"
db_name="wordpress"
db_user="wordpress_user"
db_user_pass="Password@1234"
echo "Install MySQL server"
# Install MySQL server
echo "Installing MySQL server..."
apt-get update -y
apt-get install -y mysql-server

# Start and enable MySQL service
echo "Starting and enabling MySQL service..."
systemctl start mysql
systemctl enable mysql

# Allow MySQL remote access
echo "Configuring MySQL for remote access..."
sed -i "s/bind-address\s*=.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

# Apply changes by restarting MySQL service
systemctl restart mysql

# Secure MySQL installation
echo "Securing MySQL installation..."
mysql --user=root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY '${root_pass}';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
FLUSH PRIVILEGES;
EOF

# Create a new database and user
echo "Creating new database and user..."
mysql --user=root --password="${root_pass}" <<EOF
CREATE DATABASE ${db_name};
CREATE USER '${db_user}'@'%' IDENTIFIED BY '${db_user_pass}';
GRANT ALL PRIVILEGES ON ${db_name}.* TO '${db_user}'@'%';
FLUSH PRIVILEGES;
EOF

# Restart MySQL to apply changes
echo "Restarting MySQL service..."
systemctl restart mysql

echo "MySQL setup completed successfully. You can now connect remotely to the database."

