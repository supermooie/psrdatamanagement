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

    updateDfb3FilesListing();
    setInterval(function() {
        updateDfb3FilesListing();
      }, 60000);

    function updateDfb3FilesListing()
    {
      $.getJSON("index.php/files/get_dfb3_files",
        function(data) {
          $('#dfb3_files_listing').empty();
          $('#dfb3_files_listing').append('<tr><th>Filename</th><th>Current Filepath</th><th>Status (ignore this)</th><th>Filesize (MB)</th><th>Project ID</th><th>Observation Finished (convert this)</th><th>Source Name</th><th>Receiver</th><th>Centre Frequency (MHz)</th></tr>');

          $.each(data, function(i,stat){
              var content = '<tr>';
              content += '<td>' + stat.Files.filename + '</td>';
              content += '<td>' + stat.Files.filepath + '</td>';
              content += '<td>' + stat.Files.status + '</td>';
              content += '<td>' + stat.Files.filesize + '</td>';
              content += '<td>' + stat.Files.project_id + '</td>';
              content += '<td>' + stat.Files.file_last_modified + '</td>';
              content += '<td>' + stat.Files.source_name + '</td>';
              content += '<td>' + stat.Files.frontend + '</td>';
              content += '<td>' + stat.Files.frequency + '</td>';
              content += '</tr>';

              $('#dfb3_files_listing').append(content);
          });
      });
    }

    updateDfb4FilesListing();
    setInterval(function() {
        updateDfb4FilesListing();
      }, 60000);

    function updateDfb4FilesListing()
    {
      $.getJSON("index.php/files/get_dfb4_files",
        function(data) {
          $('#dfb4_files_listing').empty();
          $('#dfb4_files_listing').append('<tr><th>Filename</th><th>Current Filepath</th><th>Status (ignore this)</th><th>Filesize (MB)</th><th>Project ID</th><th>Observation Finished (convert this)</th><th>Source Name</th><th>Receiver</th><th>Centre Frequency (MHz)</th></tr>');

          $.each(data, function(i,stat){
              var content = '<tr>';
              content += '<td>' + stat.Files.filename + '</td>';
              content += '<td>' + stat.Files.filepath + '</td>';
              content += '<td>' + stat.Files.status + '</td>';
              content += '<td>' + stat.Files.filesize + '</td>';
              content += '<td>' + stat.Files.project_id + '</td>';
              content += '<td>' + stat.Files.file_last_modified + '</td>';
              content += '<td>' + stat.Files.source_name + '</td>';
              content += '<td>' + stat.Files.frontend + '</td>';
              content += '<td>' + stat.Files.frequency + '</td>';
              content += '</tr>';

              $('#dfb4_files_listing').append(content);
          });
      });
    }

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

    function updateDfbRsyncLog()
    {
      $.get("http://psrdatamanagement-int.atnf.csiro.au/read_rsync_log.php", { backend: "dfb3" },
        function(data) {
          $('#dfb3_rsync_log').html(data);
      });

      $.get("http://psrdatamanagement-int.atnf.csiro.au/read_rsync_log.php", { backend: "dfb4" },
        function(data) {
          $('#dfb4_rsync_log').html(data);
      });
    }

    // Overall pipeline status - refresh main pipeline status every minute.
    setInterval(function() {
        updatePipelineStatus();
      }, 60000);


    updateDfbRsyncLog();

    setInterval(function() {
        updateDfbRsyncLog();
      }, 3000);

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
        $('#epp_disk_statuses').append('<tr><th>Environment Variable</th><th>Access Path</th><th>Data Format</th><th>Backend</th><th>Used (GB)</th><th>Free Space (GB)</th> <th>Disk Capacity (GB)</th><th>Last Updated</th> </tr>');

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
