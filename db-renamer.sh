#!/bin/bash

OLD_DB=$1
NEW_DB=$2
DB_USER=$3

mysql -u $DB_USER -p $OLD_DB -sNe 'show tables' | while read table; \ 
    do mysql -u $DB_USER -p -sNe "rename table $OLD_DB.$table to $NEW_DB.$table"; done