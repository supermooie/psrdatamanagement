#!/usr/bin/python

#
# Iterate the incoming directories for DFB3 and DFB4, and copies
# the file into ROOT_DIRECTORY/<indentifier>. Where ROOT_DIRECTORY
# is dependent on whether the file type is search mode or fold mode.
# indentifier is the pulsar name for fold mode and either pulsar name
# or time group for search mode.
#
# Updates the status column # (+4) when the file has been moved to its final
# desitination.
#
# Author: Jonathan Khoo
# Date:   01.02.11
#

import pipeline_status
import MySQLdb
import glob
import os
import sys
import shutil
import time

TEN_MINUTES_IN_SECONDS = 600

#
# The processing method in which to perform the StoreDfbFiles operation.
#
# db_status (3): select only those that are in PSRFITS format (status: 1) and
# are in the incoming directory (status: 2).
# directory: process all files in the incoming directories and copy them as
# as required they don't exist.
#
class ProcessingMethod:
  db_status, directory = range(2)

class StoreDfbFiles:
  def __init__(self, backend = None, processing_method = ProcessingMethod.directory):
    self._backend = backend
    self._processing_method = processing_method

  def run(self):
    if self._backend == 'DFB3':
      self._path = '/pulsar/archive21/incoming_files/DFB3/'
    elif self._backend == 'DFB4':
      self._path = '/pulsar/archive21/incoming_files/DFB4/'
    else:
      print 'No DFB backend specified'
      return

    try:
      self.connect_to_db()
    except Exception, e:
      print e
      return

    print self._processing_method

    if self._processing_method == ProcessingMethod.db_status:
      self.process_by_db_status()
    elif self._processing_method == ProcessingMethod.directory:
      self.process_by_directory()
    else:
      raise Exception("Invalid processing method given")

  def is_valid_psrfits_file(self, ext):
    return ext == '.sf' or ext == '.rf' or ext == '.cf'

  def is_currently_open(self, modification_time):
    return time.time() - modification_time < TEN_MINUTES_IN_SECONDS

  def process_by_directory(self):
# Get all the files in the incoming DFB directory.
    l = [(os.path.getmtime(x), x) for x in glob.glob(self._path + '*')]
    l.sort()

# Get the modification time of the last file.
    (last_file_modification_time, null) = l[-1]

    for modification_time, file in l:
      ext = os.path.splitext(file)[1]

      # Only process search-mode, fold-mode, and cal files.
      if not self.is_valid_psrfits_file(ext):
        continue

      # Don't do anything to the last file if it has been modified in the last 10 minutes.
      if modification_time == last_file_modification_time and not self.is_currently_open(modification_time):
        continue

# Get the source name of the file from the database.
      sql = 'SELECT source_name FROM psrfits_files WHERE filename = "%s";' % os.path.basename(file)
      try:
        self._cursor.execute(sql)
        results = self._cursor.fetchone()
        if results:
          source_name = results[0].strip()
        else:
          return False
      except:
        raise Exception('Unable to fetch source name from %s' % os.path.basename(file))

# Do nothing if the source name was not read from the file. (Corrupt file.)
      if len(source_name) == 0:
        continue

# Only deal with fold-mode and cal files for the time being...
      if ext == '.rf' or ext == '.cf' and source_name:
        root_directory = '/pulsar/archive19/DFB/'
      else:
       continue 

      target_filepath = root_directory + source_name + '/' + os.path.basename(file)

      if not os.path.isdir(os.path.dirname(target_filepath)):
        print 'Creating directory... ', os.path.dirname(target_filepath)
        os.mkdir(os.path.dirname(target_filepath))

      if not os.path.exists(target_filepath):
        print 'Copying %s to %s' % (file, target_filepath)

        try:
          shutil.copyfile(file, target_filepath)
        except IOError:
          pass

        if os.path.isfile(target_filepath):
# All good!
# Update filepath in psrfits_files
# Update status is psrfits_files
          sql = 'UPDATE psrfits_files set filepath = "%s", status = status + 4 WHERE filename = "%s"' % (target_filepath, os.path.basename(file))

          try:
            self._cursor.execute(sql)
          except Exception, e:
            print e
            raise Exception("Unable to update psrfits_files.")

        """
      else:
        sql = 'UPDATE psrfits_files set filepath = "%s" WHERE filename = "%s"' % (target_filepath, os.path.basename(file))
        print sql

      try:
        self._cursor.execute(sql)
      except Exception, e:
        print e
        raise Exception("Unable to update psrfits_files.")
        """

  def process_by_db_status(self):
    print ''

  """
  Perform the initial connection to the database.
  """
  def connect_to_db(self):
    db_hostname = 'localhost'
    db_name     = 'kho018_psrdatamanagement'
    db_username = 'psrdatamanager'
    db_password = 'Yie-Kap4Y'

    self._db = MySQLdb.connect(db_hostname, db_username, db_password, db_name)
    self._cursor = self._db.cursor()

def main():
# Perform the initial check to see if the pipeline is running.
  ps = pipeline_status.PipelineStatus()
  if ps.get_pipeline_status_from_db() == False:
    sys.exit()

  sdf = StoreDfbFiles('DFB3')
  sdf.run()

  sdf = StoreDfbFiles('DFB4')
  sdf.run()

if __name__ == '__main__':
  main()
