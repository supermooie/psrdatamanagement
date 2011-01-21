<?php

class EppDiskStatusesController extends AppController
{
  var $name = 'EppDiskStatusesController';
  var $uses = array('Monitor', 'EppDiskStatus');

  function getStatuses()
  {
    $this->autoRender = false;

    $result = $this->EppDiskStatus->find('all');
    echo json_encode($result);
  }
}

?>
