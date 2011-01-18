<!-- File: /app/views/monitor/index.ctp  -->

<h1>Pipeline Status</h1>

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
