# Technical Documentation
authors: Olivier De Vriese & Yordi De Rijcke

## Step 1: Install windows server (Desktop Experience)

1. Basic Windows Server Installation
    - 50 GB Disk space
    - Windows Server 2016
2. Install the following roles and features
    - ADDS (promote to domain controller)
    - DHCP (enable option 066 and 067)
        - 66: 
        - 67: boot\x64\wdsnbp.com
    - Remote Access (Configure for Nat router)
    - DNS
    - WDS

## Step 2: WDS (configuring)
1. Go to WDS in the Tools section
2. RMB on your server and press configure server
3. Choose integrated with active directory
4. Select respond to all client computers

## Step 3: Microsoft Deployment Toolkit
### Install
1. Install The Microsoft Deploypment Tool  
(https://www.microsoft.com/en-us/download/details.aspx?id=54259)
2. Install The Microsft ADK  
(https://support.microsoft.com/nl-be/help/4027209/oems-adk-download-for-windows-10)
3. follow the standard wizard
### Creating image for clients (in MDK)
1. Go to Operating systems
2. Import Operating system
3. Follow the wizard
    - Source directory: Select the location of the mounted ISO
4. Go to Task Sequences
5. New task Sequence
    - Select the preferred OS
    - Choose a password for the administrator
6. Go to applications
7. New Application
    - Source directory: The applications .msi file
    - Command details: ApplicationsName.msi /qb  

## Step 4: WDS (adding image)


 