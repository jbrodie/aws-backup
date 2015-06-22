#!/bin/bash
# Wait until the instance has started
echo_time "10 second pause to allow the commands to fire"
sleep 10

DONE="false"
while [ "$DONE" != "true" ]
do
  STATUS=`aws rds describe-db-instances --db-instance-identifier $BACKUP_INSTANCE_NAME | grep DBInstanceStatus | cut -f 4 -d \| | xargs`
  if [ "$STATUS" = "available" ]; then
  DONE="true"
else
  echo_time "Waiting for db instance status ... ${STATUS}"
  sleep 10
fi
done
echo_time $BACKUP_INSTANCE_NAME Is Available