<?php

class MembersController extends AppController {
  var $helpers = array ('Html','Form');
  var $name = 'Members';

  function index() {
    $this->set('memebers', $this->Post->find('all'));
    print_r($members);
  }

}

?>
