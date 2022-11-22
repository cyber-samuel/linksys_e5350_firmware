<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE></TITLE>
<% no_cache(); %>
<% charset(); %>
<% nvram_match("device_view_type","1","<!--"); %>
<style type="text/css">/*<![CDATA[*/
@import "main<% ui_position("match", "_rtl"); %>.css";
/*]]>*/</style>
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript" src="main.js"></script>
<% nvram_match("device_view_type","1","-->"); %>
<% nvram_invmatch("device_view_type","1","<!--"); %>
<style type="text/css">/*<![CDATA[*/
@import "mobile/styles/main.css";
/*]]>*/</style>
<script type="text/javascript" src="mobile/scripts/jquery.js"></script>
<script type="text/javascript" src="mobile/scripts/main.js"></script>
<meta name="viewport" content="width=320; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;"/>
<% nvram_invmatch("device_view_type","1","-->"); %>
<script language="javascript" type="text/javascript" src="gn_filelink.js"></script>
<SCRIPT language=JavaScript>
document.title = gn.title;	
var close_session = "<% get_session_status(); %>";
var device_type = '<% nvram_get("device_view_type"); %>';
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
if(event.keyCode == 10)
{
event.cancelBubble = true;
event.returnValue = false;
}
else if(event.keyCode == 13)
{
return to_submit(document.login);
}
return true;
}
*/
/*function setCookie(value, expiredays)*/
function setCookie()
{
var F = document.login;
/*when current login page is in mobile state, and the "alt-view" is "Desktop view,
device_type should be 1, so when click "Desktop view", set cookie mobile_view_type
to 2. otherwise set cookie to 1*/
if (device_type == '1')
document.cookie = "mobile_view_type=2";
else
document.cookie = "mobile_view_type=1";
/*
if (host_url)
window.location.replace("login.asp?" + host_url);
else
window.location.replace("login.asp");
*/
window.location.replace("login.asp?" + F.gn_host_url.value);
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
document.login.gn_view_type.value=device_type;
document.login.guest_login.focus();
var close_session = "<% get_session_status(); %>";
if ( close_session == "1" )
{
document.forms[0].action= "guestnetwork.cgi";
}
else
{
document.forms[0].action= "guestnetwork.cgi";
}
}
</SCRIPT>
</head>
<body id="blocked" onLoad="init()">
<div id="content">
<div class="h1">
<h1><span><script>Capture(gn.title)</script>
</span>
</h1>
</div>
<% nvram_match("device_view_type","1","<!--"); %>
<div class="divider">
<span><img src="../image/layout/Divider.jpg" \> </span>
</div>
<% nvram_match("device_view_type","1","-->"); %>
<div class="info-text">
<p><span><script>Capture(gn.tips6)</script></span></p>
<div class="formwrapper">
<form name=login method=<% get_http_method(); %> action=guestnetwork.cgi autocomplete="off">
<input type=hidden name=submit_button value="login">
<input type=hidden name=change_action>
<input type=hidden name=gui_action value="Apply">
<input type=hidden name=wait_time value=19>
<input type=hidden name=submit_type>
<input type=hidden name=gn_host_url value='<% nvram_get("gn_host_url"); %>'>
<input type=hidden name=gn_view_type>
<div class="field"> <label for="password"><script>Capture(share.passwd)</script>:</label> 
<INPUT type=password maxlength="32" name="guest_login" onBlur=valid_name2(this,"Password",SPACE_NO)></div>
<div class="error">
<p>
<script>
var deny='<% nvram_get("gn_password_deny"); %>';
if(deny == '1')
Capture(hndmsg.errpwd);
else
document.write("<BR>");	
document.login.guest_login.focus();
</script>
</p>
</div>
<div class="button"><script>document.write("<a href='javascript:to_submit(document.forms[0])'>" + gn.login + "</a>");</script></div>
</form>
</div>
<% nvram_else_selmatch("device_view_type","1","","<!--"); %>
<div class="alt-view"><p><span><script>document.write("<a href='javascript:setCookie()'>" + gn.dv + "</a>");</script></span></p></div>
<% nvram_else_selmatch("device_view_type","1","","-->"); %>
<% nvram_else_selmatch("device_view_type","2","","<!--"); %>
<div class="alt-view"><p><span><script>document.write("<a href='javascript:setCookie()'>" + gn.mv + "</a>");</script></span></p></div>
<% nvram_else_selmatch("device_view_type","2","","-->"); %>
</div>
</div>
<!--.formwrapper--> 
<!--#content-->
</body>
</html>
