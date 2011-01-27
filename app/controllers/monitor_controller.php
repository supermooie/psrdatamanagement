<?php

class MonitorController extends AppController
{
  var $name = 'Monitor';
  var $helpers = array('Js' => array('Jquery'));
  var $uses = array('Monitor', 'DaemonStatus');

  function index()
  {
    // Change to 'config' table to get the pipeline status.
    $this->Monitor->setSource('config');

    $this->Session->setFlash('Hello.');
  }

  function transfers()
  {
  }
}

?>

