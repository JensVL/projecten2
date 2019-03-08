# Creation Vagrant Base box

## Installation Vagrant.

1. Go to the website https://www.vagrantup.com/downloads.html and download the appropriate version.

2. Install Vagrant.

---

##  Basebox creation

1. Open command prompt on host PC.

2. Navigate to desired location in the directory.

3. Type in the command: `vagrant package --base *name of virtual machine*`

4. To check if your basebox is created, you need to naviagte to that same directory. If all was successfull there should be a file called `package.box` in the same directory.

5. Don't close the command prompt you need it to persue the following steps.

---

### Adding basebox 

1. In the same command prompt use the command `vagrant box add --name *name of VM* *path to .box file*`

2. Don't close the command prompt you need it to persue the following steps.

---

### Initializing box

1. In the same command prompt use the command `vagrant init *name basebox*`

2. Don't close the command prompt you need it to persue the following steps.

---

### Startup box

1. In the same command prompt use the command `vagrant up`. You don't need to specialize a basebox because you already have initialized it.

2. If everything went correct the base box should start up.

3. Don't close the command prompt you need it to persue the following steps.

---

### Remote desktop connection

1. In the same command prompt use the command `vagrant rdp` to log into the base box.

2. Use password "vagrant" (without quotes) to gain access to the basebox.

3. Now you should be able to use the basebox.