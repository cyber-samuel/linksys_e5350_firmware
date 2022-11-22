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
'wiz.exit': 'javascript:goto_cancel()',
'wiz.next': 'javascript:to_submit()'
});
var close_session = "<% get_session_status(); %>";
var session_key="<% nvram_get("session_key");%>";
function init()
{
}
function goto_cancel()
{	
var F = document.wz_fail;
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
document.location.replace("/wizard/index.asp");
else
document.location.replace("/wizard/index.asp?session_id="+session_key);
}
</SCRIPT>
</HEAD>
<BODY onload="init();alignright('arRight')">
<form method="<% get_http_method(); %>" action="apply.cgi" name="wz_fail">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="next_page" />
<input type="hidden" id="gui_action"  name="gui_action" />
<% web_include_file("wizard/wizard_Top.asp"); %>
<div id=arRight>
<div class="wiz-content-title"><script>Capture(wizardResult.confail)</script></div>
<div id="mainContent" class="wiz-content-text">
<script>Capture(wizardResult.confailcmt)</script>
</div>
<!-- <div id="mainContent" class="wiz-content"> -->
<div id="mainContent" class="summaryBlock">
<table class="table table-info">
<tbody>
<div class="row">
<script>Capture(wizardResult.confailcxt)</script>
</div>
<div class="row">
<b>1. </b>
<script>Capture(wizardResult.confailcxt1)</script>
</div>
<div class="row">
<b>2. </b>
<script>Capture(wizardResult.confailcxt2)</script>
</div>
<div class="row">
<b>3. </b>
<script>Capture(wizardResult.confailcxt3)</script>
</div>
<div class="row">
<b>4. </b>
<script>Capture(wizardResult.confailcxt4)</script>
</div>
</tbody>
</table>
</div>
</div>
<% web_include_file("wizard/wizard_Bottom.asp"); %>
</FORM></BODY></HTML>
