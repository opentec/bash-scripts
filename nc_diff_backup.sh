#!/bin/bash
#This script is used to perform a Differential Backup of Nextcloud database,
#config files and data files. This means a backup of all changed and new
#files since the last Full Backup.

#Destination directory (backup)
_destdir="/media/usb"

echo "Preparing to backup database"
sudo mysqldump --lock-tables -h localhost -u root -p nextcloud > "$_destdir"/nc-dbbackups/db-diff-backup.bak
if [ $? -ne 0 ]; then
echo " "
else
echo "Finished backing up database"

echo "Backing up config files"
sudo rsync -av --progress --delete /var/www/html/nextcloud/config "$_destdir"/nc-configbackups/config-diff-backup
echo "Finished backing up config files"

echo "Backing up data files"
sudo rsync -av --progress --delete --exclude=updater-* /media/nextcloud/ "$_destdir"/nc-filebackups/data-diff-backup
echo "Finished backing up data files"
fi

