<?php

/**
 * Unset the logged_in flag and destroy the current session.
 *
 * Author: Jonathan
 * Date:   14.01.11
 */

session_start();
unset($_SESSION['logged_in']);
session_destroy();

?>
