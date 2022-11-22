<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Routing Table</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("pop_filelink.asp"); %>
<SCRIPT language="Javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capsec.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/share.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/help.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capapp.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capasg.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capsetup.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capwrt54g.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/layout.js"></SCRIPT>
<SCRIPT language="javascript">
setFormActions({
'newui.chg': 'javascript:to_submit(document.forms[0])',
close:   true
});
document.title = newui.chggnpwd;
var close_session = "<% get_session_status(); %>";
document.onkeydown = onInputKeydown;
function block_image(M)
{
if(M == "password")
{
document.getElementById('pwd_see_close').style.display = "none";
document.getElementById('pwd_see_open').style.display = "none";
}
else
{
document.getElementById('cpwd_see_close').style.display = "none";
document.getElementById('cpwd_see_open').style.display = "none";
}
}
function exit_focus(M)
{
if(M == 'password')
{
if(document.getElementById('gn_account_password').type == "password")
document.getElementById('pwd_see_close').style.display = "";
else
document.getElementById('pwd_see_open').style.display = "";     
}
else
{
if(document.getElementById('_cm_hnd_unblock_password').type == "password")
document.getElementById('cpwd_see_close').style.display = "";
else
document.getElementById('cpwd_see_open').style.display = "";
}
}
function display_pwd(I,M)
{
if(I == "open")
{
if(M == "password")
{
document.getElementById('gn_account_password').type = "password";
document.getElementById('pwd_see_close').style.display = "";
document.getElementById('pwd_see_open').style.display = "none";
}
else
{
document.getElementById('_cm_hnd_unblock_password').type = "password";
document.getElementById('cpwd_see_close').style.display = "";
document.getElementById('cpwd_see_open').style.display = "none";        
}
}
else
{
if(M == "password")
{
document.getElementById('gn_account_password').type = "text";
document.getElementById('pwd_see_close').style.display = "none";
document.getElementById('pwd_see_open').style.display = "";
}
else
{
document.getElementById('_cm_hnd_unblock_password').type = "text";
document.getElementById('cpwd_see_close').style.display = "none";
document.getElementById('cpwd_see_open').style.display = "";
}
}
}
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
return false;
else
return true;
}
function check_gn_passwd()
{
var re = new RegExp("[^a-zA-Z0-9]+","gi");
if(re.test(document.forms[0].gn_account_password.value)
|| document.forms[0].gn_account_password.value.length < 4)
{
document.getElementById("errmsg1").innerHTML = "<font color=red face='Arial' style='font-size: 8pt'>" +pctrl.pwderrmsg1 + "</font>";
return 1;
}
return 0;
}
function to_submit(F)
{
if(check_gn_passwd() == 1)
return;
parent.Change_gn_password(F.gn_account_password.value);
closePopout();
}
function init()
{
var close_session = "<% get_session_status(); %>";
if ( close_session == "1" )
{
document.forms[0].action= "apply.cgi";
}
else
{
document.forms[0].action= "apply.cgi?session_id=<% nvram_get("session_key"); %>";
}
}
</SCRIPT>
</HEAD>
<BODY bgColor="#808080" onload="init()">
<CENTER>
<FORM method="<% get_http_method(); %>" name="GuestpasswordInput" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<script>var PopTitle = newui.chggnpwd;</script>
<% web_include_file("pop_Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td><b><script>Capture(newui.engnpwd)</script></b></td>
</tr>
<tr>
<td>
<div class="gatxt-div">
<img src="image/eye_close.png" class="gatxtimg" id="pwd_see_close" onclick="display_pwd('close','password')" />
<img src="image/eye.png" class="gatxtimg" onclick="display_pwd('open','password')" id="pwd_see_open" style="display: none"/>
<input type="password" name="gn_account_password" maxlength="32" id="gn_account_password" class="gatxt-style" value="" />
</div>
</td>
</tr>
<tr>
<td><script>Capture(pctrl.rngchar)</script></td>
</tr>
<tr>
<td><span id="errmsg1">&nbsp;</span></td>
</tr>
</tbody>
</table>
<% web_include_file("pop_Bottom.asp"); %>
</FORM></CENTER></BODY></HTML>
