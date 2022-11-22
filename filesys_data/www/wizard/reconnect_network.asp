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
'wiz.next': 'javascript:to_submit()',
});
var close_session = "<% get_session_status(); %>";
var session_key="<% nvram_get("session_key");%>";
var wl0_ssid = "<% nvram_get("ssid_24g");%>";
var wl0_passwd = "<% nvram_get("wpa_psk_24g");%>";
var wl1_ssid = "<% nvram_get("ssid_5g");%>";
var wl1_passwd = "<% nvram_get("wpa_psk_5g");%>";
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
function check_bootup()
{
setInterval(function()
{
if(typeof fetch == 'undefined')
{
var xhr = null;
if(window.XMLHttpRequest)
{
xhr = new XMLHttpRequest();
}
else if(window.ActiveXObject)
{
try
{
xhr = new ActiveXObject('Msxml2.XMLHTTP');
}
catch(e)
{
try
{
xhr = new ActiveXObject('Microsoft.XMLHTTP');
}
catch(e){}
}
}
function onReadyStateChange()
{
if(xhr.readyState == 4 && xhr.status == 200){check_connect();}
}
if(xhr)
{
xhr.onreadystatechange = onReadyStateChange;xhr.open('GET', '/language.js', true);
xhr.setRequestHeader("If-Modified-Since","0");
xhr.send(null);
}
}
else
{
fetch('/language.js').then(check_connect)
}
}, 2000);
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
setTimeout('check_bootup()',30000);
}
function goto_cancel()
{	
var F = document.ck_connect;
if (confirm(wiz.exitwarnmsg))
{
showWait();
F.submit_button.value = "setup_wizard";
F.submit_type.value="finish";
F.next_page.value="wizard/wizard_close_reload.asp";
F.change_action.value = "gozila_cgi";
F.submit(); 
}
}
function to_submit()
{
check_connect();
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
<div class="wiz-content-title"><script>Capture(wizardResult.reconnectwl)</script></div>
<div class="wiz-content-text"><script>Capture(wizardResult.reconnstep1)</script></div>
<div id="mainContent" class="wiz-content">
<table class="table table-info">
<tbody>
<tr>
<td>
<img src="images/Windows_NetworkPopup.png">
</td>
<td></td>
<td>
<img src="images/MacOS_SelectionPopup.png">
</td>
</tr>
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
</tbody>
</table>
</div>
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
</FORM></BODY></HTML>
