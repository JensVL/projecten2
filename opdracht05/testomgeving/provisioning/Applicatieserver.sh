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
yum update -y
yum install -y httpd mariadb-server rsync

# Enable firewall & disable ports for apache
info 'Changing firewall settings...'
systemctl enable firewalld
systemctl start firewalld
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp
firewall-cmd --reload

# Make sure that the daemons start at boot
info 'Enabling services...'
systemctl enable httpd
systemctl enable mariadb

# Make sure that the daemons are started right now
info 'Restarting services...'
systemctl restart httpd
systemctl restart mariadb

# Linux users setup
info 'Changing linux user passwords...'
echo -e "${linuxRootPassword}\n${linuxRootPassword}" | passwd root
echo -e "${linuxVagrantPassword}\n${linuxVagrantPassword}" | passwd vagrant

# MariaDB setup
info 'Changing MySQL root password'
mysqladmin -u root password "$mariaDBRootPassword"

info 'Deleting default MySQL databases & users...'
mysql -u root -p$mariaDBRootPassword -e "DELETE FROM mysql.user WHERE User=''; DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1'); DROP DATABASE IF EXISTS test; FLUSH PRIVILEGES;"

# Vagrant DB setup
info 'Creating MySQL database for the web application...'
mysql -u root -p$mariaDBRootPassword -e "CREATE DATABASE ${mariaDBName} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
mysql -u root -p$mariaDBRootPassword -e "CREATE USER ${mariaDBUserName}@localhost IDENTIFIED BY '${mariaDBPassword}';"
mysql -u root -p$mariaDBRootPassword -e "GRANT ALL PRIVILEGES ON ${mariaDBName}.* TO '${mariaDBUserName}'@'localhost';"
mysql -u root -p$mariaDBRootPassword -e "FLUSH PRIVILEGES;"

# Create backup directory
info 'Creating backup directory...'
mkdir -p /backups/LedenDB
chown -R vagrant /backups

# Create lesmateriaal directory
info 'Creating lesmateriaal directory...'
mkdir -p /var/www/lesmateriaal/{wit,geel,oranje,groen,blauw,bruin,zwart}
chmod -R 777 /var/www/lesmateriaal

# Install .NET Core dependecies
info 'Installing .NET Core dependecies...'
wget -P /etc/yum.repos.d/ https://packages.efficios.com/repo.files/EfficiOS-RHEL7-x86-64.repo
rpmkeys --import https://packages.efficios.com/rhel/repo.key
yum updateinfo
yum -y install lttng-ust libcurl openssl-libs krb5-libs libicu zlib libunwind libuuid

# Install .NET Core
info 'Installing .NET Core...'
info 'importing'
rpm --import https://packages.microsoft.com/keys/microsoft.asc
info 'add package'
sh -c 'echo -e "[packages-microsoft-com-prod]\nname=packages-microsoft-com-prod \nbaseurl=https://packages.microsoft.com/yumrepos/microsoft-rhel7.3-prod\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/dotnetdev.repo'
info 'update'
yum update -y
info 'install'
yum install -y libunwind libicu dotnet-sdk-2.1

exit 0
