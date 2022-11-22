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
'wlanwscpopup.button':    'javascript:add_new_dev()',
'wlanwscpopup.btncancel':  'javascript:closePopout()'
});
document.title = filterpc.listpc;
var close_session = "<% get_session_status(); %>";
var dev_infos = [
<% get_dev_info();%>
["",""] ];
var add_dev="";
function select_dev(flag,value)
{
add_dev = value;
}
function add_new_dev()
{
if(add_dev != "")
{
var f = document.forms[0];
window.parent.add_option(f.dev_list.options[f.dev_list.selectedIndex].text,f.dev_list.options[f.dev_list.selectedIndex].value);
closePopout();
}
else
alert(pctrl.seladev);
}
function init()
{
var f = document.forms[0];
var pf = window.parent.document.forms[0];
for(var i = 0; i <dev_infos.length -1; i++)
{
var exist = 0;
if(dev_infos[i][1].length == 0)
var dev_name = pctrl.nwdev;
else
var dev_name = dev_infos[i][1];
for(var j = 0; j< pf.dev_list.options.length;j++)
{
if(dev_infos[i][0] == pf.dev_list.options[j].value)
exist = 1;
}
if(exist == 1)
continue;
var item = new Option(dev_name,dev_infos[i][0]);
f.dev_list.options[f.dev_list.options.length] = item;
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
}
</SCRIPT>
</HEAD>
<BODY bgColor="#808080" onload="init()">
<FORM name="PC_add_dev" action="apply.cgi" onSubmit="return false;" method="<% get_http_method(); %>">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="small_screen" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="filter_ip_value" />
<input type="hidden" name="filter_mac_value" />
<input type="hidden" name="wait_time" value="3" />
<script>var PopTitle = pctrl.pcontrol;</script>
<% web_include_file("pop_Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(pctrl.setuppc)</script>:</td>
</tr>
<tr>
<td><select name="dev_list" size="7" style="width:100%" onclick="select_dev(1,this.value)"></select></td>
</tr>
</tbody>
</table>
<% web_include_file("pop_Bottom.asp"); %>
</FORM></BODY></HTML>
