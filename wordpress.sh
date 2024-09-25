#!/bin/bash
docroot="/var/www/html/wordpress"
docindex="index.php"
config_file="/etc/apache2/sites-available/wordpress.conf"
linked_file="/etc/apache2/sites-enabled/wordpress.conf"
domain=$(curl ifconfig.me)

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 
   sudo su -
fi

apt update -y 
apt install ca-certificates apt-transport-https software-properties-common -y
echo "yes" | add-apt-repository ppa:ondrej/php
apt install apache2 -y
apt install --no-install-recommends php8.1 -y
sudo apt install php8.1 php8.1-cli php8.1-common php8.1-mysql \
     php8.1-zip php8.1-gd php8.1-mbstring php8.1-curl  \
     php8.1-xml php8.1-bcmath libapache2-mod-php php8.1-mcrypt \
     php8.1-fpm unzip -y

curl -O  https://wordpress.org/latest.zip 
unzip latest.zip -d /var/www/html/
cat > "$config_file" <<EOL
<VirtualHost *:80>
    ServerAdmin webmaster@localhsot
    ServerName $domain
    ServerAlias www.$domain
    DocumentRoot $docroot
    DocumentIndex $docindex
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOL

rm -rf /etc/apache2/sites-enabled/*
ln -s $config_file $linked_file
chown www-data: -R /var/www/html
systemctl restart apache2