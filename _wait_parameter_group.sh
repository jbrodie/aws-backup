#!/bin/bash
# Wait until the instance has started
DBP_DONE="false"
while [ "$DBP_DONE" != "true" ]
do
  DB_PARAM_STATUS=`aws rds describe-db-instances --db-instance-identifier $BACKUP_INSTANCE_NAME | grep 'ParameterApplyStatus' | awk '{ print $4 }'`
  if [ "$DB_PARAM_STATUS" = "in-sync" ]; then
    DBP_DONE="true"
  else
    echo_time "Waiting for parameter group to be applied ...${DB_PARAM_STATUS}"
    sleep 10
    if [ "$DB_PARAM_STATUS" = "pending-reboot" ]; then
      aws rds reboot-db-instance --db-instance-identifier $BACKUP_INSTANCE_NAME
      echo_time "Something is stuck thinking it is still pending a reboot ... so we are going to reboot it."
      sleep 10
      source $(dirname $0)/_wait.sh
    fi
  fi
done
echo_time "$BACKUP_INSTANCE_NAME has proper db parameter group"