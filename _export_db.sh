#!/bin/bash
echo_time "Exporting $DB_NAME"

mysqldump --defaults-file=/home/ubuntu/.my.cnf -h $DB_ENDPOINT $DB_NAME | gzip -c9 > ${DB_NAME}_${CURRENT_DATE}.sql.gz
EXITCODE=$?
if [ $EXITCODE -ne 0 ] ; then
  echo_time "Full dump for ${DB_NAME} failed with code: $EXITCODE"
  exit 1;
else
  echo_time "Moving ${DB_NAME} backup to ${DB_PATH} Folder"
  mv --force ${DB_NAME}_$CURRENT_DATE.sql.gz ${DB_PATH}/${DB_NAME}_${CURRENT_DATE}.sql.gz
fi