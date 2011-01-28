<?php

class FilesController extends AppController
{
  var $name = 'Files';
  var $uses = array('Files');

  function index()
  {}

  function get_dfb3_files()
  {
    $this->autoRender = false;

    $result = $this->Files->find('all', array(
        'order' => array('file_last_modified DESC'),
        'limit' => 20,
        //'conditions' => array('backend' => 'PDFB3')
        'conditions' => array('filepath LIKE' => '%DFB3')
      ));

    // Convert from the unix timestamp format.
    foreach ($result as &$r) {
      $r['Files']['file_last_modified'] = date("Y-m-d H:i:s", $r['Files']['file_last_modified']);
    }

    echo json_encode($result);
  }

  function get_dfb4_files()
  {
    $this->autoRender = false;

    $result = $this->Files->find('all', array(
        'order' => array('file_last_modified DESC'),
        'limit' => 20,
        //'conditions' => array('backend' => 'PDFB4')
        'conditions' => array('filepath LIKE' => '%DFB4')
      ));

    // Convert from the unix timestamp format.
    foreach ($result as &$r) {
      $r['Files']['file_last_modified'] = date("Y-m-d H:i:s", $r['Files']['file_last_modified']);
    }

    echo json_encode($result);
  }
}

?>

