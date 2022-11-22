<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Password</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
save:   true,
cancel: true
});
document.title = adtopmenu.passwd;
var close_session = "<% get_session_status(); %>";
var EN_DIS1 = '<% nvram_get("remote_management"); %>'	
var wan_proto = '<% nvram_get("wan_proto"); %>'
var snmp_confirm = 0
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
if(document.getElementById('http_passwd').type == "password")
document.getElementById('pwd_see_close').style.display = "";
else
document.getElementById('pwd_see_open').style.display = "";	
}
else
{
if(document.getElementById('http_passwdConfirm').type == "password")
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
document.getElementById('http_passwd').type = "password";
document.getElementById('pwd_see_close').style.display = "";
document.getElementById('pwd_see_open').style.display = "none";
}
else
{
document.getElementById('http_passwdConfirm').type = "password";
document.getElementById('cpwd_see_close').style.display = "";
document.getElementById('cpwd_see_open').style.display = "none";	
}
}
else
{
if(M == "password")
{
document.getElementById('http_passwd').type = "text";
document.getElementById('pwd_see_close').style.display = "none";
document.getElementById('pwd_see_open').style.display = "";
}
else
{
document.getElementById('http_passwdConfirm').type = "text";
document.getElementById('cpwd_see_close').style.display = "none";
document.getElementById('cpwd_see_open').style.display = "";
}
}
}
function valid_password(F)
{
if (F.http_passwd.value != F.http_passwdConfirm.value)
{	
alert(manage2.vapass);
F.http_passwdConfirm.focus();
F.http_passwdConfirm.select();
return false;
}
return true;
}
function valid_value(F)
{
if( F.http_passwd.value != F.http_passwdConfirm.value )
{
alert(manage2.passnot);
return false;
}
else if( snmp_confirm == 1 )
{	
alert(errmsg.err91);
snmp_confirm = 0;
return false;
}
else
F.gui_action.value='Apply';
valid_password(F);
return true;
}
function to_submit(F)
{
for(i=0 ; i<F.http_passwd.value.length; i++){
ch = F.http_passwd.value.charAt(i);
if(ch < ' ' || ch > '~'){
alert(errmsg.err29);
F.http_passwd.value = F.http_passwd.defaultValue;
F.http_passwd.focus();
return false;
}
}
for(i=0 ; i<F.http_passwdConfirm.value.length; i++){
ch = F.http_passwdConfirm.value.charAt(i);
if(ch < ' ' || ch > '~'){
alert(errmsg.err29);
F.http_passwdConfirm.value = F.http_passwdConfirm.defaultValue;
F.http_passwdConfirm.focus();
return false;
}
}
if(F.http_passwd.value.indexOf(' ') != -1  || F.http_passwdConfirm.value.indexOf(' ') != -1)
{
if(F.http_passwd.value.indexOf(' ') != -1)
{
alert(errmsg.err11);
F.http_passwd.value = F.http_passwd.defaultValue;
F.http_passwd.focus();
}
else
{
alert(errmsg.err11);
F.http_passwdConfirm.value = F.http_passwdConfirm.defaultValue;
F.http_passwdConfirm.focus();
}
return false;
}
if(valid_value(F)) {
/*
if(F._tmsss_enable[0].checked == true)	F.tmsss_enabled.value = 1;
else					F.tmsss_enabled.value = 0;
*/
/*Jemmy add CTF 2010.9.07*/
/*
if ((F.ctf_disable[0].checked == true && ctf == '1')
||(F.ctf_disable[1].checked == true && ctf == '0'))
{
F.need_reboot.value = "1";
F.wait_time.value = "40";
}
*/
F.submit_button.value = "Management";
ajaxSubmit(password,"false");
}
}
function to_restore(F)
{
if ( close_session == "1" )
{
self.open('Restore.asp','Restore','alwaysRaised,resizable,scrollbars,width=600,height=440').focus();
}
else
{
self.open('Restore.asp?session_id=<% nvram_get("session_key"); %>','Restore','alwaysRaised,resizable,scrollbars,width=600,height=440').focus();
}
}
function handle_http(F)
{
return ;
if(F._http_enable.checked == false && F._https_enable.checked == true) {
F._remote_mgt_https[0].checked = false;
F._remote_mgt_https[1].checked = true;
}
}
function handle_https(F)
{
return ;
if(F._http_enable.checked == true && F._https_enable.checked == false) {
F._remote_mgt_https[0].checked = true;
F._remote_mgt_https[1].checked = false;
}
}
function handle_http_rmt(F)
{
if(F._remote_mgt_https[1].checked == true)	F.remote_mgt_https.value = 1;
else					F.remote_mgt_https.value = 0;
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
setInitFormData(function(){
to_submit(document.forms[0])
});
}
</SCRIPT>
</HEAD>
<BODY vLink="#b5b5e6" aLink="#ffffff" link="#b5b5e6" onload="init()" onbeforeunload = "return checkFormChanged(document.password)">
<FORM name="password" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" />
<!--input type="hidden" name="tmsss_enabled"-->
<input type="hidden" name="wait_time" value="4" />
<input type="hidden" name="need_reboot" value="0" />
<% web_include_file("Top.asp"); %>
<table class="table table-info">
<tbody>
<% support_invmatch("DDM_SUPPORT", "1", "<!--"); %>
<tr>
<td>
<input type="text" maxLength="63" size="20" value="<% nvram_get("http_username"); %>" name="http_username" onBlur="valid_name(this,'Account',SPACE_NO)" />
</td>
</tr>
<% support_invmatch("DDM_SUPPORT", "1", "-->"); %>
<tr>
<td><script>Capture(adleftmenu.routerpsw)</script></td>
<td>
<div class="txt-div">
<img src="image/eye_close.png" class="txtimg" id="pwd_see_close" onclick="display_pwd('close','password')" />
<img src="image/eye.png" class="txtimg" onclick="display_pwd('open','password')" id="pwd_see_open" style="display: none"/>
<input type="password" maxLength="63" class="txt-style" value="<% nvram_get("http_passwd"); %>" name="http_passwd" id="http_passwd" onBlur="exit_focus('password')" onfocus="block_image('password')"/>
</div>
</td>
</tr>
<tr>
<td><script>Capture(mgt.reconfirm)</script></td>
<td>
<div class="txt-div">
<img src="image/eye_close.png" class="txtimg" id="cpwd_see_close" onclick="display_pwd('close','Cpassword')" />
<img src="image/eye.png" class="txtimg" onclick="display_pwd('open','Cpassword')" id="cpwd_see_open" style="display: none"/>
<input type="password" maxLength="63" class="txt-style" value="<% nvram_get("http_passwd"); %>"  name="http_passwdConfirm" id="http_passwdConfirm" onBlur="exit_focus('Cpassword')" onfocus="block_image('Cpassword')"/>
</div>
</td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
