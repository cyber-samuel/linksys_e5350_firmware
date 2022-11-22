<% web_include_file("copyright.asp"); %>
<HTML dir="<% ui_position("match", "rtl"); %>">
<HEAD>
<TITLE></TITLE>
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
<script language="javascript" type="text/javascript" src="md5_2.js"></script>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/share.js"></SCRIPT>
<SCRIPT language="JavaScript">
document.title = "Router Access";	
function en_value(data)
{
var pseed2 = "";
var buffer1 = data;
var md5Str2 = "";
var Length2 = data.length;
if (Length2 < 10 )
{	
buffer1 += "0";
buffer1 += Length2;
}
else
{
buffer1 += Length2;
}
Length2 = Length2 + 2;
for(var p = 0; p < 64; p++) {
var tempCount = p % Length2;
pseed2 += buffer1.substring(tempCount, tempCount + 1);
}
md5Str2 = hex_md5(pseed2);
return md5Str2;
}
function to_submit(F)
{
var en_pwd = en_value(F.http_passwd.value);
F.http_passwd.value = en_pwd;
F.submit();
}
function chk_keypress(e)
{
var keycode = (window.event)? event.keyCode:e.which;
var F = document.login;
if ( keycode == 13 ) 
{
to_submit(F);                                          //click the 'continue' button
if ( window.event )
{
window.event.returnValue = null;
event.keyCode=0;
}
else
e.preventDefault();
return false;
}
}
function valid_name2(I,M,flag)
{
isascii(I,M);
}
function init()
{	
document.forms[0].action="login.cgi";
document.forms[0].submit_button.value="logout";
document.forms[0].submit();
}
</SCRIPT>
</head>
<body id="blocked" onLoad="init()">
<div class="login-container">
<div class="login-content">
<div class="login-header">
<div class="logo-form">&nbsp;</div>
<div class="logo-header">
<h3><% get_model_name(); %><span> Wi-Fi Router</span></h3>
</div>
<div class="login-box">
<form name="login" method="<% get_http_method(); %>" action="login.cgi" onKeyDown="chk_keypress(event)" autocomplete="off">
<input type="hidden" name="submit_button" value="login" />
<input type="hidden" name="change_action" />
<input type="hidden" name="action" value="Apply" />
<input type="hidden" name="wait_time" value="19" />
<input type="hidden" name="submit_type" />
<div class="section-body">
<span><script>Capture(share.required)</script></span>
</div>
<div class="row-fluid login-form">
<div style="display:none">
<div class="loginFormTdl">
<label for="http_username"><script>Capture(share.usrname1)</script>:</label>
</div>
<div class="loginFormTdr">
<input type="text" class="input-xlarge inputLogin touched dirty invalid" id="http_username" name="http_username" maxlength="32" onBlur="valid_name2(this,share.usrname1,SPACE_NO)" value="admin" />
</div>
<div class="clear"></div>
</div>
<div>
<!--<div class="loginFormTdl">-->
<label for="http_passwd"><script>Capture(share.passwd)</script>:</label>
<!--</div>-->
<div class="loginFormTdr">
<input type="password" class="input-xlarge inputLogin" id="http_passwd" name="http_passwd" maxlength="63" onBlur="valid_name2(this,share.passwd,SPACE_NO)" />
</div>
<div class="clear"></div>
</div>
<div class="error loginError">
<p>
<script>
var session_status = "<% nvram_get("session_status"); %>";
if (session_status == "4")
{
Capture(pctrl.pwderrmsg2);
document.write("<BR>");
Capture(session.loginagain);
document.login.http_passwd.focus();
}
else if (session_status == "3")
{
Capture(session.invlidlogin);
document.write("<BR>");	
Capture(session.tryagain);
document.login.http_passwd.focus();
}
else if(session_status == "2")
{
Capture(session.timeout);
document.write("<BR>");	
Capture(session.loginagain);
}
else if (session_status == "1")
{
Capture(session.logout);
document.write("<BR>");	
Capture(session.loginagain);
}
</script>
</p>
</div>
</div>
<div class="row-fluid">
<div class="loginFormBtn">
<a class="btn btn-primary loginBtn" name="button" onclick="to_submit(document.forms[0])"><script>Capture(gn.login)</script></a>
</div>
</div>
</form>
</div>
</div>
</div>
<br>
<br>
<br>
<div class="footer" id="footer">
<center>
<p><script>Capture(wiz.copyright)</script></p>
</center>
</div>
</div>
</body>
</html>
