#!/bin/bash
#This script is used for backing up Owncloud v10.0.1 database, config files and data files.

echo "Preparing to backup database";
mysqldump --lock-tables -h localhost -u root -p owncloud > /media/pi/USB30FD/oc-dbbackups/owncloud-dbbackup_`date +"%Y%m%d"`.bak
if [ $? -ne 0 ]; then
echo " "
else
echo "Finished backing up database";

echo "Backing up config files";
sudo cp -r /var/www/owncloud/config /media/pi/USB30FD/oc-dirbackups/
mv /media/pi/USB30FD/oc-dirbackups/config /media/pi/USB30FD/oc-dirbackups/config_`date +"%Y%m%d"`
echo "Finished backing up config files";

echo "Backing up data files";
sudo cp -r /media/ownclouddrive/ /media/pi/USB30FD/oc-filebackups/ownclouddrive_`date +"%Y%m%d"`
echo "Finished backing up data files";
fi