#!/bin/bash
echo_time "Cleaning ${DB_NAME} Database Content with ${SANITIZE_FILE}"
mysql --defaults-file=/home/ubuntu/.my.cnf -h $DB_ENDPOINT ${DB_NAME} < $(dirname $0)/sanitizers/${SANITIZE_FILE}