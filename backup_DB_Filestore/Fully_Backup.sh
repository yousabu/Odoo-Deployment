#To stop Odoo service

sudo service odoo stop

#!/bin/bash

# Location of the backup logfile.

logfile="/var/odoo/log/logfile.log"

# Location to place backups.

backup_dir="/var/odoo/backups"

touch $logfile

timeslot=`date +%d-%m-%y-%H-%M-%S`

databases=`psql -U postgres -q -c "\l" | awk '{ print $1}' | grep -vE '^\||^-|^List|^Name|template[0|1]|^\('`

for i in $databases; do

timeinfo=`date '+%T %x'`

echo "Backup and Vacuum started at $timeinfo for time slot $timeslot on database: $i " >> $logfile

/usr/bin/vacuumdb -z -U postegres $i >/dev/null 2>&1

/usr/bin/pg_dump $i --port 5432 -U postgres --format=c --blobs --verbose | gzip > "$backup_dir/odoo-$i-$timeslot-database.gz"

timeinfo=`date '+%T %x'`

echo "Backup and Vacuum complete at $timeinfo for time slot $timeslot on database: $i " >> $logfile

done

#-------------------------------------------------

# delete backups more than 30 days old

find $backup_dir/Odoo* -mtime +30 -exec rm {} \;

#To start Odoo service

sudo service odoo start



#END
