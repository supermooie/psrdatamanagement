<!-- File: /app/views/statuses/index.ctp  -->

<h2>Pipeline Status</h2>

The overall status of the data-transfer pipeline. All worker daemons read this value and only process if the pipeline is running. The value is updated (from the database) every minute.

<table id="pipeline_statuses"></table>

<h2>Daemon Statuses - UNFINISHED</h2>

Statuses of each worker daemon.

(This table will automatically update every minute.)

<!--
<table>
  <tr>
    <th>
      Running
    </th>
    <th>
      Last Updated
    </th>
  </tr>

  <tr>
    <td>
      <?php echo $config[0]['Monitor']['pipeline_status']; ?>
    </td>
    <td>
      <?php echo $config[0]['Monitor']['last_updated']; ?>
    </td>
  </tr>
</table>
-->

<table id="daemon_statuses"></table>

<h2>Parkes Disk Statuses - UNFINISHED</h2>
A script will be run daily to update these values. The table displayed will only update upon page refresh.

<table id="pks_disk_statuses"></table>

<h2>Epping Disk Statuses - UNFINISHED</h2>
A script will be run daily to update these values. The table displayed will only update upon page refresh.

<table id="epp_disk_statuses"></table>

