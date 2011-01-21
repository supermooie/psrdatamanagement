<?php

class PipelineStatusesController extends AppController
{
  var $name = 'PipelineStatusesController';
  var $uses = array('Monitor', 'PipelineStatus');

  function getStatuses()
  {
    $this->autoRender = false;

    $result = $this->PipelineStatus->find('all');
    echo json_encode($result);
  }
}

?>
