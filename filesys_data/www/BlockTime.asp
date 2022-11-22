<% web_include_file("copyright.asp"); %>
<HTML dir="<% ui_position("match", "rtl"); %>">
<HEAD>
<TITLE></TITLE>
<% nvram_invmatch("device_view_type","1","<!--"); %>
<meta name="viewport" content="width=320; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
<% nvram_invmatch("device_view_type","1","-->"); %>
<% no_cache(); %>
<% charset(); %>
<link rel="stylesheet" href="static/css/bootstrap.min.css" />
<link rel="stylesheet" href="static/css/pages.css" />
<link rel="stylesheet" href="static/css/style.min.css" />
<link rel="stylesheet" href="static/css/app.css" />
<% ui_position("invmatch", "<!--"); %>
<link rel="stylesheet" href="static/css/rtl.css" />
<% ui_position("invmatch", "-->"); %>
<script language="javascript" type="text/javascript" src="gn_filelink.js"></script>
<script language="javascript">
var device_type = '<% nvram_get("device_view_type"); %>';
document.title = hndmsg.inetblock;
var close_session = "<% get_session_status(); %>";
/*
function onInputKeydown(event)
{
if(typeof event == "undefined")
{
return handleKeyDown(window.event);
}
else
{
return handleKeyDown(event);
}
}
function handleKeyDown(event)
{
if(event.keyCode == 13)
{
return to_submit(document.login);
}
return true;
}
*/
/*function setCookie(value, expiredays)*/
function setCookie()
{
/*when current login page is in mobile state, and the "alt-view" is "Desktop view,
device_type should be 1, so when click "Desktop view", set cookie mobile_view_type
to 2. otherwise set cookie to 1*/
if (device_type == '1')
document.cookie = "mobile_view_type=2";
else
document.cookie = "mobile_view_type=1";
if (document.login.HND_block_url.value)
window.location.replace(document.login.HND_block_url.value);	
else
window.location.replace("BlockTime.asp");
}
function to_submit(F)
{
F.submit();
}
function valid_name2(I,M,flag)
{
isascii(I,M);
}
function init()
{
var close_session = "<% get_session_status(); %>";
if ( close_session == "1" )
{
document.forms[0].action= "hndUnblock.cgi";
}
else
{
document.forms[0].action= "hndUnblock.cgi?session_id=<% nvram_get("session_key"); %>";
}
}
</script>
</head>
<body id="blocked" onLoad="init()">
<div class="login-container">
<div class="login-content">
<div class="login-header">
<div class="logo-form">&nbsp;</div>
<!--
<div class="logo-header">
<h3>Linksys E2500 <span> Wi-Fi Cable Modem Router</span></h3>
</div>
-->
<div class="login-box">
<form name="login" method="<% get_http_method(); %>" action="hndUnblock.cgi" autocomplete="off">
<input type="hidden" name="submit_button" value="hndUnBlock" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" value="Apply" />
<input type="hidden" name="HNDRedirect" />
<input type="hidden" name="HND_block_url" value="<% nvram_get("hnd_block_url"); %>" />
<input type="hidden" name="HND_block_mac" value="<% nvram_get("hnd_block_mac"); %>" />
<input type="hidden" name="HND_block_ip" value="<% nvram_get("hnd_block_ip"); %>" />
<input type="hidden" name="HND_block_policy" value="<% nvram_get("hnd_block_policy"); %>" />
<input type="hidden" name="HND_block_viewtype" value="<% nvram_get("device_view_type"); %>" />
<input type="hidden" name="HND_block_reason" value="0" />
<input type="hidden" name="wait_time" value="19" />
<input type="hidden" name="submit_type" />
<div class="section-body">
<h3 style="margin:0;color:white"><script>Capture(hndmsg.inetblock)</script></h3>
</div>
<div style="padding-top:2em">
<p><script>Capture(hndmsg.timeblock)</script></p>
</div>
<div class="row-fluid login-form">
<div>
<div class="loginFormTdl">
<label for="hnd_passwd"><script>Capture(share.passwd)</script>:</label>
</div>
<div class="loginFormTdr">
<input type="password" class="input-xlarge inputLogin" id="hnd_passwd" name="HND_password" onBlur="valid_name2(this,'Password',SPACE_NO)" />
</div>
<div class="clear"></div>
</div>
<div class="error loginError">
<p>
<script>
var deny="<% nvram_get("hnd_password_deny"); %>";
if(deny == '1')
Capture(hndmsg.errpwd)
document.login.HND_password.focus();
</script>
</p>
</div>
</div>
<div class="row-fluid">
<div class="loginFormBtn">
<% nvram_else_selmatch("device_view_type","1","","<!--"); %>
<div class="alt-view"><p><span><script>document.write("<a href='javascript:setCookie()'>" + 'Desktop view' + "</a>");</script></span></p></div>
<% nvram_else_selmatch("device_view_type","1","","-->"); %>
<% nvram_else_selmatch("device_view_type","2","","<!--"); %>
<div class="alt-view"><p><span><script>document.write("<a href='javascript:setCookie()'>" + 'Mobile view' + "</a>");</script></span></p></div>
<% nvram_else_selmatch("device_view_type","2","","-->"); %>
<button class="btn btn-primary loginBtn" name="button" onclick="to_submit(document.forms[0])"><script>Capture(hndmsg.unblock)</script></button>
</div>
</div>
</form>
</div>
</div>
</div>
<!--
<div class="footer" id="footer">
<center>
<p>© 2018 Belkin International, Inc. and/or its subsidiaries and affiliates, including Linksys, LLC. All rights reserved.</p>
</center>
</div>
-->
</div>
</body>
</html>
