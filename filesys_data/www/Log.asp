<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Log</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
save:   true,
cancel: true
});
document.title = adtopmenu.log;
var close_session = "<% get_session_status(); %>";
var EN_DIS = '<% nvram_get("log_enable"); %>'
function to_submit(F)
{
if(F._log_enable.checked == true)
{
F.log_enable.value = 1;
F.log_level.value = "3";
}
else
{
F.log_enable.value = 0;
F.log_level.value = "0";
}
/*
if(F.log_ipaddr.value == <% get_single_ip("lan_ipaddr","3"); %>)
{
alert(errmsg.err72);
return;
}
*/
F.submit_button.value = "Log";
F.gui_action.value='Apply';
ajaxSubmit(35,"false");
return true;
}
function SelLog(num,F)
{
if(F._log_enable.checked == true)
{
choose_enable(F.view_log);
update_checked(F._log_enable);
}
else
{
choose_disable(F.view_log);
update_checked(F._log_enable);
}
}
function log_enable_disable(F,I)
{
EN_DIS = I;
if ( I == "0" ){
choose_disable(F.view_log);
}
else{
choose_enable(F.view_log);
}
}
function ViewLog()
{
if( document.log.log_enable.value == 1)
{
showPopout('Log_View.asp?session_id=<% nvram_get("session_key"); %>', '800px');
return;
}
else
{
alert(errmsg.log);
return;
}	
if ( close_session == "1" )
{
self.open('Log_View.asp','inLogTable','alwaysRaised,resizable,scrollbars,width=800,height=480').focus();
}
else
{
self.open('Log_View.asp?session_id=<% nvram_get("session_key"); %>','inLogTable','alwaysRaised,resizable,scrollbars,width=800,height=480').focus();
}
}
function init() 
{       
SelLog('<% nvram_get("log_enable"); %>',document.log);
var swmode = '<% nvram_get("switch_mode");%>';
if( swmode == 1)
alert(share.brdgmwn);
var bridge_mode = "<% nvram_get("wbridge_mode");%>";
if(bridge_mode == "1")
alert(wlanbridge.warn);
update_checked(document.log._log_enable);
var close_session = "<% get_session_status(); %>";
if ( close_session == "1" )
{
document.forms[0].action= "apply.cgi";
}
else
{
document.forms[0].action= "apply.cgi?session_id=<% nvram_get("session_key"); %>";
}
setInitFormData(function(){
to_submit(document.forms[0])
})
}
</SCRIPT>
</HEAD>
<BODY onload="init()" onbeforeunload = "return checkFormChanged(document.log)">
<FORM name="log" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="log_enable" />
<input type="hidden" name="log_level" />
<input type="hidden" name="wait_time" value="3" />
<% web_include_file("Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td>
<script>draw_checkbox('_log_enable', adtopmenu.log, '1', 'SelLog(1,this.form)' <% nvram_match("log_enable","1",", 1"); %>);</script>
</td>
<td colspan="2">
<script>draw_button("javascript:ViewLog()", adbutton.viewlog, 'view_log')</script>
</td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
