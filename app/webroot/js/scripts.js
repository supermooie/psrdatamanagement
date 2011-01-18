$(document).ready(function() {
    //alert("hello");

    $.getJSON("index.php/statuses/getStatuses",
      function(data) {

        $('#statuses').empty();
        $('#statuses').append('<tr><th>Name</th><th>Success</th><th>Last Updated</th></tr>');

        $.each(data, function(i,stat){
            var content = '<tr>';
            content += '<td>' + stat.Statuses.name + '</td>';
            content += '<td>' + stat.Statuses.status + '</td>';
            content += '<td>' + stat.Statuses.updated + '</td>';
            content += '</tr>';

            $('#statuses').append(content);
        });
    });
});
