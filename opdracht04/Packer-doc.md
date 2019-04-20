# How to build a base box with Packer
## Prerequisites
* Packer (installed and configured)

Note: Running this in linux is recommended but you could probably make it work with Cygwin or the bash shell in Windows 10


## Makefile
There are 4 entries present to make a basebox for Vagrant with Virtualbox,
2 for Windows 2016 and 2 for Windows 10 with each the option to make the base box with updates preinstalled or not.  
```Bash
make build-windows-2016-no-windows-update-virtualbox

make build-windows-2016-windows-update-virtualbox 

make build-windows-10-no-windows-update-virtualbox 

make build-windows-10-windows-update-virtualbox
```
After the command was executed successfully, you can add the base box to vagrant using:
```Bash
vagrant box add -f <base-box-name> <base-box>.box
```

## Autounattend
The autounattend.xml files were created with [ADK](https://go.microsoft.com/fwlink/?linkid=2086042)

A tutorial on how to make your own autounattend.xml can be found [here](https://www.youtube.com/watch?v=n90Kli9u4CM)


## Packer template
The JSON files found in the windows-2016 and windows-10 folder act as Packer templates

> Templates are JSON files that configure the various components of Packer in order to create one or more machine images. Templates are portable, static, and readable and writable by both humans and computers. This has the added benefit of being able to not only create and modify templates by hand, but also write scripts to dynamically create or modify templates.  
Templates are given to commands such as packer build, which will take the template and actually run the builds within it, producing any resulting machine images.

More on this can be found [here](https://www.packer.io/docs/templates/index.html)

If you want to add a provisioning script that packer uses to create the base box, put the script in `opdracht04\testomgeving\packer\provisioning` and add it to the provisioners in the template file you want to use
```JSON
...
{
    "type": "powershell",
    "script": "provisioning/script.ps1"
},
...
```


