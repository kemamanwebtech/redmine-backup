# required settings
DB_USERNAME='###'
DB_PASSWORD='###'
DB_NAME='###'
REDMINE_ROOT='/opt/redmine/'
BACKUP_ROOT='/home/seri/redmine-backup'

date=$(date +"%d-%b-%Y")

GS_FILENAME='redmine-$date.tar.gz'

echo 'Setting up directories'
mkdir $BACKUP_ROOT/redmine/db -p
mkdir $BACKUP_ROOT/redmine/files -p

echo 'Backing up database'
/usr/bin/mysqldump -u $DB_USERNAME --password=$DB_PASSWORD $DB_NAME | gzip > $BA$

echo 'Backing up attachments'
rsync -a $REDMINE_ROOT/files/ $BACKUP_ROOT/redmine-3.4.3/files/

echo 'Packing into single archive'
tar -czPf $GS_FILENAME $BACKUP_ROOT/redmine-3.4.3/

echo 'Backup complete'
