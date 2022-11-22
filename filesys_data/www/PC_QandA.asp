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
'wlanwscpopup.button':    'javascript:to_submit(document.PC_QandA)',
'wlanwscpopup.btncancel':  'javascript:closePopout()'
});
document.title = "PC Q and A";
var close_session = "<% get_session_status(); %>";
function to_submit(F)
{
showWait();
F.submit_button.value = "pc_QandA";
F.submit_type.value = "pc_question";
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
<FORM name="PC_QandA" action="apply.cgi" onSubmit="return false;" method="<% get_http_method(); %>">
<input type="hidden" name="submit_button" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="wait_time" value="3" />
<script>var PopTitle = pctrl.pcontrol;</script>
<% web_include_file("pop_Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(pctrl.aswsq)</script>:</td>
</tr>
<tr>
<td><% nvram_get_sp("hnd_question"); %></td>
</tr>
<tr>
<td>
<input maxlength="32" style="width:240" name="_hnd_answer" />
</td>
</tr>
<tr>
<td class="error">
<script>
var deny = "<%nvram_get("pc_passwd_deny");%>";
if(deny == "1")
Capture(pctrl.qaerrmsg3)
</script>
</td>
</tr>
</tbody>
</table>
<% web_include_file("pop_Bottom.asp"); %>
</FORM></BODY></HTML>
