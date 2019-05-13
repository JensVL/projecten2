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
yum -y update &> /dev/null
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

# Create backup directory
info 'Creating backup directory...'
mkdir -p /backups/LedenDB &> /dev/null
chown -R vagrant /backups &> /dev/null

# Create lesmateriaal directory
info 'Creating lesmateriaal directory...'
mkdir -p /var/www/lesmateriaal/{wit,geel,oranje,groen,blauw,bruin,zwart} &> /dev/null
chmod -R 777 /var/www/lesmateriaal &> /dev/null

# Copy createLedenDBBackup.sh to /bin
cp /vagrant/scripts/createLedenDBBackup.sh /bin
chmod 755 /bin/createLedenDBBackup.sh

# Install .NET Core dependecies
info 'Downloading yum repo...'
wget -P /etc/yum.repos.d/ https://packages.efficios.com/repo.files/EfficiOS-RHEL7-x86-64.repo &> /dev/null
info 'Importing microsoft package...'
rpmkeys --import https://packages.efficios.com/rhel/repo.key &> /dev/null
info 'Syncing yum repos...'
yum updateinfo &> /dev/null
info 'Installing .NET Core dependecies...'
yum -y install lttng-ust libcurl openssl-libs krb5-libs libicu zlib libunwind libuuid &> /dev/null

# Install .NET Core
info 'Importing microsoft package...'
rpm --import https://packages.microsoft.com/keys/microsoft.asc &> /dev/null
info 'Adding microsoft yum repo...'
sh -c 'echo -e "[packages-microsoft-com-prod]\nname=packages-microsoft-com-prod \nbaseurl=https://packages.microsoft.com/yumrepos/microsoft-rhel7.3-prod\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/dotnetdev.repo' &> /dev/null
info 'Syncing yum repos...'
yum -y update &> /dev/null
info 'Installing .NET Core...'
yum -y install libunwind libicu dotnet-sdk-2.1 &> /dev/null

# Copy .NET web application
info '.NET Demo app kopiëren...'
cp -R /vagrant/dotnet-g12/* /var/www/
chown -R vagrant /var/www

# Start .NET web application
info '.NET Demo app runnen...'
runuser -l vagrant -c 'cd /var/www/Taijitan_Yoshin_Ryu_vzw && dotnet run' &> /dev/null

exit 0
