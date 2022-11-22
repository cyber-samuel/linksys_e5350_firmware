<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Diagnostics</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
document.title = adtopmenu.diag;
var close_session = "<% get_session_status(); %>";
function ViewPing()
{	
if(close_session == "1")
showPopout('Ping.asp', '600px');
else
showPopout('Ping.asp?session_id=<% nvram_get("session_key"); %>', '600px');
return;
if ( close_session == "1" )
{
self.open('Ping.asp','PingTable','alwaysRaised,resizable,scrollbars,width=730,height=450').focus();
}
else
{
self.open('Ping.asp?session_id=<% nvram_get("session_key"); %>','PingTable','alwaysRaised,resizable,scrollbars,width=730,height=450').focus();
}
}
function ViewTraceroute()
{	
if(close_session == "1")
showPopout('Traceroute.asp', '600px');
else	
showPopout('Traceroute.asp?session_id=<% nvram_get("session_key"); %>', '600px');
return;
if ( close_session == "1" )
{
self.open('Traceroute.asp','TracerouteTable','alwaysRaised,resizable,scrollbars,width=730,height=450').focus();
}
else
{
self.open('Traceroute.asp?session_id=<% nvram_get("session_key"); %>','TracerouteTable','alwaysRaised,resizable,scrollbars,width=730,height=450').focus();
}
}
function to_submit(F,I)
{
if(valid(F,I)){
F.submit_type.value = I ; 
F.submit_button.value = "Diagnostics";
F.change_action.value = "gozila_cgi";
F.submit();
}
}
function valid(F,I)
{
if(I == "start_ping" && F.ping_ip.value == ""){
alert(errmsg.err8);
F.ping_ip.focus();
return false;
}
if(I == "start_traceroute" && F.traceroute_ip.value == ""){
alert(errmsg.err8);
F.traceroute_ip.focus();
return false;
}
return true;
}
function init()
{
if('<% nvram_selget("submit_type"); %>' == "start_ping") {
ViewPing();
}
if('<% nvram_selget("submit_type"); %>' == "start_traceroute") {
ViewTraceroute();
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
<BODY vLink="#b5b5e6" aLink="#ffffff" link="#b5b5e6" onload="init()">
<FORM name="diag" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="commit" value="0" />
<% web_include_file("Top.asp"); %>
<script>draw_table(MAINFUN2,adleftmenu.ping);</script>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(ping.ipurl)</script></td>
<td>
<input type="text" maxLength="39" name="ping_ip" size="26" value="<% nvram_selget("ping_ip"); %>" onBlur="valid_name(this,'IP')" />
</td>
</tr>
<tr>
<td><script>Capture(ping.pktsize)</script></td>
<td>
<input type="text" maxLength="5" name="ping_size" style="width:40px" value="<% nvram_selget("ping_size"); %>" onBlur="valid_range(this,32,65500,'')" />&nbsp;<script>Capture(share.bytes)</script> (32 - 65500)
</td>
</tr>
<tr>
<td><script>Capture(ping.times)</script></td>
<td>
<script>
(function(){
var str = ['5', '10', '15', ping.unlimited],
val = ['5', '10', '15', '0'];
draw_select('ping_times', str, val, '', '<% nvram_selget("ping_times"); %>');
})();
</script>
</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>
<script>draw_button("javascript:to_submit(this.form,'start_ping')", adbutton.startping, 'ping_button')</script>
</td>
</tr>
</tbody>
</table>
<script>draw_table(MAINFUN2,adleftmenu.tracertest);</script>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(ping.ipurl)</script></td>
<td>
<input type="text" maxLength="39" name="traceroute_ip" size="26" value="<% nvram_selget("traceroute_ip"); %>" onBlur="valid_name(this,'IP')" />
</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>
<script>draw_button("javascript:to_submit(this.form,'start_traceroute')", adbutton.starttracer, 'troute_button')</script>
</td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
