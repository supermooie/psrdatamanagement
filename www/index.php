<?php

require_once('Config.php');
require_once('login.php');

session_start();

// Check if the user has logged in (to view the control part of the web page).
if (isset($_SESSION['logged_in']) && $_SESSION['logged_in'] === TRUE) {
  $logged_in = TRUE;
} else {
  $logged_in = FALSE;
}

$smarty = new Smarty();
$smarty->template_dir = SMARTY_TEMPLATE_DIR;
$smarty->compile_dir = SMARTY_COMPILE_DIR;

$smarty->assign('logged_in', $logged_in);
$smarty->display('index.tpl');

?>
