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
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/other.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capadmin.js"></SCRIPT>
<SCRIPT language="javascript">
setFormActions({
'wiz.done': 'javascript:to_submit()',
'portsrv.cancel': 'javascript:goto_cancel()'
});
document.title = share.cmpsumyall;
var close_session = "<% get_session_status(); %>";
var session_key="<% nvram_get("session_key");%>";
var wizard_proto="<% nvram_get("wizard_proto");%>";
var router_pwd = "<% nvram_get("http_passwd");%>";
var wl0_ssid = "<% nvram_get("ssid_24g");%>";
var wl0_passwd = "<% nvram_get("wpa_psk_24g");%>";
var wl1_ssid = "<% nvram_get("ssid_5g");%>";
var wl1_passwd = "<% nvram_get("wpa_psk_5g");%>";
var account_name = "<% nvram_get("ppp_username");%>";
var account_pwd = "<% nvram_get("ppp_passwd");%>";
function check_connect()
{	
var F=document.ck_connect;
hiddenPopout();
document.getElementById('wait_ck').style.display = 'block';
F.submit_button.value = "setup_wizard"; 
F.submit_type.value="get_connect";
F.next_page.value="wizard/get_connect.asp";
F.change_action.value = "gozila_cgi";
F.submit();
}
function init()
{
var F=document.ck_connect;
if ( close_session == "1" )
{
document.forms[0].action= "apply.cgi";
}
else
{
document.forms[0].action= "apply.cgi?session_id=<% nvram_get("session_key"); %>";
}
check_connect();
}
function goto_cancel()
{	
var F = document.ck_connect;
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
function to_submit()
{	
var F=document.ck_connect;
if (confirm(wiz.exitwarnmsg))
{
showWait();
F.submit_button.value = "setup_wizard"; 
F.submit_type.value="finish";
F.next_page.value="wizard/finished.asp";
F.change_action.value = "gozila_cgi";
F.submit();     
}
}
</SCRIPT>
</HEAD>
<BODY onload="init();page_load();alignright('arRight')">
<form method="<% get_http_method(); %>" action="apply.cgi" name="ck_connect">
<input type=hidden name="submit_button" value="">
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=next_page>
<input type=hidden id="gui_action"  name="gui_action" />
<% web_include_file("wizard/wizard_Top.asp"); %>
<div id=arRight>
<div class="wiz-content-title">
<script>Capture(wizardComplete.msg2)</script>
</div>
<div id="mainContent" class="wiz-content">
<table class="table table-info">
<tbody>
<% nvram_invmatch("wizard_proto", "PPPOE", "<!--"); %>
<tr>
<td>
<script>Capture(wizardDslConn.account_name);</script>:&nbsp;
</td>
<td></td>
<td>
<script>
var line, value, htmlvalue;
value = account_name
line = value.length/35;
for (i=0; i<line; i++)
{	
htmlvalue= html2Escape(value.substring(0,35));
document.write(htmlvalue+"<BR>");
value = value.substring(35,value.length);
}
</script>
</td>
</tr>
<tr>
<td>
<script>Capture(share.passwd);</script>:&nbsp;
</td>
<td></td>
<td>
<script>	
var line, value, htmlvalue;
value = account_pwd;
line = value.length/35;
for (i=0; i<line; i++)
{	
htmlvalue= html2Escape(value.substring(0,35));
document.write(htmlvalue+"<BR>");
value = value.substring(35,value.length);
}
</script>
</td>
</tr>
<% nvram_invmatch("wizard_proto", "PPPOE", "-->"); %>
<tr>
<td>
2.4 GHz <script>Capture(wizardNetwork.networkname);</script>:&nbsp;
</td>
<td></td>
<td>
<script>document.write(wl0_ssid)</script>
</td>
</tr>
<tr>
<td>
2.4 GHz <script>Capture(wizardComplete.netpwd);</script>:&nbsp;
</td>
<td></td>
<td>
<script>	
var line, value, htmlvalue;
value = wl0_passwd;
line = value.length/35;
for (i=0; i<line; i++)
{
htmlvalue= html2Escape(value.substring(0,35));
document.write(htmlvalue+"<BR>");
value = value.substring(35,value.length);
}
</script>
</td>
</tr>
<tr>
<td>
5 GHz <script>Capture(wizardNetwork.networkname);</script>:&nbsp;
</td>
<td></td>
<td>
<script>document.write(wl1_ssid)</script>
</td>
</tr>
<tr>
<td>
5 GHz <script>Capture(wizardComplete.netpwd);</script>:&nbsp;
</td>
<td></td>
<td>
<script>	
var line, value, htmlvalue;
value = wl1_passwd;
line = value.length/35;
for (i=0; i<line; i++)
{
htmlvalue= html2Escape(value.substring(0,35));
document.write(htmlvalue+"<BR>");
value = value.substring(35,value.length);
}
</script>
</td>
</tr>
<tr>
<td>
<script>Capture(wizardCreatePwd.router_user);</script>:&nbsp;
</td>
<td></td>
<td>
admin
</td>
</tr>
<tr>
<td>
<script>Capture(adleftmenu.routerpsw);</script>:&nbsp;
</td>
<td></td>
<td>
<script>	
var line, value, htmlvalue;
value = router_pwd;
line = value.length/35;
for (i=0; i<line; i++)
{	
htmlvalue= html2Escape(value.substring(0,35));
document.write(htmlvalue+"<BR>");
value = value.substring(35,value.length);
}
</script>
</td>
</tr>
</tbody>
</table>
</div>
<div id="wait_ck" style="display: none;">
<div class="modal" role="diglog" _v-f353fd1c="">
<div class="modal-dialog modal-sm">
<div class="modal-content">
<div class="loadingImg" _v-f353fd1c="">
<div class="row">
<div class="col-md-12">
<div class="v-spinner">
<div class="v-clip" style="height: 35px; width: 35px; border-width: 2px; border-style: solid; border-color: rgb(0, 104, 217) rgb(0, 104, 217) transparent; border-radius: 100%; background: transparent !important;">&nbsp;</div>
</div>
</div>
<div class="col-md-12">
<p><script>Capture(str_cgi_loading.checkconnect)</script></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<% web_include_file("wizard/wizard_Bottom.asp"); %>
</FORM></BODY></HTML>
