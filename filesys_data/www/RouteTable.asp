<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Routing Table</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("pop_filelink.asp"); %>
<SCRIPT language="Javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capsec.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/share.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/help.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capapp.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capasg.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capsetup.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capwrt54g.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/layout.js"></SCRIPT>
<SCRIPT language="javascript">
setFormActions({
refresh: 'javascript:refresh()',
close:   true
});
document.title = advroute.routetbl;
var close_session = "<% get_session_status(); %>";
function refresh()
{
if ( close_session == "1" )
{
document.location.replace("RouteTable.asp");
}
else
{
document.location.replace("RouteTable.asp?session_id=<% nvram_get("session_key"); %>");
}
}
</SCRIPT>
</HEAD>
<BODY bgColor="#808080">
<CENTER>
<FORM>
<script>var PopTitle = advroute.routetbl;</script>
<% web_include_file("pop_Top.asp"); %>
<div class="table-box-warpper table-responsive">
<table class="table table-info-bg table-bordered">
<thead>
<tr>
<td><script>Capture(advroute.deslanip)</script></td>
<td><script>Capture(share.submask)</script></td>
<td><script>Capture(share.gateway)</script></td>
<td><script>Capture(share.hop)</script></td>
<td><script>Capture(share.inter_face)</script></td>
</tr>
</thead>
<tbody>
<script>
var table = new Array(
<% dump_route_table(""); %>
);
var i = 0;
var ret;
for(;;){
if(!table[i]) {
if(i == 0) {
table[i] = wlanadv.none;
table[i+1] = wlanadv.none;
table[i+2] = wlanadv.none;
table[i+3] = wlanadv.none;
table[i+4] = wlanadv.none;
ret = 1;
}
else
break;
}
else {
if(table[i+4] == "LAN")	table[i+4] = share.lanwireless;
else if(table[i+4] == "WAN") table[i+4] = advroute.waninternet;
}
if(parseInt(Number(table[i+3]))>15){
i = i + 5;
continue;
}
document.write('<tr>');
document.write('<td>' + table[i] + '</td>');
document.write('<td>' + table[i+1] + '</td>');
document.write('<td>' + table[i+2] + '</td>');
document.write('<td>' + parseInt(Number(table[i+3])+1) + '</td>');
document.write('<td>' + table[i+4] + '</td>');
document.write('</tr>');
if(ret == 1)
break;
i = i + 5;
}
</script>
</tbody>
</table>
</div>
<% web_include_file("pop_Bottom.asp"); %>
</FORM></CENTER></BODY></HTML>
