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
A:link#QA { COLOR:#2971b9 }
A:visited#QA { COLOR:#2971b9 }
A:hover#QA { COLOR:#00ffff }
</STYLE>
<SCRIPT language=javascript>
setFormActions({
'wlanwscpopup.button':    'javascript:to_submit(document.PC_renamedev)',
'wlanwscpopup.btncancel':  'javascript:closePopout()'
});
document.title = "PC rename dev";
var close_session = "<% get_session_status(); %>";
var pf = window.parent.document.forms[0]
var sel_dev_name = pf.dev_list.options[pf.dev_list.selectedIndex].text;
function to_submit(f)
{
if(!valid_pc_name(f.new_name,'DeviceName'))
{
return;
}
if(f.new_name.value.length == 0)
{
alert(pctrl.devnamerrmsg1);
return;
}
else
{
window.parent.rename_device(f.new_name.value);
closePopout();
}
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
document.PC_renamedev.new_name.value = sel_dev_name;
}
</SCRIPT>
</HEAD>
<BODY bgColor="#808080" onload="init()">
<FORM name="PC_renamedev" action="apply.cgi" method="<% get_http_method(); %>" onSubmit="return false;">
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
<td><script>Capture(pctrl.renamedev)</script>:</td>
</tr>
<tr>
<td style="word-break:break-all"><script>Capture(pctrl.enternewname)</script>&nbsp;&nbsp;<b><script>document.write(sel_dev_name);</script></b></td>
</tr>
<tr>
<td>
<input maxlength="32" style="width:300px" name="new_name" onBlur="valid_pc_name(this,'DeviceName')" />
</td>
</tr>
</tbody>
</table>
<% web_include_file("pop_Bottom.asp"); %>
</FORM></BODY></HTML>
