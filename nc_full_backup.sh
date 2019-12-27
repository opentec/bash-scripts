#!/bin/bash
#This script is used perform a Full Back Up of Nextcloud database, config files and data files.

#Target backup directory
_destdir="/media/usb"

echo "Preparing to backup database"
sudo mysqldump --lock-tables -h localhost -u root -p nextcloud > "$_destdir"/nc-dbbackups/nextcloud-dbbackup_`date +"%Y%m%d"`.bak
if [ $? -ne 0 ]; then
echo " "
else
echo "Finished backing up database"

echo "Backing up config files"
sudo rsync -av --progress /var/www/html/nextcloud/config "$_destdir"/nc-configbackups/config_`date +"%Y%m%d"`
echo "Finished backing up config files"

echo "Backing up data files"
sudo rsync -av --progress /media/nextcloud/ "$_destdir"/nc-filebackups/nextcloud_`date +"%Y%m%d"` --exclude updater-*
echo "Finished backing up data files"
fi
