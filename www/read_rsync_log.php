<?php

/**
 * Outputs the last 10 lines of the corresponding rsync log file.
 *
 * Author: Jonathan Khoo
 * Date:   24.01.11
 */

define(LOGS_FOLDER, '/var/www/vhosts/psrdatamanagement.atnf.csiro.au/htdocs/logs/');

$backends_and_files = array(
  'dfb3' => 'rsync_dfb3.txt',
  'dfb4' => 'rsync_dfb4.txt'
);

$file = $backends_and_files[$_GET['backend']];
$file = LOGS_FOLDER . $file;

if (file_exists($file)) {

  $lines = 20;

  $handle = fopen($file, "r");
  $linecounter = $lines;
  $pos = -2;
  $beginning = false;
  $text = array();
  while ($linecounter > 0) {
    $t = " ";
    while ($t != "\n") {
      if(fseek($handle, $pos, SEEK_END) == -1) {
        $beginning = true; 
        break; 
      }
      $t = fgetc($handle);
      $pos --;
    }
    $linecounter --;
    if ($beginning) {
      rewind($handle);
    }
    $text[$lines-$linecounter-1] = fgets($handle);
    if ($beginning) break;
  }
  fclose ($handle);

  $output = array_reverse($text);

  foreach ($output as $l) {
    echo $l, '<br>';
  }
} else {
  echo "nothing";
}

?>
