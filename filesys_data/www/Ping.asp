<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Ping</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("pop_filelink.asp"); %>
<SCRIPT language="Javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capsec.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/share.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capapp.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capasg.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capwrt54g.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capadmin.js"></SCRIPT>
<!--<style>
width: 100%;
height: 25px;
border-collapse: collapse;
border-spacing: 0;
border: 1px solid #000000;
}
padding: 0 0.5em;
}
</style>
-->
<SCRIPT language="javascript">
setFormActions({
'adbutton.stop':  'javascript:showWait();to_stop(document.ping)',
close: 'javascript:to_close(document.ping)'
});
document.title = adbutton.ping;
var close_session = "<% get_session_status(); %>";
var timerID=null;
var timerRunning = false ;
var value=0;
var CLOSEFLG=0 ;
function sleep(n)
{
var start=new Date().getTime();
while(true)
if(new Date().getTime()-start>n)
break;
}
function to_close(F)
{
to_stop(F);
sleep(1000);
}
function to_stop(F)
{
if ( timerRunning ) clearTimeout(timerID);
timerRunning = false ;
F.submit_button.value = "Ping";
F.submit_type.value = "stop"
F.change_action.value = "gozila_cgi";
F.submit();
}
function Refresh()
{
refresh_time = 3000;
if (value>=1)
{
showWait();
CLOSEFLG = 1 ;
if ( close_session == "1" )
{
window.location.replace("Ping.asp");
}
else
{
window.location.replace("Ping.asp?session_id=<% nvram_get("session_key"); %>");
}
}
value++;
timerID=setTimeout("Refresh()",refresh_time);
timerRunning = true ;
}
function init()
{
<% onload("Ping", "Refresh();"); %>
window.location.href = "#";
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
function closeWindow()
{
var F = document.ping ;
if ( CLOSEFLG!=1 && CLOSEFLG!=0 ) to_stop(F);
}
function initflg(evt)
{
if ( evt.clientY<=0 && CLOSEFLG!=2 )CLOSEFLG = 2;
}
</SCRIPT>
</HEAD>
<BODY bgColor="#808080" onLoad="init()" onbeforeunload="closeWindow();" onmousemove="initflg(event)">
<FORM name="ping" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="change_action" />
<input type="hidden" name="commit" value="0" />
<script>var PopTitle = adbutton.ping;</script>
<% web_include_file("pop_Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td colspan="2">
<table id="AutoNumber3">
<tbody>
<script>
var ping_string = new Array("Network is unreachable", tracert.unreach,
"packets transmitted", ping.pkttr,
"packets received", ping.pktrx,
"packet loss", ping.pktloss,
"data bytes", ping.databyte,
"ping statistics", ping.datastat,
"round-trip min/avg/max", ping.roundtrip,
"bytes from", ping.bytefrom,
"Time", summary.tmofday,
"Request timed out", tracert.reqout,
"Unknown host", tracert.unknown,													      
"Invalid IP Address or Domain Name", ping.invalid,		
"Resolving URL Address...", ping.resolving			
);
var i = 0;
var a = new String("");
var b = new String("");
var table = new Array(
<% dump_ping_log(); %>
);
for (i = 0; i < table.length; i++) {
for (j = 0; j < ping_string.length; j += 2) {
RE = new RegExp(ping_string[j], "i");
a = table[i];
b = a.replace(RE, ping_string[j+1]);
table[i] = b;
}
}
if(table.length == "0") {
table[0] = " ";
}
for(var i=0 ; table[i] ; i++) {
document.write('<tr>');
document.write('<td><p>' + table[i] + '</p></td>');
document.write('</tr>');
}
</script>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<% web_include_file("pop_Bottom.asp"); %>
</FORM></BODY></HTML>
