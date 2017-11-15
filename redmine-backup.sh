#!/bin/bash
# This script back up KWT redmine installation (database + files)

# DB setting (Note : Don't commit credentials)
DB_USERNAME='root'
DB_PASSWORD='XXX'
DB_NAME='redmine'

# Directories 
REDMINE_ROOT='/opt/redmine/redmine-3.4.3'
BACKUP_ROOT='/home/seri/redmine-backup'

# backup file name
date=$(date +"%d-%b-%Y")
FILENAME='redmine-'$date'.tar.gz'

echo 'Setting up directories'
mkdir $BACKUP_ROOT/db -p
mkdir $BACKUP_ROOT/files -p

echo 'Backing up database'
mysqldump -u $DB_USERNAME --password=$DB_PASSWORD $DB_NAME > $BACKUP_ROOT/db/$date.sql

echo 'Backing up file attachments'
cp -rf $REDMINE_ROOT/files $BACKUP_ROOT

echo 'Packing evrything into single archive :' $FILENAME
tar -cvzf $FILENAME $BACKUP_ROOT

# upload backup files to dropbox storage
echo 'uploading backup files to dropbox storage'
upload-redmine-backup.sh $FILENAME


echo 'Backup complete. Cleaning up...'
cd $BACKUP_ROOT
rm -rf db
rm -rf files

# remove old backups older than 2 weeks
find *.tar.gz -mtime +15 -exec rm {} \;

echo 'DONE'
