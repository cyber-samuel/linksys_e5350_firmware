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
</STYLE>
<SCRIPT language=javascript>
setFormActions({
'wlanwscpopup.button':    'javascript:to_submit(document.PC_reset_passwd)',
'wlanwscpopup.btncancel':  'javascript:closePopout()'
});
document.title = "PC reset passwd";
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
function check_hnd_passwd()
{
if(document.forms[0]._hnd_unblock_password.value != document.forms[0]._cm_hnd_unblock_password.value)
{
document.getElementById("errmsg1").innerHTML = pctrl.pwderrmsg2;
if(document.forms[0].hnd_question.value.length == 0 || document.forms[0].hnd_answer.value.length == 0)
{
document.getElementById("errmsg3").innerHTML = pctrl.pwderrmsg3;
}
else
document.getElementById("errmsg3").innerHTML = "";
return 1;
}
else
document.getElementById("errmsg1").innerHTML = "";
var re = new RegExp("[^a-zA-Z0-9]+","gi");
if(re.test(document.forms[0]._hnd_unblock_password.value)
|| re.test(document.forms[0]._cm_hnd_unblock_password.value)
|| document.forms[0]._hnd_unblock_password.value.length <4
|| document.forms[0]._cm_hnd_unblock_password.value.length < 4)
{
document.getElementById("errmsg1").innerHTML = pctrl.pwderrmsg1;
if(document.forms[0].hnd_question.value.length == 0 || document.forms[0].hnd_answer.value.length == 0)
{
document.getElementById("errmsg3").innerHTML = pctrl.pwderrmsg3;
}
else
document.getElementById("errmsg3").innerHTML = "";
return 1;
}
else
document.getElementById("errmsg1").innerHTML = "";
if(document.forms[0].hnd_question.value.length == 0 || document.forms[0].hnd_answer.value.length == 0)
{
document.getElementById("errmsg3").innerHTML = pctrl.pwderrmsg3;
return 1;
}
else
document.getElementById("errmsg3").innerHTML = "";
return 0;
}
function to_submit(F)
{
if(check_hnd_passwd() == 1)
return;
showWait("0",true);
F.submit_button.value = "pc_reset_passwd";
F.submit_type.value = "pc_reset_passwd";
F.change_action.value = "gozila_cgi";
F.submit();
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
<FORM name="PC_reset_passwd" action="apply.cgi" onSubmit="return false;" method="<% get_http_method(); %>">
<input type="hidden" name="submit_button" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="wait_time" value="3" />
<script>var PopTitle = pctrl.pcontrol;</script>
<% web_include_file("pop_Top.asp"); %>
<div style="overflow-x:auto;height:420px;">
<table class="table table-info">
<tbody>
<tr>
<td colspan="2"><script>Capture(pctrl.newpwd)</script></td>
</tr>
<tr>
<td><script>Capture(pctrl.pcpwd)</script>:</td>
<td>
<div class="pctxt-div">
<img src="image/eye_close.png" class="pctxtimg" id="pwd_see_close" onclick="display_pwd('close','password')" />
<img src="image/eye.png" class="pctxtimg" onclick="display_pwd('open','password')" id="pwd_see_open" style="display: none"/>
<input maxlength="32"  name="_hnd_unblock_password" type="password" class="pctxt-style" id="_hnd_unblock_password" onBlur="exit_focus('password')" onfocus="block_image('password')"/>
<p><script>Capture(pctrl.rngchar)</script></p>
</div>
</td>
</tr>
<tr>
<td><script>Capture(pctrl.vfpwd)</script>:</td>
<td>
<div class="pctxt-div">
<img src="image/eye_close.png" class="pctxtimg" id="cpwd_see_close" onclick="display_pwd('close','Cpassword')" />
<img src="image/eye.png" class="pctxtimg" onclick="display_pwd('open','Cpassword')" id="cpwd_see_open" style="display: none"/>
<input maxlength="32"  name="_cm_hnd_unblock_password" type="password" class="pctxt-style" id="_cm_hnd_unblock_password" onBlur="exit_focus('Cpassword')" onfocus="block_image('Cpassword')"/>
</div>
</td>
</tr>
<tr>
<td>&nbsp;</td>
<td><span class="error" id="errmsg1"></span></td>
</tr>
</tbody>
</table>
<table class="table table-info">
<tbody>
<tr>
<td colspan="2"><script>Capture(pctrl.newqa)</script></td>
</tr>
<tr>
<td><script>Capture(pctrl.sqst)</script>:</td>
<td>
<input maxlength="64" style="width:180px" name="hnd_question" value="<% nvram_get_sp("hnd_question");%>" />
</td>
</tr>
<tr>
<td><script>Capture(pctrl.asw)</script>:</td>
<td>
<input maxlength="32" style="width:180px" name="hnd_answer" value="<% nvram_get_sp("hnd_answer");%>" />
</td>
</tr>
<tr>
<td>&nbsp;</td>
<td><span class="error" id="errmsg3"></span></td>
</tr>
</tbody>
</table>
<% web_include_file("pop_Bottom.asp"); %>
</div>
</FORM></BODY></HTML>
