<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>List of PCs</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("pop_filelink.asp"); %>
<SCRIPT language="Javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capsec.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/share.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/help.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capapp.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capasg.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capwrt54g.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capsetup.js"></SCRIPT>
<STYLE type=text/css>
a{text-decoration:none}
BORDER-LEFT-STYLE: solid;
BORDER-LEFT-WIDTH: 1;
BORDER-RIGHT-STYLE: solid;
BORDER-RIGHT-WIDTH: 1;
BORDER-TOP-STYLE: solid;
BORDER-TOP-WIDTH: 1;
BORDER-BOTTOM-STYLE: none;
BORDER-BOTTOM-WIDTH: medium;
BORDER-COLOR: #2971b9;
HEIGHT: 25px
}
.field2{
BORDER-BOTTOM-STYLE: none;
BORDER-BOTTOM-WIDTH: medium;
BACKGROUND-COLOR: #E7E7E7;
HEIGHT: 25px
}
A:link#QA { COLOR:#2971b9 }
A:visited#QA { COLOR:#2971b9 }
A:hover#QA { COLOR:#00ffff }
</STYLE>
<SCRIPT language=javascript>
setFormActions({
'wlanwscpopup.button':    'javascript:to_submit(document.PC_passwd)',
'wlanwscpopup.btncancel':  'javascript:closePopout()'
});
document.title = "PC passwd";
var close_session = "<% get_session_status(); %>";
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
if(document.getElementById('_hnd_unblock_password').type == "password")
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
document.getElementById('_hnd_unblock_password').type = "password";
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
document.getElementById('_hnd_unblock_password').type = "text";
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
function to_submit(F)
{
showWait("0",true);
F.submit_button.value = "pc_passwd";
F.submit_type.value = "pc_passwd_au";
F.change_action.value = "gozila_cgi";
F.submit();
}
function to_fogpwd()
{
if ( close_session == "1" )
{
parent.showPopout('PC_QandA.asp', '600px');
return;
}
else{
parent.showPopout('PC_QandA.asp?session_id=<% nvram_get("session_key"); %>', '600px');
return;
}
if ( close_session == "1" )
{
document.location.replace("PC_QandA.asp");
}
else
{
document.location.replace("PC_QandA.asp?session_id=<% nvram_get("session_key"); %>");
}
}
function init()
{
displayPopout();
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
<FORM name="PC_passwd" action="apply.cgi" method="<% get_http_method(); %>" onSubmit="return false;">
<input type="hidden" name="submit_button" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="wait_time" value="3" />
<script>var PopTitle = pctrl.pcontrol;</script>
<% web_include_file("pop_Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(pctrl.enpwd)</script>:</td>
</tr>
<tr>
<td>
<div class="pcpwdtxt-div">
<img src="image/eye_close.png" class="pcpwdtxtimg" id="pwd_see_close" onclick="display_pwd('close','password')" />
<img src="image/eye.png" class="pcpwdtxtimg" onclick="display_pwd('open','password')" id="pwd_see_open" style="display: none"/>
<input maxlength="32"  name="_hnd_unblock_password" class="pcpwdtxt-style" type="password" id="_hnd_unblock_password" onBlur="exit_focus('password')" onfocus="block_image('password')"/>
</div>
</td>
</tr>
<tr>
<td><a id="QA" href="javascript:to_fogpwd()"><script>Capture(pctrl.fogpwd)</script></a></td>
</tr>
<tr>
<td class="error">
<script>
var deny = "<%nvram_get("pc_passwd_deny");%>";
if(deny == "1")
Capture(hndmsg.errpwd)
</script>
</td>
</tr>
</tbody>
</table>
<% web_include_file("pop_Bottom.asp"); %>
</FORM></BODY></HTML>
