# Technical Documentation
authors: Olivier De Vriese & Yordi De Rijcke

## Step 1: Install windows server & required packages
1. Basic Windows Server Installation
    * 50 GB Disk space
    * Windows Server 2016
2. Install the following roles and features
    - ADDS (promote to domain controller)
    - DHCP (enable option 066 and 067)
	    * 066: IP of the server (interface where DHCP will run)
	    * 067: boot\x64\wdsnbp.com
    - Remote Access (NAT routing)
    - DNS
    - Windows Deployment Services
3. Create a DHCP scope for the clients to connect to
4. Setup NAT
Routing and Remote Access tool -> <your server> -> Configure and Enable Routing and Remote Access
	* Select 'NAT'
5. WDS tool -> <your server> -> Configure Server
	* Select 'Respond to all client computers'
6. Install The Microsoft Deployment Tool  
(https://www.microsoft.com/en-us/download/details.aspx?id=54259)
7. Install The Microsft ADK  
(https://support.microsoft.com/nl-be/help/4027209/oems-adk-download-for-windows-10)
    * Follow 'standard wizard'
    
## Step 2: Microsoft Deployment Workbench setup
1. Deployment Workbench -> Deployment Shares -> New Deployment Share

## Step 3: Create an image for the clients
1. Mount the ISO (containing the OS you want to install on the guests)
2. Deployment Workbench -> <newly created deployment share> -> Operating systems -> Import Operating System
	* Source: Mounted ISO location
3. Task Qequences -> New task Sequence
    * Select the preferred OS
    * Choose a password for the administrator
4. Applications -> New Application
    * Source directory: The applications .msi file
    * Command details: ApplicationsName.msi /qb  
5. <newly created deployment share> -> Update Deployment Share

## Step 4: Add image to WDS
1. WDS tool -> <your server> -> Boot Images -> Add Image
	* File location: <deployment share location> -> Boot -> LiteTouchPE_x64.wim
    
## Step 5: Connect a client
1. Add network booting (PXE) to the boot options
2. Power on the computer
3. press F12 as soon as the PXE startup process mentions it
