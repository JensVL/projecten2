#!/bin/bash

### syncLesmateriaal.sh - A script that syncs lesmateriaal from the backupserver to the applicatieserver ###

## Check parameter amount ##
if [ $# -eq 0 ]; then
  echo 'At least one file is needed.'
  echo 'Example usage: syncLesmateriaal.sh oranje/file1.txt'
  echo 'This will sync file /lesmateriaal/oranje/file1.txt to Applicatieserver:/var/www/lesmateriaal/oranje/file1.txt'
  exit 1
fi

## Interpret parameter(s) ##
while [ $# -gt 0 ]; do
  # $1 is the file path to sync #
    
  # Check parameter existance #
  if [ ! -f "/lesmateriaal/$1" ]; then
    echo "File '/lesmateriaal/$1' doesn't exist. Skipping this file..."
    echo 'Example usage: syncLesmateriaal.sh oranje/file1.txt'
    echo 'This will sync file /lesmateriaal/oranje/file1.txt to Applicatieserver:/var/www/lesmateriaal/oranje/file1.txt'
    shift;
    continue;
  fi

  # Sync file to the applicatieserver #
  echo "Syncing file '/lesmateriaal/$1' to the applicatieserver..."
  rsync -a "/lesmateriaal/$1" 192.168.248.11:/var/www/lesmateriaal/$1

  echo "/lesmateriaal/$1 synced."
  shift;
done;

## Changing Applicatierserver:lesmateriaal permissions ##
ssh 192.168.248.11 'sudo chmod -R 777 /var/www/lesmateriaal'

exit 0
