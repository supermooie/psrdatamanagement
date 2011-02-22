#!/bin/bash

#
# Script to check whether there is a current DFB3-file transfer.
# Starts the transfer if there isn't one running
#
# Author: Jonathan Khoo
# Date:   25.01.11
#

SCRIPT_NAME="copy_dfb3_files.sh"
SCRIPT_LOCATION="/var/www/vhosts/psrdatamanagement.atnf.csiro.au/scripts/cron/src/

pgrep -f ${SCRIPT_LOCATION}${SCRIPT_NAME} > /dev/null

# Exit status for pgrep:
#   0   One or more processes matched the criteria.
#   1   No processes matched.
#   2   Syntax error in the command line.
#   3   Fatal error: out of memory etc.

# Run the copy_dfb3_files script, if it's not already running.
if [ $? = 1 ]
then
  nohup ${SCRIPT_LOCATION}${SCRIPT_NAME} & > /dev/null
fi

exit 0
