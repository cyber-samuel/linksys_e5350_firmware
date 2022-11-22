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
});
document.title = share.cmpsumyall;
var close_session = "<% get_session_status(); %>";
var session_key='<% nvram_get("session_key");%>';
var wizard_status='<% nvram_get("wizard_status");%>';
var last_fw="<% show_online_update_fw(); %>";
var up_fw_result='<% nvram_get("wizard_update_result"); %>';
var wizard_upgrade_status='<% nvram_get("wizard_upgrade_status"); %>';
function init()
{
var F=document.success;
if (wizard_status == "check_fw")
{ 
document.getElementById("upgrade_fw").style.display="";
if ((last_fw == "Up to date"))
document.getElementById("upgrade_button").style.display="none";
else
document.getElementById("upgrade_button").style.display="";
}else if (wizard_status == "upgrade_fw")
{
if (up_fw_result == "1")        
document.getElementById("checkfw_button").style.display="none";
document.getElementById("upgrade_fw").style.display="none";
}//else
}
function goto_cancel()
{	
var F = document.success;
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
var F=document.success;
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
function goto_checkfirmware()
{
var F=document.success;
if((wizard_status == "get_connect") || ((wizard_status == "check_fw")&&(wizard_upgrade_status == "0")))
{
document.getElementById("wait_checkfw").style.display = "block";
F.submit_button.value = "setup_wizard"; 
F.submit_type.value="check_fw";
F.next_page.value="wizard/success.asp";
F.change_action.value = "gozila_cgi";
F.submit();
}
}
function goto_upgradefirmware()
{
var F=document.success;
showWait();
if ( close_session == "1" )
{
F.action= "upgrade.cgi";
}
else
{
F.action= "upgrade.cgi?session_id=<% nvram_get("session_key"); %>";
}
F.submit();
}
function online_firmware_ver()
{
if( last_fw == "Up to date")
document.write(wizardBasic.nofw);       
else 
document.write(last_fw);
}
</SCRIPT>
</HEAD>
<BODY onload="init();page_load();alignright('arRight');goto_checkfirmware()">
<form method="<% get_http_method(); %>" action="/apply.cgi" name="success">
<input type=hidden name="submit_button" value="">
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=next_page>
<input type=hidden id="gui_action"  name="gui_action" />
<% web_include_file("wizard/wizard_Top.asp"); %>
<div id=arRight>
<div class="wiz-content-title"><script>Capture(wizardResult.success)</script></div>
<div class="wiz-content-text"><script>Capture(wizardResult.access)</script></div>
<div class="wiz-content_success">
<table class="table table-info">
<tbody>
<tr>
<td>
<script>Capture(wizardBasic.fwupdate);</script>:&nbsp;
</td>
<td></td>
<td></td>
</tr>
<tr>
<td>
<script>Capture(wizardBasic.curfw);</script>:&nbsp;
</td>
<td><% nvram_get("fw_version"); %></td>
<td>
<button type=button class="btn btn-primary btn-wiz" style="display:none" onclick="javascript:goto_checkfirmware()" id=checkfw_button><script>Capture(wizardBasic.checkfw);</script></button>
</td>
</tr>
<tr id=upgrade_fw style="display:none">
<td>
<script>Capture(wizardBasic.lastfw);</script>:&nbsp;
</td>
<td><script>online_firmware_ver();</script></td>
<td><button type=button class="btn btn-primary btn-wiz" onclick="javascript:goto_upgradefirmware()" id=upgrade_button ><script>Capture(adbutton.upgrade);</script></button>
</td>
</tr>
</tbody>
</table>
</div>
</div>
</div>
<div id="wait_checkfw" style="display: none;">
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
<p><script>Capture(str_cgi_loading.checkfw)</script><p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<% web_include_file("wizard/wizard_Bottom.asp"); %>
</FORM></BODY></HTML>
