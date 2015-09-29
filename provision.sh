#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='root'
PROJECTFOLDER='web'

echo -e "\n---Setting Up Project Folder: /var/www/$PROJECTFOLDER---\n"
sudo mkdir -p "/var/www/$PROJECTFOLDER"

echo -e "\n---Update / Upgrade---\n"
sudo apt-get -y update
sudo apt-get -y upgrade

echo -e "\n---Installing Apache & PHP 5.5---\n"
sudo apt-get install -y apache2
sudo apt-get install -y php5

echo -e "\n---Installing MySQL---\n"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt-get -y install mysql-server libapache2-mod-auth-mysql php5-mysql

echo -e "\n---Installing PHP Dependencies---\n"
sudo apt-get -y install libapache2-mod-php5 php5-curl php5-gd php5-mcrypt php5-mysql git-core
sudo apt-get update

echo -e "\n-- Installing PHPMyAdmin: $PASSWORD/$PASSWORD---\n"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo apt-get -y install phpmyadmin

echo -e "\n---Setting Up vHost---\n"
VHOST=$(cat <<EOF
<VirtualHost *:80>
    DocumentRoot "/var/www/$PROJECTFOLDER"
    <Directory "/var/www/$PROJECTFOLDER">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

echo -e "\n---Enabling mod_rewrite---\n"
sudo a2enmod rewrite
sudo php5enmod mcrypt

echo -e "\n---Turning on errors---\n"
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

echo -e "\n---Restarting Apache---\n"
sudo service apache2 restart

sudo apt-get update
sudo apt-get install -y python-software-properties python g++ make
sudo apt-get update

echo -e "\n---Installing Ruby 2.2.3---\n"
sudo apt-get update
curl -sSL https://get.rvm.io | bash
echo "source /etc/profile.d/rvm.sh" >> .bashrc
source /etc/profile.d/rvm.sh
# sudo apt-get install -y ruby1.9.1-dev
# sudo apt-get install -y ruby2.2.3-dev
rvm install 1.9.3-dev
rvm install 2.2.3-dev
rvm use 2.2.3

# echo "-----------------------"
# echo "--- Installing Gems ---"
# echo "-----------------------"
# sudo apt-get update
# dont use sudo when working with RVM gems
# gem install wordmove

echo "\n---Installing Git---\n"
sudo apt-get update
sudo apt-get -y install git

echo "\n---Installing Node---\n"
sudo apt-get update
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y nodejs

# installed on Ubuntu by default - remove*
# echo "--------------------------"
# echo "--- Installing RSync ---"
# echo "--------------------------"
# sudo apt-get install -y rsync

echo -e "\n---Installing Composer---\n"
curl -s https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

echo -e "---Installing WP-ClI---"
curl -s https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# mysqldump --user=root -proot scotchbox > /var/www/$PROJECTFOLDER/db/mysqldump_$(date +%Y-%m-%d-%H.%M.%S).sql
# OPTIONAL: uncomment to dump mysql every 10 minutes
# echo "*/2 * * * * mysqldump --user=root -proot scotchbox > /var/www/$PROJECTFOLDER/db/mysqldump_$(date +%Y-%m-%d-%H.%M.%S).sql" | crontab
# backup: # mysqldump -u root -p[root_password] [database_name] > dumpfilename.sql
# restore:# mysql -u root -p[root_password] [database_name] < dumpfilename.sql

echo "---Provisioning Complete---"
echo "Type 'vagrant ssh && cd /var' to log into the machine."
