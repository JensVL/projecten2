#! /bin/bash
#
# Provisioning script for LAMP-srv

#------------------------------------------------------------------------------
# Bash settings
#------------------------------------------------------------------------------

# abort on nonzero exitstatus
set -o errexit
# abort on unbound variable
set -o nounset
# don't mask errors in piped commands
set -o pipefail

#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------

# Location of provisioning scripts and files
export readonly PROVISIONING_SCRIPTS="/vagrant/provisioning"
# Location of files to be copied to this server
export readonly PROVISIONING_FILES="${PROVISIONING_SCRIPTS}/files/${HOSTNAME}"

#------------------------------------------------------------------------------
# "Imports"
#------------------------------------------------------------------------------

# Utility functions
source ${PROVISIONING_SCRIPTS}/util.sh
# Actions/settings common to all servers
source ${PROVISIONING_SCRIPTS}/common.sh
# Password input
source ${PROVISIONING_SCRIPTS}/.${HOSTNAME}.conf
rm ${PROVISIONING_SCRIPTS}/.${HOSTNAME}.conf
#------------------------------------------------------------------------------
# Provision server
#------------------------------------------------------------------------------

info "Starting server specific provisioning tasks on ${HOSTNAME}"

# Update mirrors for intstall
sudo dnf update -y

# Install apache, mariaDB, php
sudo dnf install -y httpd mariadb-server php

# Enable firewall & disable ports for apache
sudo systemctl enable firewalld
sudo systemctl start firewalld
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --permanent --add-port=443/tcp
sudo firewall-cmd --reload

# Make sure that the daemons start at boot
sudo systemctl enable httpd
sudo systemctl enable mariadb

# Make sure that the daemons are started right now
sudo systemctl restart httpd
sudo systemctl restart mariadb

# Linux users setup
echo -e "${linuxRootPasswd}\n${linuxRootPasswd}" | sudo passwd root
echo -e "${linuxVagrantPasswd}\n${linuxVagrantPasswd}" | sudo passwd vagrant

# MariaDB setup
sudo mysqladmin -u root $mysqlPasswd
mysql -u root -p$mysqlPasswd -e "DROP USER ''@'localhost';"
mysql -u root -p$mysqlPasswd -e "DROP USER ''@'$(hostname)';"

mysql restart

