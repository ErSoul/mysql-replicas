#!/bin/sh

mysql ${MYSQL_DATABASE} < /db_scripts/BANK_INFO.sql
mysql ${MYSQL_DATABASE} < /db_scripts/USER_DATA.sql