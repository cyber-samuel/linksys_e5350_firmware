<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>>
<HEAD>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<SCRIPT language="Javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capsec.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/share.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/help.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capapp.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capasg.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capsetup.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capwrt54g.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capstatus.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/layout.js"></SCRIPT>
<SCRIPT language="javascript">
setFormActions({
'hndmsg.wtpBack': 'javascript:goto_back()',
'wiz.next': 'javascript:goto_next()',
'portsrv.cancel': 'javascript:goto_cancel()'
});
document.title = wiz.netwlnetset;
var wizard_proto = "<% nvram_get("wizard_proto"); %>";
function set_parentvalue()
{
document.wireless_set.wl0_ssid.value=window.parent.document.getElementById("wizard_wl0_ssid").value;
document.wireless_set.wl1_ssid.value=window.parent.document.getElementById("wizard_wl1_ssid").value;
document.wireless_set.wl0_passwd.value=window.parent.document.getElementById("wizard_wl0_passwd").value;
document.wireless_set.wl1_passwd.value=window.parent.document.getElementById("wizard_wl1_passwd").value;
}
function goto_back()
{
showWait();
var F = document.wireless_set,
link = '';
if ( wizard_proto == "PPPOE" )
link = "/wizard/set_pppoe.asp";
else
link = "/wizard/index.asp";
if ( close_session != "1" )
link += "?session_id=" + session_key;
document.location.replace(link);
}
function goto_cancel()
{	
var F = document.wireless_set;
if (confirm(wiz.exitwarnmsg))
{
showWait();
F.submit_button.value = "setup_wizard";
F.submit_type.value="finish";
F.next_page.value="wizard/unfinished.asp";
F.change_action.value = "gozila_cgi";
F.submit();
}
}
function isxdigit1(I,M)
{
for(i=0 ; i<I.value.length; i++){
ch = I.value.charAt(i).toLowerCase();
if(ch >= '0' && ch <= '9' || ch >= 'a' && ch <= 'f'){}
else
{
alert(M + errmsg2.err4);
I.value = I.defaultValue;	
return false;
}
}
return true;
}
function valid_wpa_psk_0(F, flag)
{
F.wl0_passwd.value = F.wl0_passwd.value.replace(/^\s+/, "").replace(/\s+$/, "");
if(F.wl0_passwd.value == ""){                   
alert(wiz.wirelessPasswd24);
F.wl0_passwd.focus();
return false;
}
if(F.wl0_passwd.value.length == 64){
if(!isxdigit1(F.wl0_passwd, "2.4 GHz " + share.passwd)) return false;
}	
else if(F.wl0_passwd.value.length >=8 && F.wl0_passwd.value.length <= 63 ){
if(!isascii(F.wl0_passwd, "2.4 GHz " + share.passwd)) return false;
}
else{
alert(errmsg2.err5);
F.wl0_passwd.focus();
return false;
} 
if(flag & SPACE_NO){
if(!check_space(F.wl0_passwd, "2.4 GHz " + share.passwd)) return false;
}
return true;	
}
function valid_wpa_psk_1(F, flag)
{
F.wl1_passwd.value = F.wl1_passwd.value.replace(/^\s+/, "").replace(/\s+$/, "");
if(F.wl1_passwd.value == ""){                   
alert(wiz.wirelessPasswd5);
F.wl1_passwd.focus();
return false;
}
if(F.wl1_passwd.value.length == 64){
if(!isxdigit1(F.wl1_passwd, "5 GHz " + share.passwd)) return false;
}	
else if(F.wl1_passwd.value.length >=8 && F.wl1_passwd.value.length <= 63 ){
if(!isascii(F.wl1_passwd, "5 GHz " + share.passwd)) 
return false;
}
else{
alert(errmsg2.err5);
F.wl1_passwd.focus();
return false;
}
if(flag & SPACE_NO){
if(!check_space(F.wl1_passwd, "5 GHz "+share.passwd)) return false;
} 
return true;	
}
function goto_next()
{	
var F=document.wireless_set;
F.wl0_ssid.defaultValue = F.wl0_ssid.value;
F.wl1_ssid.defaultValue = F.wl1_ssid.value;
F.wl1_passwd.defaultValue = F.wl1_passwd.value;
F.wl0_passwd.defaultValue = F.wl0_passwd.value;
if ( F.wl0_ssid.value.length > 32)
{
alert(wiz.network);
F.wl0_ssid.focus();
return;
}
if(!wz_valid_name(F.wl0_ssid, "2.4 GHz " + wiz.networkname))
return; 
if(F.wl0_ssid.value == ""){
alert(wiz.netmsg1);
F.wl0_ssid.focus();
return;
}
if ( F.wl1_ssid.value.length > 32 )
{
alert(wiz.network1);
F.wl1_ssid.focus();
return;
}
if(!wz_valid_name(F.wl1_ssid, "5 GHz " + wiz.networkname))
return; 
if(F.wl1_ssid.value == ""){
alert(wiz.netmsg2);
F.wl1_ssid.focus();
return;
}
if ( valid_wpa_psk_0(F) && valid_wpa_psk_1(F) )
{
window.parent.document.getElementById("wizard_wl0_ssid").value = F.wl0_ssid.value;
window.parent.document.getElementById("wizard_wl0_passwd").value = F.wl0_passwd.value;
window.parent.document.getElementById("wizard_wl1_ssid").value = F.wl1_ssid.value;
window.parent.document.getElementById("wizard_wl1_passwd").value = F.wl1_passwd.value;
showWait();
if ( close_session == "1" )
document.location.replace("/wizard/create_pwd.asp");
else
document.location.replace("/wizard/create_pwd.asp?session_id="+session_key);
}
}
</SCRIPT>
</HEAD>
<BODY onload="set_parentvalue();displayWizard();page_load();alignright('arRight')">
<form method="<% get_http_method(); %>" action="/apply.cgi" name="wireless_set">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="next_page" />
<% web_include_file("wizard/wizard_Top.asp"); %>
<div id=arRight>
<div class="wiz-content-title"><script>Capture(wiz.netwilset)</script></div>
<div class="wiz-content-text"><script>Capture(wiz.netmsg5)</script></div>
<!-- <div class="wiz-content-text"><script>Capture(wiz.msg3)</script></div> -->
<table class="table table-info">
<tbody>
<tr>
<td>2.4 GHz <script>Capture(wiz.networkname)</script></td>
<td>
<input type="text" maxlength="32" size="32" name="wl0_ssid" />
<br />
<script>Capture(wiz.netmsg6)</script>
</td>
</tr>
<tr>
<td>2.4 GHz <script>Capture(share.passwd)</script></td>
<td>
<input type="text" maxlength="64" size="32" name="wl0_passwd" />
<br />
<script>Capture(wiz.netmsg7)</script>
</td>
</tr>
<tr>
<td>5 GHz <script>Capture(wiz.networkname)</script></td>
<td>
<input type="text" maxlength="32" size="32" name="wl1_ssid" />
<br />
<script>Capture(wiz.netmsg6)</script>
</td>
</tr>
<tr>
<td>5 GHz <script>Capture(share.passwd)</script></td>
<td>
<input type="text" maxlength="64" size="32" name="wl1_passwd" />
<br />
<script>Capture(wiz.netmsg7)</script>
</td>
</tr>
</tbody>
</table>
</div>
<% web_include_file("wizard/wizard_Bottom.asp"); %>
</FORM></BODY></HTML>
