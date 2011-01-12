<?php

/**
 * Checks POST data ('username' and 'password') against the entry in the
 * database. Sets SESSION data ('logged_in') according to the log in result.
 *
 * Author: Jonathan Khoo <Jonathan.Khoo@csiro.au>
 * Date:   12.01.11
 */

@session_start();

// Credientials for read-only access to kho018_psrdatamanagement.
$db_user          = 'psrdata';
$db_password      = '+esh4ahP2';
$db_database_name = 'kho018_psrdatamanagement';
$db_hostname      = 'herschel';

mysql_connect($db_hostname, $db_user, $db_password);
@mysql_select_db($db_database_name) or die( "Unable to select database");

$username =  mysql_escape_string(stripslashes($_POST['username']));
$password =  mysql_escape_string(stripslashes($_POST['password']));

$query = "SELECT * FROM members WHERE username='$username' AND password='$password'";
$result = mysql_query($query);
mysql_close();

$count = mysql_num_rows($result);

if ($count == 1) {
  // Successful log in as valid 'control' user.
  $_SESSION['logged_in'] = TRUE;
}

?>
