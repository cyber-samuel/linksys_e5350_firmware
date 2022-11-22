<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Management</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
save:   true,
cancel: true
});
document.title = adtopmenu.manage;
var close_session = "<% get_session_status(); %>";
var EN_DIS1 = '<% nvram_get("remote_management"); %>'	
var wan_proto = '<% nvram_get("wan_proto"); %>'
var snmp_confirm = 0
function valid_range2(I,start,end,M, idx)
{
if (M=="IP")
{
if (I.value == "0" || I.value == "")
return true;
}
return valid_rangeNEW(I,start,end,M);
}
function PasswdLen(F)
{
var sLen = F.snmpv3_passwd.value;
if( sLen.length < 8 )
{
F.snmpv3_passwd.value = F.snmpv3_passwd.defaultValue;
alert(errmsg.err90);
}
if( F.snmpv3_passwd.value != F.SnmpPasswdConfirm.value )
{
snmp_confirm = 1;
}
else 
{
snmp_confirm = 0;
}
}
function ConfirmPasswd(F)
{
if( F.snmpv3_passwd.value != F.SnmpPasswdConfirm.value )
{
snmp_confirm = 1;
}
}
function SelRmt(num,F)
{
if(F._remote_management.checked) {
if(F.PasswdModify.value == 1)
if(ChangePasswd(F) == false){
return;}
choose_enable(F._remote_mgt_https[0]);
choose_enable(F._remote_mgt_https[1]);
choose_enable(F._remote_upgrade);
choose_enable(F.remote_ip_any[0]);
choose_enable(F.remote_ip_any[1]);
if(F.remote_ip_any[0].checked == true)
SelIP(0,F);
else
SelIP(1,F);
choose_enable(F.http_wanport);
}
else {
choose_disable(F._remote_mgt_https[0]);
choose_disable(F._remote_mgt_https[1]);
choose_disable(F._remote_upgrade);
choose_disable(F.remote_ip_any[0]);
choose_disable(F.remote_ip_any[1]);
SelIP(0,F);
choose_disable(F.http_wanport);
}
update_checked(F._remote_management);
}
function SelIP(num,F)
{
if(num == 1) {
choose_enable(F.remote_ip_0);
choose_enable(F.remote_ip_1);
choose_enable(F.remote_ip_2);
choose_enable(F.remote_ip_3);
choose_enable(F.remote_ip_4);
}
else {
choose_disable(F.remote_ip_0);
choose_disable(F.remote_ip_1);
choose_disable(F.remote_ip_2);
choose_disable(F.remote_ip_3);
choose_disable(F.remote_ip_4);
}
}
function SelUPNP(num,F)
{
if(num == 1) {
choose_enable(F.upnp_config[0]);
choose_enable(F.upnp_config[1]);
choose_enable(F.upnp_internet_dis[0]);
choose_enable(F.upnp_internet_dis[1]);
}
else {
choose_disable(F.upnp_config[0]);
choose_disable(F.upnp_config[1]);
choose_disable(F.upnp_internet_dis[0]);
choose_disable(F.upnp_internet_dis[1]);
}
}
function ChangePasswd(F)
{
if((F.PasswdModify.value==1 && F.http_passwd.value == "d6nw5v1x2pc7st9m") || F.http_passwd.value == "admin")
{	
if(confirm(manage2.changpass))
{
F.http_passwd.focus();
F._remote_management.checked = false;
choose_disable(F._remote_mgt_https[0]);
choose_disable(F._remote_mgt_https[1]);
choose_disable(F._remote_upgrade);
choose_disable(F.remote_ip_any[0]);
choose_disable(F.remote_ip_any[1]);
SelIP(0,F);
choose_disable(F.http_wanport);
return false;
}
else {
F._remote_management.checked = false;
choose_disable(F._remote_mgt_https[0]);
choose_disable(F._remote_mgt_https[1]);
choose_disable(F._remote_upgrade);
choose_disable(F.remote_ip_any[0]);
choose_disable(F.remote_ip_any[1]);
SelIP(0,F);
choose_disable(F.http_wanport);
return false;
}
}
else {
return true;}
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
/*if( F.http_passwd.value != F.http_passwdConfirm.value )
{
alert(F.http_passwd.value);	
alert(F.http_passwdConfirm.value);
alert(manage2.passnot);
return false;
}*/
if( snmp_confirm == 1 )
{	
alert(errmsg.err91);
snmp_confirm = 0;
return false;
}
else
F.gui_action.value='Apply';
if(F._remote_management.checked == true){
if(!ChangePasswd(F))
return false;
}
if(F._http_enable.checked == false && F._https_enable.checked == false)
{
alert(manage2.selweb);
return false;
}
if(F._remote_management.checked == true){
if(F.remote_ip_any[1].checked == true){
if(F.remote_ip_0.value == "0" || F.remote_ip_0.value == "" )
{
alert(errmsg.err14 + '['+ 1 + ' - ' + 254 +'].');
F.remote_ip_0.focus();
F.remote_ip_0.value = F.remote_ip_0.defaultValue;
return false;	
}
if(F.remote_ip_1.value == "") 
{
alert(errmsg.err14 + '['+ 0 + ' - ' + 255 +'].');
F.remote_ip_1.focus();
F.remote_ip_1.value = F.remote_ip_1.defaultValue;      
return false;
} 
if(F.remote_ip_2.value == "") 
{
alert(errmsg.err14 + '['+ 0 + ' - ' + 255 +'].');
F.remote_ip_2.focus();
F.remote_ip_2.value = F.remote_ip_2.defaultValue;      
return false;
} 
if(F.remote_ip_3.value == "0" || F.remote_ip_3.value == "") 
{
alert(errmsg.err14 + '['+ 1 + ' - ' + 254 +'].');
F.remote_ip_3.focus();
F.remote_ip_3.value = F.remote_ip_3.defaultValue;      
return false;
} 
if(F.remote_ip_4.value == "" || F.remote_ip_4.value == "0") 
{
alert(errmsg.err14 + '['+ 1 + ' - ' + 254 +'].');
F.remote_ip_4.focus();
F.remote_ip_4.value = F.remote_ip_4.defaultValue;      
return false;
}
if(parseInt(F.remote_ip_3.value) > parseInt(F.remote_ip_4.value)) {
alert(errmsg.err51);
F.remote_ip_4.focus();
return false;
}
}
}
if(F._remote_management.checked == true){
if(F._remote_mgt_https[0].checked == true && F._http_enable.checked == false) {
alert(errmsg.err60);
return false;		
}
if(F._remote_mgt_https[1].checked == true && F._https_enable.checked == false) {
alert(errmsg.err61);
return false;		
}
}
return true;
}
function to_submit(F)
{
var url;
var lanip = '<% nvram_get("lan_ipaddr"); %>';
if(!valid_range(F.http_wanport,1,65535,'Port%20number'))
{
F.http_wanport.focus();
return;
}
/*Wenxuan add edge need*/
var userAgent = navigator.userAgent;
var isEdge = userAgent.indexOf("Edge") > -1;
var isFF = userAgent.indexOf("Firefox") > -1;
if(isEdge || isFF)
{
if(!valid_range2(F.remote_ip_0,1,223,'IP') || !valid_range2(F.remote_ip_1,0,255,'IP') || !valid_range2(F.remote_ip_2,0,255,'IP') || !valid_range2(F.remote_ip_3,1,254,'IP') || !valid_range2(F.remote_ip_4,1,254,'IP') || !valid_range(F.http_wanport,1,65535,'Port%20number'))
return;
}
/*Wenxuan add edge need*/
if(valid_value(F)) {
if(F._web_wl_filter.checked == true) 	F.web_wl_filter.value = "0";
else					F.web_wl_filter.value = "1";
if(F._remote_management.checked == true) F.remote_management.value = "1";
else					 F.remote_management.value = "0";
if(F._remote_upgrade.checked == true)	F.remote_upgrade.value = "1";
else					F.remote_upgrade.value = "0";
if(F._http_enable.checked == true)	F.http_enable.value = 1;
else					F.http_enable.value = 0;
if(F._https_enable.checked == true)	F.https_enable.value = 1;
else					F.https_enable.value = 0;
if(F._remote_mgt_https[1].checked == true)	F.remote_mgt_https.value = 1;
else					F.remote_mgt_https.value = 0;
<% support_invmatch("CUSTOM404_SUPPORT", "1", "/*"); %>
if(F._ctm404_enable[0].checked == true)	F.ctm404_enable.value = 1;
else					F.ctm404_enable.value = 0;
<% support_invmatch("CUSTOM404_SUPPORT", "1", "*/"); %>
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
if(F.http_enable.value == 1 && F.https_enable.value == 0)
{
url = "http://"+lanip+"/remote_Management.asp?session_id=<% nvram_get("session_key"); %>";
ajaxSubmit(10,"true",url);
}
if(F.https_enable.value == 1 && F.http_enable.value == 0)
{
url = "https://"+lanip+"/remote_Management.asp?session_id=<% nvram_get("session_key"); %>";
ajaxSubmit(10,"true",url);
}
if(F.http_enable.value == 1 && F.https_enable.value == 1)
ajaxSubmit(5,"false");
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
SelRmt('<% nvram_get("remote_management"); %>',document.password);
var http_from = "<% nvram_get("http_from"); %>";
update_checked(document.password._remote_management);
if(http_from == "wan") {
choose_disable(document.password._remote_upgrade);
}
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
<BODY vLink="#b5b5e6" aLink="#ffffff" link="#b5b5e6" onload="init()" >
<FORM name="password" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" />
<INPUT type="hidden" name="PasswdModify" value="<% nvram_else_match("http_passwd", "admin", "1", "0"); %>" />
<input type="hidden" name="http_passwd" value="<% nvram_get("http_passwd"); %>"/>
<input type="hidden" name="http_passwdConfirm" value="<% nvram_get("http_passwdConfirm"); %>"/>
<input type="hidden" name="web_wl_filter" />
<input type="hidden" name="remote_management" />
<input type="hidden" name="remote_upgrade" />
<input type="hidden" name="remote_mgt_https" />
<input type="hidden" name="http_enable" />
<input type="hidden" name="https_enable" />
<input type="hidden" name="ctm404_enable" />
<!--input type="hidden" name="tmsss_enabled"-->
<!--<input type="hidden" name="remote_mgt_https" />
<input type="hidden" name="remote_ip_any" /> -->
<input type="hidden" name="wait_time" value="4" />
<input type="hidden" name="need_reboot" value="0" />
<% web_include_file("Top.asp"); %>
<table class="table table-info">
<tbody>
<tr >
<td style="width:50%">
<script>Capture(share.warning)</script>
<a href="admin_password.asp?session_id=<% nvram_get("session_key"); %>"><script>Capture(share.warning1)</script></a>
<script>Capture(share.warning2)</script>
</td>
<td style="text-align: center"><img src="image/attention.png" /></td>	
</tr>
</tbody>
</table>
<script>draw_table(MAINFUN2,manage2.webacc);</script>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(manage2.webutiacc)</script></td>
<td>
<script>draw_checkbox('_http_enable', 'HTTP', '1', 'handle_http(this.form)' <% nvram_match("http_enable","1",", 1"); %>);</script>
<script>draw_checkbox('_https_enable', 'HTTPS', '1', 'handle_https(this.form)' <% nvram_match("https_enable","1",", 1"); %>);</script>
</td>
</tr>
<tr>
<td>
<!--		<script>draw_radio('web_wl_filter', share.enabled, '0', '' <% nvram_match("web_wl_filter","0",", 0"); %>);</script>
<script>draw_radio('web_wl_filter', share.disabled, '1', '' <% nvram_match("web_wl_filter","1",", 0"); %>);</script>		--!>
<script>draw_checkbox('_web_wl_filter', manage2.wlutiacc, '0', '' <% nvram_match("web_wl_filter","0",", 1"); %>);</script>
</td>
</tr>
</tbody>
</table>
<script>draw_table(MAINFUN2,adleftmenu.remoteaccess);</script>
<table class="table table-info">
<tbody>
<tr>
<td>
<!--	<script>draw_radio('remote_management', share.enabled, '1', 'SelRmt(1,this.form)' <% nvram_match("remote_management","1",", 0"); %>);</script>
<script>draw_radio('remote_management', share.disabled, '0', 'SelRmt(0,this.form)' <% nvram_match("remote_management","0",", 0"); %>);</script>  --!>
<script>draw_checkbox('_remote_management', mgt.remotemgt, '1', 'SelRmt(1,this.form)' <% nvram_match("remote_management","1",", 1"); %>);</script>
</td>
</tr>
<tr>
<td><script>Capture(manage2.webutiacc)</script></td>
<td>
<script>draw_radio('_remote_mgt_https', 'HTTP', '0', 'handle_http_rmt(this.form)' <% nvram_match("remote_mgt_https","0",", 0"); %>);</script>
<script>draw_radio('_remote_mgt_https', 'HTTPS', '1', 'handle_http_rmt(this.form)' <% nvram_match("remote_mgt_https","1",", 0"); %>);</script>
</td>
</tr>
<tr>
<td>
<!--		<script>draw_radio('remote_upgrade', share.enabled, '1', '' <% nvram_match("remote_upgrade","1",", 0"); %>);</script>
<script>draw_radio('remote_upgrade', share.disabled, '0', '' <% nvram_match("remote_upgrade","0",", 0"); %>);</script>		--!>
<script>draw_checkbox('_remote_upgrade', mgt.remoteupgrade, '1', '' <% nvram_match("remote_upgrade","1",", 1"); %>);</script>
</td>
</tr>
<tr>
<td><script>Capture(mgt.remoteip)</script></td>
<td>
<script>draw_radio('remote_ip_any', mgt.anyip, '1', 'SelIP(0,this.form)' <% nvram_match("remote_ip_any","1",", 0"); %>);</script>
</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>
<script>draw_radio('remote_ip_any', '', '0', 'SelIP(1,this.form)' <% nvram_invmatch("remote_ip_any","1",", 0"); %>);</script>
<input type="text" class="num" maxLength="3" onBlur="valid_range2(this,1,223,'IP')" style="width:40px" value="<% get_single_ip("remote_ip","0"); %>" name="remote_ip_0" id="remote_ip_0"/>&nbsp;.
<input type="text" class="num" maxLength="3" onBlur="valid_range2(this,0,255,'IP')" style="width:40px" value="<% get_single_ip("remote_ip","1"); %>" name="remote_ip_1" id="remote_ip_1"/>&nbsp;.
<input type="text" class="num" maxLength="3" onBlur="valid_range2(this,0,255,'IP')" style="width:40px" value="<% get_single_ip("remote_ip","2"); %>" name="remote_ip_2" id="remote_ip_2"/>&nbsp;.
<input type="text" class="num" maxLength="3" onBlur="valid_range2(this,1,254,'IP')" style="width:40px" value="<% get_single_ip("remote_ip","3"); %>" name="remote_ip_3" id="remote_ip_3"/>&nbsp;<script>Capture(portforward.to)</script>
<input type="text" class="num" maxLength="3" onBlur="valid_range2(this,1,254,'IP')" style="width:40px" value="<% nvram_list("remote_ip", "1"); %>" name="remote_ip_4" id="remote_ip_4"/>
</td>
</tr>
<tr>
<td><script>Capture(mgt.rmtmgtport)</script></td>
<td>
<input type="text" class="num" maxLength="5" style="width:50px" value="<% nvram_get("http_wanport"); %>"  name="http_wanport" />
</td>
</tr>
<% support_invmatch("SNMP_SUPPORT", "1", "<!--"); %>
<tr>
<td>Contact</td>
<td>
<input type="text" maxLength="63" size="20" value="<% nvram_get("snmp_contact"); %>" name="snmp_contact" onBlur="valid_name(this,'Password',SPACE_NO)" />
</td>
</tr>
<tr>
<td>Device Name</td>
<td>
<input type="text" maxLength="63" size="20" value="<% nvram_get("router_name"); %>" name="router_name" onBlur="valid_name(this,'router_name')" />
</td>
</tr>
<tr>
<td>Location</td>
<td>
<input type="text" maxLength="63" size="20" value="<% nvram_get("snmp_location"); %>" name="snmp_location" onBlur="valid_name(this,'Password',SPACE_NO)" />
</td>
</tr>
<tr>
<td>Get Community</td>
<td>
<input type="text" maxLength="63" size="20" value="<% nvram_get("snmp_getcom"); %>" name="snmp_getcom" onBlur="valid_name(this,'Password',SPACE_NO)" />
</td>
</tr>
<tr>
<td>Set Community</td>
<td>
<input type="text" maxLength="63" size="20" value="<% nvram_get("snmp_setcom"); %>" name="snmp_setcom" onBlur="valid_name(this,'Password',SPACE_NO)" />
</td>
</tr>
<tr>
<td>SNMP Trusted Host</td>
<td>
<input type="text" maxLength="63" size="20" value="<% nvram_get("snmp_trust"); %>" name="snmp_trust" onBlur="valid_name(this,'Password',SPACE_NO)" />
</td>
</tr>
<tr>
<td>SNMP Trap - Community</td>
<td>
<input type="text" maxLength="63" size="20" value="<% nvram_get("trap_com"); %>" name="trap_com" onBlur="valid_name(this,'Password',SPACE_NO)" />
</td>
</tr>
<tr>
<td>SNMP Trap - Destination</td>
<td>
<% prefix_ip_get("lan_ipaddr",1); %><input type="text" class="num" maxLength="3" size="1" value="<% nvram_get("trap_dst"); %>" name="trap_dst" onBlur="valid_range(this,1,254,'IP')" />
</td>
</tr>
<tr>
<td>SNMPv3 UserName</td>
<td>
<input type="text" maxLength="63" size="20" value="<% nvram_get("snmpv3_username"); %>" name="snmpv3_username" />
</td>
</tr>
<tr>
<td>SNMPv3 Password</td>
<td>
<input type="password" maxLength="63" size="20" value="d6nw5v1x2pc7st9m" name="snmpv3_passwd" onBlur="PasswdLen(this.form)" />
</td>
</tr>
<tr>
<td>Re-enter to confirm</td>
<td>
<input type="password" maxLength="63" size="20" value="d6nw5v1x2pc7st9m" name="SnmpPasswdConfirm" onBlur="PasswdLen(this.form)" />
</td>
</tr>
<% support_invmatch("SNMP_SUPPORT", "1", "-->"); %>
</tbody>
</table>
<% support_invmatch("BACKUP_RESTORE_SUPPORT","1","-->"); %>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
