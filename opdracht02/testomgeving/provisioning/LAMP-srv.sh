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

#------------------------------------------------------------------------------
# Provision server
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Interpret parameters
#------------------------------------------------------------------------------
if [ $# != 12 ]; then
  echo 'Incorrect amount of parameters specified!'
  exit 1
fi

while [ $# -gt 0 ]; do
  case "$1" in
    -linuxRootPassword)
      linuxRootPassword="$2";;

    -linuxVagrantPassword)
      linuxVagrantPassword="$2";;

    -mariaDBRootPassword)
      mariaDBRootPassword="$2";;

    -mariaDBName)
      mariaDBName="$2";;

    -mariaDBUserName)
      mariaDBUserName="$2";;

    -mariaDBPassword)
      mariaDBPassword="$2";;

    *)
      echo 'Incorrect parameter specified!'
      exit 1;;
  esac

  shift && shift
done

info "Starting server specific provisioning tasks on ${HOSTNAME}"

# Install apache, mariaDB, php, Drupal
sudo yum install -y httpd mariadb-server php

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
echo -e "${linuxRootPassword}\n${linuxRootPassword}" | sudo passwd root
echo -e "${linuxVagrantPassword}\n${linuxVagrantPassword}" | sudo passwd vagrant

# MariaDB setup
## User setup
sudo mysqladmin -u root $mariaDBRootPassword
mysql -u root -p$mariaDBRootPassword -e "DROP USER ''@'localhost';"
mysql -u root -p$mariaDBRootPassword -e "DROP USER ''@'$(hostname)';"

## Vagrant DB setup
mysql -e "CREATE DATABASE ${mariaDBName} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
mysql -e "CREATE USER ${mariaDBUserName}@localhost IDENTIFIED BY '${mariaDBPassword}';"
mysql -e "GRANT ALL PRIVILEGES ON ${mariaDBName}.* TO '${mariaDBName}'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

mysql restart

# Call the web application setup
./webapp.sh

exit 0
