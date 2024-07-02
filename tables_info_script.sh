#!/bin/bash

# get additional information about creating and updating dates of tables

mysql -u root -p -t -e \
    "SELECT
        TABLE_SCHEMA AS db_name
    ,   TABLE_NAME AS table_name
    ,   DATE_FORMAT(CREATE_TIME, '%d.%m.%Y') AS create_time
    ,   DATE_FORMAT(UPDATE_TIME, '%d.%m.%Y') AS update_time
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
    ORDER BY
        1, 3, 2
    ;"