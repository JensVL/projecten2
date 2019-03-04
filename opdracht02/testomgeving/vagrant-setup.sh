## vagrant-setup.sh - A script to setup a Fedora 29 vagrant box on a Debian 9 Host OS
## Variable definition
declare password
declare passwordConfirm
declare -r baseDir=$(dirname "$0")

## Functions
enterPassword() {
  do
    read -s "$1" password
    read -s "Confirm the password: " passwordConfirm
  while  [ "$password" != "$passwordConfirm" ];
}

## Main
# Install virtualbox & vagrant
sudo apt-add-repository 'deb http://download.virtualbox.org/virtualbox/debian stretch contrib'
sudo bash -c 'echo deb https://vagrant-deb.linestarve.com/ any main > /etc/apt/sources.list.d/wolfgang42-vagrant.list'
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key AD319E0F7CFFA38B4D9F6E55CE3F3DE92099F7A4
sudo apt-get update
sudo apt-get -y install virtualbox vagrant git

# Create directories
cd
git clone https://github.com/bertvv/vagrant-shell-skeleton.git
mkdir vagrant
mv vagrant-shell-skeleton vagrant/fedora
cd vagrant/fedora

# Install the box
echo "----- Select virtualbox as provider. -----"
vagrant box add bento/fedora-29

# Enter password for the linux root user
enterPassword "Enter a password for the linux root user: "
echo "linuxRootPasswd=$password" > "${baseDir}/.fedora-vm.conf"

# Enter password for the linux vagrant user
enterPassword "Enter a password for the linux vagrant user: "
echo "linuxVagrantPasswd=$password" >> "${baseDir}/.fedora-vm.conf"

# Enter password for the mysql root user
enterPassword "Enter a password for the mysql root user: "
echo "mysqlRootPasswd=$password" >> "${baseDir}/.fedora-vm.conf"

# Start the VM
vagrant up
