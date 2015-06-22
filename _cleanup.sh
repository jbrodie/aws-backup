#!/bin/bash

# dump all but last 5 folders
echo_time "Cleaning up the old folders of backups."
# rm -rf `ls -t ~/AWSBackups/ | tail -n +6`
cd $(dirname $0)/../RDSBackupsDevs
rm -rf `ls -t1 | tail -n +6`
echo_time "Clean up complete."

# clean up the environment variables before we leave
unset CURRENT_DATE
unset SNAPSHOT_GROUP_NAME
unset BACKUP_INSTANCE_NAME
unset VPC_SECURITY_GROUP
unset DB_SUBNET_GROUP_NAME
unset LOG_FILE
unset SAVE_PATH
unset SAVE_PATH_DEVS
unset SANITIZE_FILE