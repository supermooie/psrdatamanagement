#!/usr/bin/python

#
# Traverses through the DFB3 and DFB4 files in the incoming directories
# and extracts the following metadata from new files (files that are not
# in the database):
#   1. filename
#   2. filepath
#   3. status
#   4. backend
#   5. filesize
#   6. file_last_modified (at Parkes)
#   7. project_id
#   8. source_name
#
# The metadata is then entered into the 'files' table of the database.
#
# Author: Jonathan Khoo
# Date:   25.01.11
#

import pipeline_status
import os
import MySQLdb
import glob
import sys

class ProcessDfbFiles:
  def __init__(self, backend = None):
    self._backend = backend

  """
  Extracts the aforementioned metadata from the file via python
  and vap calls.
  """
  def extract_metadata_from_file(self, file):
    self._filename = os.path.basename(file)
    self._filepath = os.path.dirname(file)
    self._status = 2 # File is on disk at Epping and is in PSRFITS format.
    self._backend = self.get_backend(file)
    self._filesize = round(float(os.path.getsize(file) / 1024.0 / 1024.0), 2)
    self._file_last_modified = os.path.getmtime(file)
    self._project_id = self.get_project_id(file)
    self._source_name = self.get_source_name(file)

  """
  Uses vap to get the pulsar name.
  """
  def get_source_name(self, file):
    cmd = "vap -nc name %s | awk '{print $2}'" % file
    stdout = os.popen(cmd)

    name = stdout.read().strip()
    if name:
      return name
    else:
      return 'UNDEF'

  """
  Uses vap to get the PID.
  """
  def get_project_id(self, file):
    cmd = "vap -nc projid %s | awk '{print $2}'" % file
    stdout = os.popen(cmd)

    project_id = stdout.read().strip()
    if project_id:
      return project_id
    else:
      return 'UNDEF'

  """
  Uses vap to get the backend.
  """
  def get_backend(self, file):
    cmd = "vap -nc backend %s | awk '{print $2}'" % file
    stdout = os.popen(cmd)

    backend = stdout.read().strip()
    if backend:
      return backend
    else:
      return 'UNDEF'

  """
  Iterate through the files in a directory depending on which backend has
  been specified.
  """
  def run(self):
    if self._backend == 'DFB3':
      path = '/pulsar/archive21/incoming_files/DFB3/'
    elif self._backend == 'DFB4':
      path = '/pulsar/archive21/incoming_files/DFB4/'
    else:
      print 'No DFB backend specified'
      return

    try:
      self.connect_to_db()
    except Exception, e:
      print e
      return

    list = glob.glob(path + '*')

    for file in list:
      print file
      ext = os.path.splitext(file)[1]

      """
      Only process search-mode, fold-mode, and cal files.
      """
      if ext == '.sf' or ext == '.rf' or ext == '.cf':
        if not self.file_exists_in_db(file):
          self.extract_metadata_from_file(file)
          self.write_metadata_to_db()

  """
  Writes the extracted metadata to the files table in the database.
  """
  def write_metadata_to_db(self):
    sql = "INSERT IGNORE into files (filename, filepath, status, backend, filesize, file_last_modified, project_id,  source_name) VALUES('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s');" % (self._filename, self._filepath, self._status, self._backend, self._filesize, self._file_last_modified, self._project_id, self._source_name)

    self._cursor.execute(sql)

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

  """
  Checks to see if the specified file is in the database. Returns true if it is and
  false otherwise.
  """
  def file_exists_in_db(self, file):
    self._sql = 'SELECT filename FROM files WHERE filename = "%s";' % os.path.basename(file)

    try:
      self._cursor.execute(self._sql)
      results = self._cursor.fetchone()
      if results:
        return True
      else:
        return False
    except:
      raise Exception("Unable to fetch data")

def main():
# Perform the initial check to see if the pipeline is running.
  ps = pipeline_status.PipelineStatus()
  if ps.get_pipeline_status_from_db() == False:
    sys.exit()

  pdf = ProcessDfbFiles('DFB3')
  pdf.run()

  pdf = ProcessDfbFiles('DFB4')
  pdf.run()

if __name__ == '__main__':
  main()
