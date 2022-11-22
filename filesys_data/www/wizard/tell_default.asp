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
'wiz.donotsetup': 'javascript:goto_exit()',
'wiz.tryagain': 'javascript:goto_tryagain()'
});
document.title = wiz.telldef;
function goto_exit()
{
var F = document.wz_fail;
{        
showWait();
F.submit_button.value = "setup_wizard";
F.submit_type.value="finish";
F.next_page.value="wizard/unfinished.asp";
F.change_action.value = "gozila_cgi";
F.submit();
}
}
function goto_tryagain()
{
showWait();
if ( close_session == "1" )
document.location.replace("/wizard/index.asp");
else
document.location.replace("/wizard/index.asp?session_id=" + session_key);
}
</SCRIPT>
</HEAD>
<BODY onload="page_load();alignright('arRight')">
<form method="<% get_http_method(); %>" action="/apply.cgi" name="wz_fail">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="next_page" />
<% web_include_file("wizard/wizard_Top.asp"); %>
<div id=arRight>
<div class="wiz-content-title"><script>Capture(wiz.wzfail)</script></div>
<div class="row"><script>Capture(wiz.checkcable)</script></div>
<div class="row">
<script>Capture(wiz.wzfailcmt1)</script>
<script>Capture(wiz.exitwarnmsg)</script>
</div>
<div class="row"><script>Capture(wiz.wzfailcmt)</script></div>
<div class="row"><a href='http://www.linksys.com' target='_blank'>www.linksys.com</a></div>
</div>
<% web_include_file("wizard/wizard_Bottom.asp"); %>
</FORM></BODY></HTML>
