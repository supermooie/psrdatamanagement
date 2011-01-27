$(document).ready(function() {
    $("#login-link").click(function(){
        $("#login-panel").slideToggle(200);
    });

    $(".button").click(function() {
        var username = $("input#username").val();
        var password = $("input#password").val();

        if (username != "" && password != "")  {
          var dataString = 'username='+ username + '&password=' + password;  
          $.ajax({
              type: "POST",
              url: "login.php",
              data: dataString
          });
        }
    });

    $('a#logout-link').click(function() {
        $.ajax({
            type: "POST",
            url: "logout.php",
            data: "",
            success: function() {
              window.location.reload();
            }
        });
    });

    $('#pipeline_status').load('get_pipeline_status.php');
    $('#pipeline_status').hide();

    setInterval(
      function() {
        $('#pipeline_status').load('get_pipeline_status.php');

        if ($('#pipeline_status').text() == 1) {
          $('.circle').css("background", "green");
        } else {
          $('.circle').css("background", "red");
        }
      }, 2000);
});

$(document).keydown(function(e) {
    if (e.keyCode == 27) {
      $("#login-panel").hide(0);
    }
});

