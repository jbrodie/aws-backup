#!/bin/bash
# Wait until the instance has started
DONE="false"
while [ "$DONE" != "true" ]
do
  SGNAME=`aws rds describe-db-instances --db-instance-identifier $BACKUP_INSTANCE_NAME | grep 'VpcSecurityGroupId' | awk '{ print $4 }'`
  if [ "$SGNAME" = "$VPC_SECURITY_GROUP" ]; then
    DONE="true"
  else
    echo_time "Waiting for the security group to be applied ... ${SGNAME}"
    sleep 10
  fi
done
echo_time "$BACKUP_INSTANCE_NAME has proper security group $VPC_SECURITY_GROUP"