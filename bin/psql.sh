#!/usr/bin/env bash

CONTAINER_DB_NAME=sql_primer_db_1
DB_NAME=sql_primer
DB_ROLE=sql_primer_db_role

sudo docker exec -ti --user postgres $CONTAINER_DB_NAME psql -U$DB_ROLE $DB_NAME
