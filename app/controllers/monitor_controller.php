<?php

class MonitorController extends AppController
{
  var $name = 'Monitor';
  var $helpers = array('Js' => array('Jquery'));

  function index()
  {
    // Change to 'config' table to get the pipeline status.
    $this->Monitor->setSource('config');

    $this->set('config', $this->Monitor->find('all'));

    echo '<pre>';
    print_r($this->Monitor->find('all'));
    echo '</pre>';

  }

  function foo()
  {
    echo "in foo";
    }

}

?>

