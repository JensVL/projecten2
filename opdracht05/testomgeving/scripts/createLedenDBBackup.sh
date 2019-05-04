#!/bin/bash

### createLedenDBBackup.sh - A script to create a backup from the "Leden Database" ###

## Check root access ##
if [ $UID -ne 0 ]; then
  echo 'You need to have root access to create a LedenDB backup!'
  echo ''
  exit 1
fi

## Read credentials ##
read -p 'Enter the DB username: ' DBUsername
read -p 'Enter the DB password: ' DBPassword

## Check if directory exists ##
if [ ! -d /backupServer_Sync/ledenDB_Backups/ ]; then
  echo 'Creating the backup directory...'
  echo ''
  
  mkdir -p /backupServer_Sync/ledenDB_Backups/

  if [ $? -ne 0 ]; then
    echo 'Creating the backup directory failed. Script wil exit.'
    echo ''
    exit 1
  fi
fi

## Create a timestamp to use in the backup filename ##
timestamp="$(date +'%d-%m-%Y_%H:%M:%S')"

## Create the backup file ##
echo 'Creating the backup file...'
mysqldump -u "$DBUsername" -p"$DBPassword" LedenDB > "/backupServer_Sync/ledenDB_Backups/${timestamp}.sql"

## Sync the newly created backup to the backupserver ##
echo 'Syncing the newly created backup to the backupserver...'
rsync -a /backups/LedenDB/ 192.168.248.12:/applicatieserver_backups/LedenDB

exit 0
