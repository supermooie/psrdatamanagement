<!-- File: /app/views/statuses/index.ctp  -->

<p><?php echo $this->Html->link("Current Transfers", array('action' => 'transfers')); ?></p>
<p><?php echo $this->Html->link("Files", "/files/index"); ?></p>

<h2>Pipeline Status</h2>

The overall status of the data-transfer pipeline. All worker daemons read this value and only process if the pipeline is running. The value is updated (from the database) every minute.

<table id="pipeline_statuses"></table>

<h2>Daemon Statuses - UNFINISHED</h2>

Statuses of each worker daemon.

(This table will automatically update every minute.)

<table id="daemon_statuses"></table>

<h2>Parkes Disk Statuses - UNFINISHED</h2>
A script will be run daily to update these values. The table displayed will only update upon page refresh.

<table id="pks_disk_statuses"></table>

<h2>Epping Disk Statuses - UNFINISHED</h2>
A script will be run daily to update these values. The table displayed will only update upon page refresh.

<table id="epp_disk_statuses"></table>

