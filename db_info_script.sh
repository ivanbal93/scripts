#!/bin/bash

#  get information only about creating and updating dates of db

mysql -u root -p -t -e \
    "SELECT
        DISTINCT TABLE_SCHEMA AS db_name
    ,   MAX(DATE_FORMAT(CREATE_TIME, '%d.%m.%Y')) AS last_create_date
    ,   MAX(DATE_FORMAT(UPDATE_TIME, '%d.%m.%Y')) AS last_update_date
    FROM 
        INFORMATION_SCHEMA.TABLES
    WHERE 
        TABLE_SCHEMA NOT IN (
            'information_schema'
        ,   'mysql'
        ,   'performance_schema'
        ,   'sys'
        ,   'phpmyadmin'
        )
    GROUP BY 1
    ORDER BY
        2, 3
    ;"