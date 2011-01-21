<?php

class PksDiskStatusesController extends AppController
{
  var $name = 'PksDiskStatusesController';
  var $uses = array('Monitor', 'PksDiskStatus');

  function getStatuses()
  {
    $this->autoRender = false;

    $result = $this->PksDiskStatus->find('all');
    echo json_encode($result);
  }
}

?>
