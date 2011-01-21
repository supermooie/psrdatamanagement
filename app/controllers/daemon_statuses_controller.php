<?php

class DaemonStatusesController extends AppController
{
  var $name = 'DaemonStatusesController';
  var $uses = array('Monitor', 'DaemonStatus');

  function getStatuses()
  {
    $this->autoRender = false;

    $result = $this->DaemonStatus->find('all');
    echo json_encode($result);
  }
}

?>
