#!/bin/bash

### createLedenDBBackup.sh - A script to create a backup from the "Leden Database" ###

## Read credentials ##
read -p 'Enter the DB username: ' DBUsername
read -p 'Enter the DB password: ' DBPassword

## Check if directory exists ##
if [ ! -d /backups/LedenDB ]; then
  echo 'Creating the backup directory...'
  echo ''
  
  sudo mkdir -p /backups/LedenDB
  sudo chown -R $USER /backups

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
mysqldump -u "$DBUsername" -p"$DBPassword" LedenDB > "/backups/LedenDB/${timestamp}.sql"

## Sync the newly created backup to the backupserver ##
echo 'Syncing the newly created backup to the backupserver...'
rsync -a /backups/LedenDB/ 192.168.248.12:/applicatieserver_backups/LedenDB

exit 0
