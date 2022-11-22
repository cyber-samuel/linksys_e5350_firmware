<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>View Log</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("pop_filelink.asp"); %>
<SCRIPT language="Javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capsec.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/share.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/help.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capwrt54g.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capadmin.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/layout.js"></SCRIPT>
<style>
.log_table{
width: 100%;
height: 200px;
border-collapse: collapse;
border-spacing: 0;
border: 3px solid #000000;
}
.log_table .log_td{
height: 25px;
}
.log_table th{
border: 3px solid #000000;
border-width: 0px 3px 3px;
text-align: center;
font-size: 8pt;
font-weight: 700;
font-family: Arial;
}
.log_table td{
border: 3px solid #000000;
border-width: 0px 3px;
text-align: center;
font-size: 8pt;
font-family: Arial;
}
.log_table td td{
text-align: left;
border-width: 0px;
}
</style>
<SCRIPT language="JavaScript" type="text/javascript">
var log_type = "<% nvram_selget("log_type"); %>";
(function(){
setFormActions({
savelog: "javascript:save_log()",
refresh: 'javascript:refresh()',
clear:   'javascript:showWait();to_clear(document.log)',
close:   true
});
})();
document.title = adbutton.viewlog;
var close_session = "<% get_session_status(); %>";
function ChangeType(F)
{
showWait();
F.submit_button.value="Log_View";
F.change_action.value="gozila_cgi";
F.submit_type.value=F.log_type.value;
F.submit();
}
function to_clear(F)
{
F.submit_button.value="Log_View";
F.submit_type.value="clear";
F.change_action.value="gozila_cgi";
F.submit();
}
function init()
{
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
function save_log()
{
var name;
if(log_type == "ilog")
name = '<% get_log_name("ilog"); %>';
else if(log_type == "olog")
name = '<% get_log_name("olog"); %>';
else if(log_type == "slog")
name = '<% get_log_name("slog"); %>';
else if(log_type == "dlog")
name = '<% get_log_name("dlog"); %>';
session_key='<% nvram_get("session_key"); %>';
if ( close_session == "1" )
window.location.href=name;
else
window.location.href=name + "?session_id=" + session_key;
}
function refresh()
{
if ( close_session == "1" )
{
document.location.replace("Log_View.asp");
}
else
{
document.location.replace("Log_View.asp?session_id=<% nvram_get("session_key"); %>");
}
}
</SCRIPT>
</HEAD>
<BODY bgColor="#808080" onLoad="init()">
<CENTER>
<FORM name="log" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_button" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="log_type" />
<script>var PopTitle = adtopmenu.log;</script>
<% web_include_file("pop_Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(log.type)</script></td>
<td>
<script>
(function(){
var str = [log.inlog, log.outlog, log.seclog, log.dhcplog],
val = ['ilog', 'olog', 'slog', 'dlog'];
draw_select('log_type', str, val, 'ChangeType(this.form)', '<% nvram_selget("log_type"); %>');
})();
</script>
</td>
</tr>
<tr>
<td colspan="2">
<hr class="table-title-underline">
</td>
</tr>
<tr>
<td class="vtop">
<script>
if(log_type == "ilog" || log_type == "")
document.write(log.inlog);
else if(log_type == "olog")
document.write(log.outlog);
else if(log_type == "slog")
document.write(log.seclog);
else if(log_type == "dlog")
document.write(log.dhcplog);
</script>
</td>
<td>
<script>
var log_type = "<% nvram_selget("log_type"); %>";
var top_style = "none";
if(log_type == "ilog" || log_type == "")
{
document.write('<table class="log_table">');
document.write('<thead>');
document.write('<tr>');
document.write('<th class="log_td" style="width:50%">' + share.sourceip + '</th>');
document.write('<th class="log_td" style="width:50%">' + log.desportnum + '</th>');
document.write('</tr>');
document.write('</thead>');
document.write('<tbody>');
var table = new Array();
var r = 0;  //John add
var n_st = 0;
function AAA(src,port)
{
this.src = src;
this.port = port;
}
<% dumplog("incoming_table","AAA"); %>
if(table.length<65)
n_st = 0;
else
{
r = (table.length) % 64;
if(r==0)
n_st= table.length - 64;
else
n_st= table.length - r;
}
for(var i=n_st;i<table.length;i++)
{
if(table.length == 0)
break;
if(i==0)
top_style = "solid";
else
top_style = "none";
document.write('<tr>');
document.write('<td class="log_td">' + table[i].src + '</td>');
document.write('<td class="log_td">' + table[i].port + '</td>');
document.write('</tr>');
}
document.write('<tr>');
document.write('<td>&nbsp;</td>');
document.write('<td>&nbsp;</td>');
document.write('</tr>');
document.write('</tbody>');
document.write('</table>');
}
else if(log_type == "olog"){
document.write('<table class="log_table">');
document.write('<thead>');
document.write('<tr>');
document.write('<th class="log_td">' + log.lanipaddr + '</th>');
document.write('<th class="log_td">' + log.dstip + '</th>');
document.write('<th class="log_td">' + log.srvport + '</th>');
document.write('</tr>');
document.write('</thead>');
document.write('<tbody>');
var table = new Array();
var _src;
var _dst;
var _port;
var r=0;  //John add
var n_st=0;
function BBB(src,dst,port)
{
this.src = src;
this.dst = dst;
this.port = port;
}
<% dumplog("outgoing_table","BBB"); %>
if(table.length<65)
n_st = 0;
else{
r = (table.length) % 64;
if(r==0)
n_st= table.length - 64;
else
n_st= table.length - r;
}
for(var i=n_st;i<table.length;i++)
{
if(table.length == 0)
{
_src = table[0].src;
_dst = table[0].dst;
_port = table[0].port;
}
else
{
_src = "&nbsp;";
_dst = "&nbsp;";
_port = "&nbsp;";
}
if(i==0)
top_style = "solid";
else
top_style = "none";
document.write('<tr>');
document.write('<td class="log_td">' + table[i].src + '</td>');
document.write('<td class="log_td">' + table[i].dst + '</td>');
document.write('<td class="log_td">' + table[i].port + '</td>');
document.write('</tr>');
if(table.length == 0)
break;
}
document.write('<tr>');
document.write('<td>&nbsp;</td>');
document.write('<td>&nbsp;</td>');
document.write('<td>&nbsp;</td>');
document.write('</tr>');
document.write('</tbody>');
document.write('</table>');
}
else if(log_type == "slog")
{
var table = new Array();
function CCC(string)
{
this.string = string;
}
<% dumplog("security_table","CCC"); %>
document.write('<table class="log_table">');
document.write('<tbody>');
document.write('<tr>');
document.write('<td class="log_td" style="vertical-align:top">');
for(var i=0 ; i<table.length ; i++)
{
document.write('<table>');
document.write('<tbody>');
document.write('<tr>');
document.write('<td>' + table[i].string + '</td>');
document.write('</tr>');
document.write('</tbody>');
document.write('</table>');
}
document.write('</td>');
document.write('</tr>');
document.write('<tr>');
document.write('<td>&nbsp;</td>');
document.write('</tr>');
document.write('</tbody>');
document.write('</table>');
}
else if(log_type == "dlog")
{
var table = new Array();
function DDD(string)
{
this.string = string;
}
<% dumplog("dhcp_table","DDD"); %>
document.write('<table class="log_table">');
document.write('<tbody>');
document.write('<tr>');
document.write('<td class="log_td" style="vertical-align:top">');
for(var i=0 ; i<table.length ; i++)
{
document.write('<table>');
document.write('<tbody>');
document.write('<tr>');
document.write('<td>' + table[i].string + '</td>');
document.write('</tr>');
document.write('</tbody>');
document.write('</table>');
}
document.write('</td>');
document.write('</tr>');
document.write('<tr>');
document.write('<td>&nbsp;</td>');
document.write('</tr>');
document.write('</tbody>');
document.write('</table>');
}
</script>
</td>
</tr>
</tbody>
</table>
<% web_include_file("pop_Bottom.asp"); %>
</FORM></CENTER></BODY></HTML>
