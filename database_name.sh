#!/bin/bash
export SNAPSHOT_GROUP_NAME="database_snapshot_name"

source $(dirname $0)/_shared_config.sh

touch $LOG_FILE
echo_time "Log file created.  Processing started."
exec &> >(tee -a ${LOG_FILE})

echo_time "Console and Log Redirections created."

# map our storage paths
mkdir -p ~/RDSBackups/${CURRENT_DATE}
export SAVE_PATH=~/RDSBackups/${CURRENT_DATE}
mkdir -p ~/RDSBackupsDevs/${CURRENT_DATE}
export SAVE_PATH_DEVS=~/RDSBackupsDevs/${CURRENT_DATE}
echo_time "Drive save paths have been set."

source $(dirname $0)/_mount_instance.sh

export DB_NAME="database_name"
export DB_PATH=${SAVE_PATH}
source $(dirname $0)/_export_db.sh

export SANITIZE_FILE="database_name.sql"
source $(dirname $0)/_sanitize.sh

export DB_PATH=$SAVE_PATH_DEVS
source $(dirname $0)/_export_db.sh

# # Terminate the instance and wait for confirmation that it is complete
source $(dirname $0)/_terminate.sh
source $(dirname $0)/_cleanup.sh
