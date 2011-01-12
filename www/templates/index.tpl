{include file="header.tpl" title="Pulsar Data Management"}

<div id="demo-header">
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
</div>

<div id="clear"></div>

{if $logged_in}
<div id="control_box">
  <h1>Control</h1>
</div>
{else}
Not logged in.
{/if}

<div id="box">
  <h1>Monitor</h1>
</div>

<br>
<br>

{include file="footer.tpl"}
