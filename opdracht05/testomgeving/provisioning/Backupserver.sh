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
  info 'Provisioning: Incorrect amount of parameters specified!'
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
      echo 'Provisioning: Incorrect parameter specified!'
      exit 1;;
  esac

  shift && shift
done

info "Starting server specific provisioning tasks on ${HOSTNAME}"

# Install LAMP server packages
info 'Installing packages...'
yum update -y > /dev/0
yum -y install httpd mariadb-server rsync &> /dev/null

# Enable firewall & disable ports for apache
info 'Changing firewall settings...'
systemctl enable firewalld &> /dev/null
systemctl start firewalld &> /dev/null
firewall-cmd --permanent --add-port=80/tcp &> /dev/null
firewall-cmd --permanent --add-port=443/tcp &> /dev/null
firewall-cmd --reload &> /dev/null

# Make sure that the daemons start at boot
info 'Enabling services...'
systemctl enable httpd &> /dev/null
systemctl enable mariadb &> /dev/null

# Make sure that the daemons are started right now
info 'Restarting services...'
systemctl restart httpd &> /dev/null
systemctl restart mariadb &> /dev/null

# Linux users setup
info 'Changing linux user passwords...'
echo -e "${linuxRootPassword}\n${linuxRootPassword}" | passwd root &> /dev/null
echo -e "${linuxVagrantPassword}\n${linuxVagrantPassword}" | passwd vagrant &> /dev/null

# MariaDB setup
info 'Changing MySQL root password'
mysqladmin -u root password "$mariaDBRootPassword" &> /dev/null

info 'Deleting default MySQL databases & users...'
mysql -u root -p$mariaDBRootPassword -e "DELETE FROM mysql.user WHERE User=''; DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1'); DROP DATABASE IF EXISTS test; FLUSH PRIVILEGES;" &> /dev/null

# Vagrant DB setup
info 'Creating MySQL database for the web application...'
mysql -u root -p$mariaDBRootPassword -e "CREATE DATABASE ${mariaDBName} /*\!40100 DEFAULT CHARACTER SET utf8 */;" &> /dev/null
mysql -u root -p$mariaDBRootPassword -e "CREATE USER ${mariaDBUserName}@localhost IDENTIFIED BY '${mariaDBPassword}';" &> /dev/null
mysql -u root -p$mariaDBRootPassword -e "GRANT ALL PRIVILEGES ON ${mariaDBName}.* TO '${mariaDBUserName}'@'localhost';" &> /dev/null
mysql -u root -p$mariaDBRootPassword -e "FLUSH PRIVILEGES;" &> /dev/null

# Create Applicatieserver backup directory
info 'Creating applicatieserver backup directory...'
mkdir -p /applicatieserver_backups/LedenDB/
chown -R vagrant /applicatieserver_backups

# Create lesmateriaal directory
info 'Creating lesmateriaal directory...'
mkdir -p /lesmateriaal/{wit,geel,oranje,groen,blauw,bruin,zwart}
chown -R vagrant /lesmateriaal

exit 0