#!/bin/bash

SOURCE_SNAPSHOT=$(aws rds describe-db-snapshots --db-instance-identifier $SNAPSHOT_GROUP_NAME | grep $SNAPSHOT_GROUP_NAME | grep automated | awk '{ print $26 "\t" $8 }' | sort | tail -n1 | awk '{print $2}')
echo_time Most recent snapshot is: $SOURCE_SNAPSHOT

# mount this snapshot on a new instance
aws rds restore-db-instance-from-db-snapshot --db-instance-identifier $BACKUP_INSTANCE_NAME --db-snapshot-identifier $SOURCE_SNAPSHOT --db-subnet-group-name $DB_SUBNET_GROUP_NAME --availability-zone $AVAILABILITY_ZONE
source $(dirname $0)/_wait.sh

# set the security group for this new instance to make it available
echo_time "Modifying the security group for the new RDS instance."
aws rds modify-db-instance --db-instance-identifier $BACKUP_INSTANCE_NAME --db-parameter-group-name $DB_PARAMETER_GROUP --vpc-security-group-ids $VPC_SECURITY_GROUP --apply-immediately
source $(dirname $0)/_wait_security_group.sh
echo_time "Security group has been set to $VPC_SECURITY_GROUP."

echo_time "Rebooting to apply db parameter group"
aws rds reboot-db-instance --db-instance-identifier $BACKUP_INSTANCE_NAME
source $(dirname $0)/_wait.sh

# wait for in-sync status for the db parameter group.
echo_time "Waiting for In-Sync status on DB Parameter Group"
source $(dirname $0)/_wait_parameter_group.sh

aws rds describe-db-instances --db-instance-identifier $BACKUP_INSTANCE_NAME

DB_ENDPOINT=$(aws rds describe-db-instances --db-instance-identifier $BACKUP_INSTANCE_NAME | grep 'Address' | awk '{ print $3 }')
echo_time "New RDS Endpoint is located at $DB_ENDPOINT."