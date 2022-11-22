<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>DHCP Client Table</TITLE>
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
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capstatus.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/layout.js"></SCRIPT>
<SCRIPT language="javascript">
setFormActions({
refresh: 'javascript:refresh()',
close:   true
});
document.title = stabutton.dhcpclitbl;
var close_session = "<% get_session_status(); %>";
function to_select(mac)
{
parent.document.dmz.dmz_mac.value = mac;
closePopout();
}
function SoryBy(F)
{
showWait();
F.submit_button.value="DHCP_Table_Select";
F.change_action.value="gozila_cgi";
F.submit();
}
function refresh()
{
if ( close_session == "1" )
{
document.location.replace("DHCP_Table_Select.asp");
}
else
{
document.location.replace("DHCP_Table_Select.asp?session_id=<% nvram_get("session_key"); %>");
}
}
function init()
{
window.focus();
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
<CENTER>
<form method="<% get_http_method(); %>" action="apply.cgi" name="dhcp">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="small_screen" />
<input type="hidden" name="ip" />
<script>var PopTitle = stabutton.dhcpclitbl;</script>
<% web_include_file("pop_Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(dhcptbl.tosortby)</script></td>
<td>
<script>
(function(){
var str = [share.ipaddr, share.macaddr, share.inter_face, share.cliname],
val = ['ip', 'mac', 'iface', 'name'];
draw_select('sortby', str, val, 'SoryBy(this.form)', '<% nvram_selget("sortby"); %>');
})();
</script>
</td>
</tr>
</tbody>
</table>
<hr class="table-title-underline" style="margin: -1em 0 1em 0">
<div class="table-box-warpper table-responsive">
<table class="table table-info-bg table-bordered">
<thead>
<tr>
<td><script>Capture(share.cliname)</script></td>
<td><script>Capture(share.inter_face)</script></td>
<td><script>Capture(share.ipaddr)</script></td>
<td><script>Capture(share.macaddr)</script></td>
<!--<td><script>Capture(dhcptbl.expires)</script></td>-->
<td>&nbsp;</td>
</tr>
</thead>
<tbody>
<script language="javascript">
var table = new Array();
var sortby = "<% nvram_selget("sortby"); %>";
<% dumpleases("table","AAA"); %>
function AAA(name,ip,mac,time,iface)
{
this.name = name;
this.ip = ip;
this.mac = mac;
this.time = time;
this.iface = iface;
}
function ByName(a,b)
{
if( a.name > b.name ) return 1;
else if (a.name == b.name ) return 0;
else return -1;
}
function ByMac(a,b)
{
if( a.mac > b.mac ) return 1;
else if (a.mac == b.mac ) return 0;
else return -1;
}
function ByIp(a,b)
{
if( a.ip > b.ip ) return 1;
else if (a.ip == b.ip ) return 0;
else return -1;
}
function ByIface(a,b)
{
if( a.iface > b.iface ) return 1;
else if (a.iface == b.iface ) return 0;
else return -1;
}
if(sortby == "") {
sortby = "ip";
}
if(sortby == "name") {
table.sort(ByName);
}
else if(sortby == "mac") {
table.sort(ByMac);
}
else if(sortby == "ip") {
table.sort(ByIp);
}
else if(sortby == "iface") {
table.sort(ByIface);
}
var i = 0;
var ip = new Array();
var ret = 0;
for(i=0;;i++) {
if(table.length == 0) {
table[0] = new AAA(wlanadv.none,wlanadv.none,wlanadv.none,wlanadv.none,wlanadv.none);
ret = 1;
}
else if(table.length == i) {
break;
}
if(table[i].iface == "WL")
table[i].iface = bmenu.wireless;
else if(table[i].iface == "G")
table[i].iface = bmenu.wireless+"-G";
else if(table[i].iface == "B")
table[i].iface = bmenu.wireless+"-B";
else if(table[i].iface == "A")
table[i].iface = bmenu.wireless+"-A";
else if(table[i].iface == "N")
table[i].iface = bmenu.wireless+"-N";
else if(table[i].iface == "LAN")
table[i].iface = "LAN";
if(ret != 1) {
ip = table[i].ip.split('.');
}
document.write('<tr>');
document.write('<td>' + table[i].name + '</td>');
document.write('<td>' + table[i].iface + '</td>');
document.write('<td>' + table[i].ip + '</td>');
document.write('<td>' + table[i].mac + '</td>');
if(ret == 1)
document.write('<td>&nbsp;</td>');
else
{
document.write('<td>');
draw_button("javascript:to_select('" + table[i].mac + "')", sbutton.sel);
document.write('</td>');
}
document.write('</tr>');
if(ret == 1)
break;
}
</script>
</tbody>
</table>
</div>
<% web_include_file("pop_Bottom.asp"); %>
</FORM></CENTER></BODY></HTML>