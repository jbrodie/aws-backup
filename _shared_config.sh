#!/bin/bash

echo_time() {
    date +"%Y-%m-%d %R %z : $*"
}

export CURRENT_DATE=$(date +"%Y_%m_%d")
export VPC_SECURITY_GROUP=""
export AVAILABILITY_ZONE=""
export DB_SUBNET_GROUP_NAME=""
export BACKUP_INSTANCE_NAME="auto-export-$SNAPSHOT_GROUP_NAME"
export DB_PARAMETER_GROUP="backup-mysql55-parameter-group"
export LOG_FILE="$(dirname $0)/logs/${CURRENT_DATE}-${SNAPSHOT_GROUP_NAME}.log"