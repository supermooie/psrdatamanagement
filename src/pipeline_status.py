#!/usr/bin/python

#
# Queries the database for the pipeline status.
# Prints 'True' if it is running, 'False' if it is not running.
#
# Author: Jonathan
# Date:   25.01.11
#

import MySQLdb

class PipelineStatus:
  def __init__(self):
    self._db_hostname = 'localhost'
    self._db_name     = 'kho018_psrdatamanagement'
    self._db_username = 'psrdatamanager'
    self._db_password = 'Yie-Kap4Y'
    self._sql = "SELECT status FROM pipeline_statuses"

# Connect to the database and query for overall pipeline status.
  def get_pipeline_status_from_db(self):
    db = MySQLdb.connect(self._db_hostname, self._db_username, self._db_password, self._db_name)
    cursor = db.cursor()

    try:
      cursor.execute(self._sql)
      results = cursor.fetchone()

    except:
      raise Exception("Unable to fetch data")

    return results[0] == 1

def main():
  ps = PipelineStatus()
  print ps.get_pipeline_status_from_db()

if __name__ == '__main__':
  main()
