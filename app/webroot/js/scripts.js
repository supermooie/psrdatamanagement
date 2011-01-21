$(document).ready(function() {
    updatePipelineStatus();
    //alert("hello");

    // Daemon statues
    $.getJSON("index.php/daemon_statuses/getStatuses",
      function(data) {
        $('#daemon_statuses').empty();
        $('#daemon_statuses').append('<tr><th>Name</th><th>Currently Running</th><th>Last Updated</th></tr>');

        $.each(data, function(i,stat){
            var content = '<tr>';
            content += '<td>' + stat.DaemonStatus.name + '</td>';
            content += '<td>' + stat.DaemonStatus.status + '</td>';
            content += '<td>' + stat.DaemonStatus.updated + '</td>';
            content += '</tr>';

            $('#daemon_statuses').append(content);
        });
    });

    function updatePipelineStatus()
    {
      $.getJSON("index.php/pipeline_statuses/getStatuses",
        function(data) {
          $('#pipeline_statuses').empty();
          $('#pipeline_statuses').append('<tr><th>Currently Running</th><th>Last Updated</th><th>Comment</th></tr>');

          $.each(data, function(i,stat){
              var content = '<tr>';
              content += '<td>' + stat.PipelineStatus.status+ '</td>';
              content += '<td>' + stat.PipelineStatus.updated + '</td>';
              content += '<td>' + stat.PipelineStatus.comment + '</td>';
              content += '</tr>';

              $('#pipeline_statuses').append(content);
          });
      });
    }

    // Overall pipeline status - refresh main pipeline status every minute.
    setInterval(function() {
        updatePipelineStatus();
      }, 60000);

    // Parkes disk statuses 
    $.getJSON("index.php/pks_disk_statuses/getStatuses",
      function(data) {
        $('#pks_disk_statuses').empty();
        $('#pks_disk_statuses').append('<tr><th>Backend</th><th>Used (GB)</th><th>Free Space (GB)</th> <th>Disk Capacity (GB)</th><th>Access Path</th><th>Last Updated</th> </tr>');

        $.each(data, function(i,stat){
            var content = '<tr>';
            content += '<td>' + stat.PksDiskStatus.backend_name + '</td>';
            content += '<td>' + stat.PksDiskStatus.disk_used + '</td>';
            content += '<td>' + stat.PksDiskStatus.disk_free + '</td>';
            content += '<td>' + stat.PksDiskStatus.disk_capacity + '</td>';
            content += '<td>' + stat.PksDiskStatus.access_path + '</td>';
            content += '<td>' + stat.PksDiskStatus.updated+ '</td>';
            content += '</tr>';

            $('#pks_disk_statuses').append(content);
        });
    });

    // Epping disk statuses 
    $.getJSON("index.php/epp_disk_statuses/getStatuses",
      function(data) {
        $('#epp_disk_statuses').empty();
        $('#epp_disk_statuses').append('<tr><th>Environment Variable</th><th>Access Path</th><th>Data Format</th><th>Used (GB)</th>Backend<th>Used (GB)</th><th>Free Space (GB)</th> <th>Disk Capacity (GB)</th><th>Last Updated</th> </tr>');

        $.each(data, function(i,stat){
            var content = '<tr>';
            content += '<td>' + stat.EppDiskStatus.env_variable + '</td>';
            content += '<td>' + stat.EppDiskStatus.access_path + '</td>';
            content += '<td>' + stat.EppDiskStatus.data_format + '</td>';
            content += '<td>' + stat.EppDiskStatus.backend_name + '</td>';
            content += '<td>' + stat.EppDiskStatus.disk_used + '</td>';
            content += '<td>' + stat.EppDiskStatus.disk_free + '</td>';
            content += '<td>' + stat.EppDiskStatus.disk_capacity + '</td>';
            content += '<td>' + stat.EppDiskStatus.updated + '</td>';
            content += '</tr>';

            $('#epp_disk_statuses').append(content);
        });
    });
});
