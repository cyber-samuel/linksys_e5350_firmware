<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Factory Defaults</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
re1 = /&nbsp;/gi
str = adtopmenu.facdef.replace(re1,"");
document.title = str;
var close_session = "<% get_session_status(); %>";
var is_wireless_mac="<% is_wireless_mac(); %>";
function to_restore(F)
{
if(!confirm(hfacdef.warning))
return false;
F.gui_action.value='Restore';
F.submit_button.value = "Factory_Defaults";
url = "http://192.168.1.1";
ajaxSubmit(80,"true", url);
F.btn_restore.blur();
return true;
}
function reset_security(F)
{
F.submit_button.value = "Factory_Defaults";
F.gui_action.value ="Apply";
F.submit_type.value="wsc_reset";
F.submit();
return true;
}
function reboot(F)
{
if(!confirm(other.warning))
return;
F.wait_time.value="40";
F.submit_button.value = "index";
F.change_action.value = "gozila_cgi";
F.submit_type.value="reboot";
if(is_wireless_mac == "1")	
ajaxSubmit(95,"check");
else
ajaxSubmit(80,"check");
F.btn_reboot.blur();
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
<BODY onload="init()">
<FORM name="default" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="wait_time" value="45" />
<input type="hidden" name="FactoryDefaults" />
<input type="hidden" name="submit_type" />
<% web_include_file("Top.asp"); %>
<div>
<table class="table table-info">
<tbody>
<tr>
<td>
<script>Capture(facdef.helpmsg2)</script>
</td>
<td>
<script>draw_button("javascript:reboot(document.default)", sbutton.reboot, 'btn_reboot')</script>
</td>
</tr>
<tr>
<td>
<script>Capture(facdef.helpmsg)</script>
</td>
<td>
<script>draw_button('javascript:to_restore(this.form)',facdef.refacdefa2, 'btn_restore')</script>
</td>
</tr>
</tbody>
</table>
</div>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
