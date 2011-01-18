<?php

class StatusesController extends AppController
{
  var $name = 'Statuses';
  var $uses = array('Monitor', 'Statuses');

  function index()
  {
  }

  function getStatuses()
  {
    $this->autoRender = false;

    $result = $this->Statuses->find('all');
    echo json_encode($result);
  }
}

?>
