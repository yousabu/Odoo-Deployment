#!/bin/bash

DIR=/tmp
DB=dvdrental

rm -rf $DIR/$DB*.tar
sudo -u postgres pg_dump --format t --file "$DIR/$DB $(date --rfc-3339 seconds).tar" $DB
