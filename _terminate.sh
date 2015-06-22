#!/bin/bash
echo_time "Destroying instance $BACKUP_INSTANCE_NAME - this takes a few minutes"
aws rds delete-db-instance --db-instance-identifier $BACKUP_INSTANCE_NAME --skip-final-snapshot

DONE="false"
while [ "$DONE" = "false" ]
do
  STATUS=`aws rds describe-db-instances --db-instance-identifier $BACKUP_INSTANCE_NAME | grep DBInstanceStatus | cut -f 4 -d \| | xargs`
  if [ "$STATUS" = "" ]; then
    DONE="true"
  else
    echo_time "Waiting...$STATUS"
    sleep 10
  fi
done
echo_time "$BACKUP_INSTANCE_NAME Has Been Terminated"