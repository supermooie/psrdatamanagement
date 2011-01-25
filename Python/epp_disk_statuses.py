#!/usr/bin/python

"""
Program to get the status of each data disk at Epping. Results are entered into
the database.

Author: Jonathan Khoo
Date:   20.01.11
"""

import os
import MySQLdb

db_hostname = 'localhost'
db_name     = 'kho018_psrdatamanagement'
db_username = 'psrdatamanager'
db_password = 'Yie-Kap4Y'

db = MySQLdb.connect(db_hostname, db_username, db_password, db_name)

# prepare a cursor object using cursor() method
cursor = db.cursor()

sql = "SELECT status FROM pipeline_statuses"

try:
  cursor.execute(sql)
  results = cursor.fetchone()

except:
  print "Error: unable to fetch data."

db.close()

# TODO: It's probably better to read these values from
# /pulsar/psr/csh_script/PSR.cshrc ...
data_folders = {
    "DFB1":"/pulsar/archive06/DFB",
    "DFB2":"/pulsar/archive12/DFB",
    "DFB3":"/pulsar/archive14/DFB",
    "DFB4":"/pulsar/archive18/DFB",
    "DFB5":"/pulsar/archive19/DFB"
    }

if results[0] == 1:
# Do something if the pipeline is running.
  print data_folders

  for k, v in data_folders.items():
    s = os.statvfs(v)
    print s



