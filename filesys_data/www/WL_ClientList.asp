<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Wireless Client List</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("pop_filelink.asp"); %>
<SCRIPT language="Javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capsec.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/share.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/help.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capapp.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capasg.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capwrt54g.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capstatus.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/layout.js"></SCRIPT>
<SCRIPT language="javascript">
document.title = wlanbutton.clilist;
var close_session = "<% get_session_status(); %>";
function en_add(F)
{
choose_disable(F.add);
for(var k=0;k<i;k++)
{
if(document.getElementById('m'+k).checked)
{
choose_enable(F.add);
}
}
}
function to_add(F)
{
F.submit_button.value="WL_ClientList";
F.change_action.value="gozila_cgi";
F.submit_type.value="add_mac";
F.submit();
}
function SoryBy(F)
{
showWait();
F.submit_button.value="WL_ClientList";
F.change_action.value="gozila_cgi";
F.submit();
}
function init()
{
<% onload("WL_ClientList", "setTimeout('parent.location.reload();',500);"); %>
window.focus();
en_add(document.wireless);
if ( close_session == "1" )
{
document.forms[0].action= "apply.cgi";
}
else
{
document.forms[0].action= "apply.cgi?session_id=<% nvram_get("session_key"); %>";
}
}
function refresh()
{
if ( close_session == "1" )
{
document.location.replace("WL_ClientList.asp");
}
else
{
document.location.replace("WL_ClientList.asp?session_id=<% nvram_get("session_key"); %>");
}
}
</SCRIPT>
</HEAD>
<BODY bgColor="#808080" onload="init()">
<CENTER>
<FORM name="wireless" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<script>var PopTitle = wlanbutton.clilist;</script>
<% web_include_file("pop_Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(dhcptbl.tosortby)</script></td>
<td>
<script>
(function(){
var str = [share.ipaddr, share.macaddr, bmenu.statu, share.cliname],
val = ['ip', 'mac', 'status',  'name'];
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
<td><script>Capture(bmenu.statu)</script></td>
<td><script>Capture(wlanfilter.savetomac)</script></td>
</tr>
</thead>
<tbody>
<script language="javascript">
var table = new Array();
var sortby = "<% nvram_selget("sortby"); %>";
var wl_maclist = "<% nvram_get("wl_maclist"); %>";
<% wireless_active_table("all_table"); %>
function AAA(name,ip,mac,iface,status, check)
{
this.name = name;
this.ip = ip;
this.mac = mac;
this.iface = iface;
this.status = status;
this.check = check;
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
function ByStatus(a,b)
{
if( a.status > b.status ) return 1;
else if (a.status == b.status ) return 0;
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
else if(sortby == "status") {
table.sort(ByStatus);
}
else if(sortby == "iface") {
table.sort(ByIface);
}
var i = 0;
var ip = new Array();
var ret = 0;
var check = "";
var macs = new Array();
macs = wl_maclist.split(' ');
for(i=0;;i++) {
if(table.length == 0) {
table[0] = new AAA(wlanadv.none,wlanadv.none,wlanadv.none,wlanadv.none,wlanadv.none,wlanadv.none);
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
if(table[i].status == "1")
table[i].status = stacontent.conn;
else if (table[i].status == "0")
table[i].status = hstatrouter2.disconnected;
check = "";
for(var j=0 ; j<macs.length ; j++) {
if(macs[j] == table[i].mac) {
check = "checked";
break;
}
}
document.write('<tr>');
document.write('<td>' + table[i].name + '</td>');
document.write('<td>' + table[i].iface + '</td>');
document.write('<td>' + table[i].ip + '</td>');
document.write('<td>' + table[i].mac + '</td>');
document.write('<td>' + table[i].status + '</td>');
document.write('<td>');
if(ret == 1)
document.write('&nbsp;');
else
draw_checkbox('m' + i, '', '' + table[i].mac, 'en_add(this.form)', check);
document.write('</td>');
document.write('</tr>');
if(ret == 1)
break;
}
</script>
</tbody>
</table>
</div>
<div class="modal-footer">
<script>
draw_button("javascript:showWait(0,true);to_add(document.wireless)", portsrv.add, 'add');
draw_button("javascript:showWait();refresh()", sbutton.refresh,  'Refresh');
draw_button("javascript:closePopout()", sbutton.close,  'close');
</script>
</div>
</FORM></CENTER></BODY></HTML>
