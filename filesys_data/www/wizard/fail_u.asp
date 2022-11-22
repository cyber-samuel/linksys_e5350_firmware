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
'portsrv.cancel': 'javascript:goto_cancel()',
'wiz.next': 'javascript:to_submit()'
});
var close_session = "<% get_session_status(); %>";
var session_key="<% nvram_get("session_key");%>";
var is_wireless_mac="<% is_wireless_mac(); %>";
function goto_index()
{
window.parent.document.location.href = "/Router_Login.asp";     
}
function show_wait()
{
hiddenPopout();
document.getElementById('wait_reboot').style.display = 'block';
}
function init()
{
show_wait();
if(is_wireless_mac == "1")
setTimeout('goto_index()',90000);
else
setTimeout('goto_index()',100000);
}
function goto_cancel()
{	
var F = document.save_settings;
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
if ( close_session == "1" )
document.location.replace("/wizard/success.asp");
else
document.location.replace("/wizard/success.asp?session_id="+session_key);
}
</SCRIPT>
</HEAD>
<BODY onload="init();page_load();alignright('arRight')">
<form method="<% get_http_method(); %>" action="apply.cgi" name="wz_fail_u">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="next_page" />
<input type="hidden" id="gui_action"  name="gui_action" />
<% web_include_file("wizard/wizard_Top.asp"); %>
<div id=arRight>
<div class="wiz-content-title"><script>Capture(wizardBasic.upfail1)</script></div>
<div id="mainContent" class="wiz-content-text">
<script>Capture(wizardBasic.upfail2)</script>
</div>
<div class="wiz-content_fail"></div>
</div>
<div id="wait_reboot" style="display: none;">
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
<p><script>Capture(str_cgi_loading.rebootFail)</script></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</FORM></BODY></HTML>
