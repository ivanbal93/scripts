#!/bin/bash

#  get information only about creating and updating dates of db

mysql -u root -p -t -e \
    "SELECT
        DISTINCT TABLE_SCHEMA AS db_name
    ,   DATE_FORMAT(CREATE_TIME, '%d.%m.%Y') AS create_date
    ,   DATE_FORMAT(MAX(UPDATE_TIME), '%d.%m.%Y') AS last_update_date
    FROM 
        INFORMATION_SCHEMA.TABLES
    GROUP BY
        1, 2
    ORDER BY
        1, 2
    ;"