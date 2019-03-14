#!/bin/bash

## webapp.sh - A script to setup Drupal 8 on a CentOS 7.6 LAMP-stack ##

# Drupal setup
echo 'Drupal: Adding mirrors...'
sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

echo 'Drupal: Installing packages...'
sudo yum -y install php70w php70w-opcache php70w-mbstring php70w-gd php70w-xml php70w-pear php70w-fpm php70w-mysql php70w-pdo gzip

echo 'Drupal: Downloading Drupal...'
wget -c https://ftp.drupal.org/files/projects/drupal-8.6.7.tar.gz

echo 'Drupal: Unpacking Drupal...'
tar -zxf drupal-8.6.7.tar.gz

echo 'Drupal: Placing Drupal into the apache directory...'
sudo mv drupal-8.6.7 /var/www/html/drupal

echo 'Drupal: Copying default settings configuration...'
sudo cp /var/www/html/drupal/sites/default/default.settings.php /var/www/html/drupal/sites/default/settings.php

echo 'Drupal: Giving Apache access'
sudo chown -R apache:apache /var/www/html/drupal

echo 'Drupal: Setting SELinux rule...'
sudo chcon -R -t httpd_sys_content_rw_t /var/www/html/drupal/sites/

exit 0
