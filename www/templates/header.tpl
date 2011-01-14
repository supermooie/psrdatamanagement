<html>
  <head>
    <title>{$title|default:"Pulsar Data Management"}</title>
      <meta http-equiv="Content-Language" content="English" />
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      <link rel="stylesheet" type="text/css" href="style.css" media="screen" />
    </head>
    <body>
      <div id="top_bar">

        {if $logged_in}
        <a id="logout-link" href="#logout" title="Logout">Logout</a>
        {else}
        <a id="login-link" href="#login" title="Login">Admin Access</a>
        <div id="login-panel">
          <form action="" method="post">
            <label>Username:
              <input name="username" id="username" type="text" value=""> </label> 
            <label>Password:
              <input name="password" id="password" type="password" value=""> </label>
            <input type="submit" class="button" name="submit" value="Sign In">
            <small>Press ESC to close</small>
          </form>
        </div>
        {/if}

      </div>

      <div id="header">
        <h1>{$title}</h1>
      </div>
