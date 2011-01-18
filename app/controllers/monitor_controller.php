<?php

class MonitorController extends AppController
{
  var $name = 'Monitor';
  var $helpers = array('Js' => array('Jquery'));
  var $uses = array('Monitor', 'Statuses');

  function index()
  {
    // Change to 'config' table to get the pipeline status.
    $this->Monitor->setSource('config');

    //$this->set('config', $this->Monitor->find('all'));

    //$this->requestAction('/Statuses/getStatuses');
  }
}

?>

