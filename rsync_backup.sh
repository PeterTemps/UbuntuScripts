# this shell script is used to backup files and directories to a local backup path
# print progress messages to the user and log file 
# it uses rsync to do the backup
# it is intended to be run as a cron job
# directories to be backed up are listed  in a file called rsync_backup_list.txt
# the backup path is specified in the variable backup_path
# the log file is specified in the variable log_file
# the script will create a log file if it does not exist
# the script will create the backup path if it does not exist
# the script will create a lock file to prevent multiple instances of the script running at the same time

#!/bin/bash

# change to the directory where the script is located
echo "Changing to script directory $(dirname "$0")" 
cd "$(dirname "$0")"

# set the log file
log_file="logs/rsync_backup.log"

# set the lock file
echo "Setting lock file" >> $log_file
lock_file="rsync_backup.lock"

# check if the log file exists, if not create it
if [ ! -f $log_file ]; then
echo "Creating log file" >> $log_file
    touch $log_file
fi

# check if the backup path exists, if not create it
if [ ! -d $backup_path ]; then
echo "Creating backup path" >> $log_file
    mkdir -p $backup_path
fi

# check if the rsync_backup_list.txt file exists, if not exit the script
if [ ! -f rsync_backup_list.txt ]; then
    echo "rsync_backup_list.txt file does not exist, exiting script" >> $log_file
    exit 1
fi

# check if the rsync_exclude_list.txt file exists, if not create it
if [ ! -f rsync_exclude_list.txt ]; then
    echo "Creating rsync_exclude_list.txt file" >> $log_file
    touch rsync_exclude_list.txt
fi

# check if the lock file exists, if it does exit the script
if [ -f $lock_file ]; then
    echo "Lock file exists, exiting script" >> $log_file
    exit 1
fi

echo "Starting rsync backup" >> $log_file

# set the backup path
echo "Setting backup path" >> $log_file
backup_path="/media/piotr/HOME2/Syncthing/Contabo/RsyncBackup"

# create the lock file
echo "Creating lock file" >> $log_file
touch $lock_file

# backup the files and directories and subdirectories listed in rsync_backup_list.txt to the backup path using rsync 
# print a message to the user and log file that the backup is in progress
echo "Backing up files and directories" >> $log_file
# read the rsync_backup_list.txt file line by line
while IFS= read -r line
do
    # print a message to the user and log file that the file or directory is being backed up
    echo "Backing up $line" >> $log_file
    # backup the file or directory to the backup path using rsync
    rsync -av -r --exclude-from=rsync_exclude_list.txt $line $backup_path >> $log_file
done < rsync_backup_list.txt

# print a message to the user and log file that the backup is complete
echo "Backup complete" >> $log_file

# remove the lock file
echo "Removing lock file" >> $log_file
rm $lock_file

# exit the script
exit 0