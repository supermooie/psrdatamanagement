#!/bin/bash

#
# Script to dump the tables and data from kho018_psrdatamanagement
#   - kho018_psrdatamanagement_tables.sql
#   - kho018_psrdatamanagement_data.sql
#
# Must be run from herschel.
#
# Author: Jonathan Khoo
# Date:   12.01.11
#

mysqldump -u psrdatamanager --password=Yie-Kap4Y kho018_psrdatamanagement --no-create-db --no-create-info > kho018_psrdatamanagement_data.sql
mysqldump -u psrdatamanager --password=Yie-Kap4Y kho018_psrdatamanagement --no-data  > kho018_psrdatamanagement_tables.sql
