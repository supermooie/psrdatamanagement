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
              data: dataString,
              success: function() {
                $('#control_box').show();
              }
          });
        }
    });

});

$(document).keydown(function(e) {
    if (e.keyCode == 27) {
      $("#login-panel").hide(0);
    }
});
