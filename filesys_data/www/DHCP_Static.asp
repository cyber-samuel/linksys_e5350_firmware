<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>DHCP Reservation</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("pop_filelink.asp"); %>
<SCRIPT language="Javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capsec.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/share.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/help.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capwrt54g.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capadmin.js"></SCRIPT>
<SCRIPT language="Javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capstatus.js"></SCRIPT>
<SCRIPT language="Javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capsetup.js"></SCRIPT>
<SCRIPT language="Javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capasg.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/layout.js"></SCRIPT>
<script language="JavaScript">
setFormActions({
save:    'javascript:toSubmit()',
cancel:  'javascript:showWait();cancel_change()',
refresh: 'javascript:refresh()',
close:   true
});
document.title = adbutton.dhcpres;
var close_session = "<% get_session_status(); %>";
var session_key = "<% nvram_get("session_key"); %>";
var statics_table = new Array(
<% dump_dhcp_statics(""); %>
);
var table = new Array(
<% dumpleases(""); %>
);
var static_clients = new Array("");
var static_num = 0;
var MAX_LEASE = 254;
var ns4 = (document.layers)? true:false ;
var ie4 = (document.all)? true:false;
var ie5  = (document.all && document.getElementById);
var ns6 = (!document.all && document.getElementById);
function DataShow() {
var prefix = '<% prefix_ip_get("lan_ipaddr",2); %>';
var tbody = document.getElementById("dhcp_statics_table");
var row, td1, td2, td3, td4;
for( var i = tbody.children.length ; i > 0; i-- )
tbody.removeChild(tbody.children[i-1]);
for( var j = 0 ; j < static_num ; j++ )
{
if (static_clients[j*3+2] !="")
{
row = document.createElement("tr");
td1 = document.createElement("td");
td2 = document.createElement("td");
td3 = document.createElement("td");
td4 = document.createElement("td");
td2.dir = 'ltr';
td1.innerHTML = '<input type="text" maxLength="15" size="16" name="static_client_name_' + j + '" value="' + unescape(static_clients[j*3]) + '" onblur="valid_name1(this,\'\')" />';
td2.innerHTML = prefix + '<input type="text" maxLength="3" style="width:40px" name="static_client_ip_' + j + '" value="' + static_clients[j*3+1] + '" onblur="isdigit(this,\'IP\')" />';
td3.innerHTML = static_clients[j*3+2];
td4.innerHTML = '<button class="btn" type="button" name="remove_' + j + '" onclick="delRow(' + j + ')">' + sbutton.remove + '</button>';
row.appendChild(td1);
row.appendChild(td2);
row.appendChild(td3);
row.appendChild(td4);
tbody.appendChild(row);
}
}
}
function addRow(row_id, name, ip, mac)
{
}
function valid_macs_all(I)
{
if(I.value == "")
return true;
else if(I.value.length == 12)
valid_macs_12(I);
else if(I.value.length == 17)
valid_macs_17(I);
else{
alert(errmsg.err5);
I.value = I.defaultValue;
}
}
function delRow(idx)
{
var list = [];
for(var i = 0 ; i < static_num ; i++ )
{
if( idx != i )
{
list.push(static_clients[i*3+0]);
list.push(static_clients[i*3+1]);
list.push(static_clients[i*3+2]);			
}
if(i <19)
{
choose_enable(document.dhcp_statics.add1);
}      
}
static_clients = list;
static_num--;
DataShow();
}
function select_add()
{
var i, j;
var count  = 0;
for (i=0 ; i<MAX_LEASE; i++) {
if (document.dhcp_statics['dhcp_select_name_'+i] && document.dhcp_statics['dhcp_select_mac_'+i] && document.dhcp_statics['dhcp_select_check_'+i]) {
document.dhcp_statics['dhcp_select_mac_'+i].value = document.dhcp_statics['dhcp_select_mac_'+i].value.toUpperCase();
if (document.dhcp_statics['dhcp_select_check_'+i].checked == true) {
count++;
for (j = 0;  j < static_num; j++) {
if (static_clients[(j*3)+2] == document.dhcp_statics['dhcp_select_mac_'+i].value) {
alert(errmsg.err52);
document.dhcp_statics['dhcp_select_check_'+i].checked = false;
update_checked(document.dhcp_statics['dhcp_select_check_'+i]);
return;
}
if (static_clients[(j*3)+1] == document.dhcp_statics['dhcp_select_ip_'+i].value) {
alert(errmsg.err55);
document.dhcp_statics['dhcp_select_check_'+i].checked = false;
update_checked(document.dhcp_statics['dhcp_select_check_'+i]);
return;
}
}
}
}
}
if (count == 0) {
alert(errmsg.err53);
return;
}
for (i=0 ; i<MAX_LEASE ; i++) {
if (document.dhcp_statics['dhcp_select_name_'+i]) {
if (document.dhcp_statics['dhcp_select_check_'+i].checked == true) {
var num = new Array();
static_clients[static_num*3] = document.dhcp_statics['dhcp_select_name_'+i].value;
static_clients[(static_num*3)+1] = document.dhcp_statics['dhcp_select_ip_'+i].value;
num = static_clients[(static_num*3)+1].split('.');
static_clients[(static_num*3)+1] = num[3];
static_clients[(static_num*3)+2] = document.dhcp_statics['dhcp_select_mac_'+i].value;
static_num++;
document.dhcp_statics['dhcp_select_check_'+i].checked = false;
update_checked(document.dhcp_statics['dhcp_select_check_'+i]);
}
}
}
DataShow();  //John
}
function manual_add()
{
var i, j;
var prefix = '<% prefix_ip_get("lan_ipaddr",2); %>';
document.dhcp_statics.manual_mac.value = document.dhcp_statics.manual_mac.value.toUpperCase();
if (document.dhcp_statics.manual_name.value == "") {
alert(errmsg.err54);
document.dhcp_statics.manual_name.focus();
return false;
}
if(is_lanip(IP_LAST,document.dhcp_statics.manual_ip.value)) {
alert(errmsg.err62);
document.dhcp_statics.manual_ip.focus();
return false;
}
if(!check_subnet(document.dhcp_statics.manual_ip))
{
document.dhcp_statics.manual_ip.focus();
return false;
}
if(document.dhcp_statics.manual_mac.value == "00:00:00:00:00:00" || document.dhcp_statics.manual_mac.value == "FF:FF:FF:FF:FF:FF") {
alert(errmsg.err17);
document.dhcp_statics.manual_mac.focus();
return false;
}
/*Wenxuan add edge need*/
var userAgent = navigator.userAgent;
var isEdge = userAgent.indexOf("Edge") > -1;
if(isEdge)
{
if(valid_macs_17(document.dhcp_statics.manual_mac) == false)
{
return; 
}
}
/*Wenxuan add edge need*/
for (i = 0;  i < static_num; i++) {
if (static_clients[(i*3)+2] == document.dhcp_statics.manual_mac.value) {
alert(errmsg.err52);
document.dhcp_statics.manual_mac.focus();
return false; 
}
if (static_clients[(i*3)+1] == document.dhcp_statics.manual_ip.value) {
alert(errmsg.err55);
document.dhcp_statics.manual_ip.focus();
return false;
}
}
/*Wenxuan add edge need*/
var userAgent = navigator.userAgent;
var isEdge = userAgent.indexOf("Edge") > -1;
if(isEdge)
{
if(!valid_ip_range(document.dhcp_statics.manual_ip))
return;
if(!valid_name1(document.dhcp_statics.manual_name))
return;
}
/*Wenxuan add edge need*/
for (i = 0;  i < static_num; i++) {
if(i >=18)
{
choose_disable(document.dhcp_statics.add1);
}       
}
static_clients[static_num*3] = document.dhcp_statics.manual_name.value;
static_clients[(static_num*3)+1] = document.dhcp_statics.manual_ip.value;
static_clients[(static_num*3)+2] = document.dhcp_statics.manual_mac.value;
static_num = static_num + 1;
document.dhcp_statics.manual_name.value = "";
document.dhcp_statics.manual_ip.value = "0";
document.dhcp_statics.manual_mac.value = "00:00:00:00:00:00";
DataShow(); //John
return true;
}
function check_subnet(ReserIp)
{
var mask = new Array();
var lanip3;
var start_ip_min, start_ip_max;
var iplen, iprange;
mask = window.parent.document.getElementById("lan_netmask").value.split(".");
iprange = 256 - parseInt(mask[3]);
iplen = 256 / iprange;
lanip3 = parseInt('<% get_single_ip("lan_ipaddr",3); %>');
start_ip_min = (parseInt(mask[3])&lanip3) + 1;
start_ip_max = start_ip_min + iprange - 3;
if(parseInt(ReserIp.value) > start_ip_max || ReserIp.value == "" || ReserIp.value == "0")
{
alert(errmsg.err14 + '['+ start_ip_min + ' - ' + start_ip_max +'].');
ReserIp.value = ReserIp.defaultValue;
return false;
}
return true;
}
function valid_ip_range(I)
{
if(I.value != 0){
if(!valid_range(I,1,254,"IP"))
return false;
}
return true;
}
function init()
{
for (i = 0; statics_table[i];) {
static_clients[i] = statics_table[i];   //name
static_clients[i+1] = statics_table[i+2]; //ip
static_clients[i+2] = statics_table[i+1]; //mac
i += 3;
static_num = static_num + 1;
}
document.dhcp_statics.manual_name.value = document.dhcp_statics.table_manual_name.value;
document.dhcp_statics.manual_ip.value = document.dhcp_statics.table_manual_ip.value;
document.dhcp_statics.manual_mac.value = document.dhcp_statics.table_manual_mac.value;
if(document.dhcp_statics.manual_ip.value == "")	
{
document.dhcp_statics.manual_ip.value = "0";
}
if(document.dhcp_statics.manual_mac.value == "")
{
document.dhcp_statics.manual_mac.value = "00:00:00:00:00:00";
}
DataShow();
<!-- WenXuan Add**>
var ret=1;
for (i=0 ; i<MAX_LEASE; i++) 
{
if (document.dhcp_statics['dhcp_select_name_'+i] && document.dhcp_statics['dhcp_select_mac_'+i] && document.dhcp_statics['dhcp_select_check_'+i]) 
{
for (j = 0;  j < static_num; j++) 
{
if (static_clients[(j*3)+2] == document.dhcp_statics['dhcp_select_mac_'+i].value) 
{
document.getElementById('dhcp_select_name_'+i).style.display = 'none';
document.getElementById('wireless'+i).style.display = 'none';
document.getElementById('dhcp_select_ip_'+i).style.display = 'none';
document.getElementById('dhcp_select_mac_'+i).style.display = 'none';
document.getElementById('dhcp_select_check_'+i).style.display = 'none';
}
}
}       
}       
for (i=0 ; i<MAX_LEASE; i++)
{
if (document.dhcp_statics['dhcp_select_name_'+i] && document.dhcp_statics['dhcp_select_mac_'+i] && document.dhcp_statics['dhcp_select_check_'+i]) 
{
if(document.getElementById('dhcp_select_name_'+i).style.display == '')
{
ret = 0;
}
}
}
if(ret == 1 && document.getElementById('h0'))
{
document.getElementById('h0').style.display = '';
document.getElementById('h1').style.display = '';
document.getElementById('h2').style.display = '';
document.getElementById('h3').style.display = '';
document.getElementById('h4').style.display = '';
}
<!-- WenXuan Add -->
for (i = 0;  i < static_num; i++) {
if(i >=19)
{
choose_disable(document.dhcp_statics.add1);
}       
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
function reload()
{
document.location.href = "DHCP_Static.asp"
}
function saveSuccess()
{
var obj = window.parent.document.getElementById('alertArea'),
title = other.success,
cls = 'success',
sec = 3;
obj.className = 'alert';
addClassName(obj, 'alert-' + cls);
obj.getElementsByTagName('h4')[0].innerHTML = title;
obj.getElementsByTagName('p')[0].innerHTML = other.succsavechg;
obj.style.display = '';
alertTimer = setTimeout(hideAlert, sec * 1000);	
}
function toSubmit()
{
var i;
new_clients = "";
/*for (i = 0; i < static_num; i++) {
new_clients += static_clients[(i*3)+2] + " ";
new_clients += static_clients[(i*3)+1] + " on ";
new_clients += static_clients[(i*3)+0] + ";";
}*/
/*Wenxuan add edge need*/
var userAgent = navigator.userAgent;
var isEdge = userAgent.indexOf("Edge") > -1;
if(isEdge)
{
for(j = 0 ; j < static_num ; j++ )
{
if(!isdigit(document.dhcp_statics['static_client_ip_' + j],'IP') || !valid_name1(document.dhcp_statics['static_client_name_' + j]))    
return ;        
}       
if(!valid_name1(document.dhcp_statics.manual_name) || !valid_macs_17(document.dhcp_statics.manual_mac))
return;
}
/*Wenxuan add edge need*/
/*if(document.dhcp_statics.manual_name.value != "" || document.dhcp_statics.manual_ip.value != "0" || document.dhcp_statics.manual_mac.value != "00:00:00:00:00:00")
{
if(!manual_add())
return;
}*/
for (i = 0; i < static_num; i++) {
if(is_lanip(IP_LAST,document.dhcp_statics['static_client_ip_'+i].value)) {
alert(errmsg.err62);
return;
}
if(!check_subnet(document.dhcp_statics['static_client_ip_'+i])) {
document.dhcp_statics['static_client_ip_'+i].focus();
return;
}
if (document.dhcp_statics['static_client_name_'+i].value == "") {
alert(errmsg.err54);
document.dhcp_statics['static_client_name_'+i].focus();
return;
}
var j;
for(j = i+1;j<static_num;j++)
{
if(document.dhcp_statics['static_client_ip_'+i].value == document.dhcp_statics['static_client_ip_'+ j].value)
{
alert(errmsg.err55);
document.dhcp_statics['static_client_ip_'+i].focus();
return;
}
}
new_clients += static_clients[(i*3)+2] + " ";
new_clients += document.dhcp_statics['static_client_ip_'+i].value + " on ";
new_clients += special_char_trans(document.dhcp_statics['static_client_name_'+i].value) + ";";
}
if(!(document.dhcp_statics.manual_name.value == "" && (document.dhcp_statics.manual_ip.value == "" || document.dhcp_statics.manual_ip.value == "0") && document.dhcp_statics.manual_mac.value == "00:00:00:00:00:00"))
{
if(document.dhcp_statics.manual_name.value == "")
{
alert(errmsg.err54);
document.dhcp_statics.manual_name.focus();
return false;
}
if(document.dhcp_statics.manual_ip.value == "" || document.dhcp_statics.manual_ip.value == "0" || is_lanip(IP_LAST,document.dhcp_statics.manual_ip.value))
{
if(!check_subnet(document.dhcp_statics.manual_ip) || !valid_ip_range(document.dhcp_statics.manual_ip))
{
document.dhcp_statics.manual_ip.focus();
return false;
}	
}
if(document.dhcp_statics.manual_mac.value == "00:00:00:00:00:00")
{
alert(errmsg.err17);
document.dhcp_statics.manual_mac.focus();
return false;
}
}
document.dhcp_statics.table_manual_name.value = document.dhcp_statics.manual_name.value;
document.dhcp_statics.table_manual_ip.value = document.dhcp_statics.manual_ip.value;
document.dhcp_statics.table_manual_mac.value = document.dhcp_statics.manual_mac.value;	
if ( close_session == "1" )
{
parent.setTimeout("location.replace(\"Lan_Setup.asp\")", 1000);
}
else
{
parent.setTimeout("location.replace(\"Lan_Setup.asp?session_id=<% nvram_get("session_key"); %>\")", 1000);
}
showWait(0,true);
saveSuccess();
document.dhcp_statics.new_clients.value = new_clients;
document.dhcp_statics.submit_button.value="DHCP_Static";
document.dhcp_statics.gui_action.value = "Apply";
document.dhcp_statics.submit();
}
function cancel_change()
{
if ( close_session == "1" )
{
document.location.href = "DHCP_Static.asp"
}
else
{
document.location.href = "DHCP_Static.asp?session_id=" + session_key;
}
}
function refresh()
{
if ( close_session == "1" )
{
document.location.replace("DHCP_Static.asp");
}
else
{
document.location.replace("DHCP_Static.asp?session_id=" + session_key);
}
}
</script>
<BODY onload="init()" bgColor="#808080">
<CENTER>
<form name="dhcp_statics" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" value="Apply" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="small_screen" />
<input type="hidden" name="dhcp_reservation" />
<input type="hidden" name="new_clients" value="" />
<input type="hidden" name="wait_time" value="3" />
<input type="hidden" name="table_manual_name" value="<% nvram_get("table_manual_name"); %>"/>
<input type="hidden" name="table_manual_ip" value="<% nvram_get("table_manual_ip"); %>"/>
<input type="hidden" name="table_manual_mac" value="<% nvram_get("table_manual_mac"); %>"/>
<!--input type="hidden" name="next_page" value="DHCP_Static.asp" -->
<script>var PopTitle = stabutton.dhcpclitbl;</script>
<% web_include_file("pop_Top.asp"); %>
<script>draw_table(MAINFUN2,dhcp.selectcli.replace('<BR>', '').replace('&nbsp;', ''));</script>
<div style="overflow-x:auto;height:300px;">
<div class="table-box-warpper table-responsive">
<table class="table table-info-bg table-bordered">
<thead>
<tr>
<td><script>Capture(share.cliname)</script></td>
<td><script>Capture(share.inter_face)</script></td>
<td><script>Capture(share.ipaddr)</script></td>
<td><script>Capture(share.macaddr)</script></td>
<td><script>Capture(dhcp.select)</script></td>
</tr>
</thead>
<tbody>
<script language="javascript">
var i = 0;
var count = 0;
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
if(table[i+4] == "WL")
table[i+4] = bmenu.wireless;
else if(table[i+4] == "G")
table[i+4] = bmenu.wireless+"-G";
else if(table[i+4] == "B")
table[i+4] = bmenu.wireless+"-B";
else if(table[i+4] == "A")
table[i+4] = bmenu.wireless+"-A";
else if(table[i+4] == "N")
table[i+4] = bmenu.wireless+"-N";
else if(table[i+4] == "LAN")
table[i+4] = "LAN";
document.write('<tr>');
document.write('<td id='+ 'dhcp_select_name_' + count + '>');
document.write('<input type="hidden" name="dhcp_select_name_' + count + '"  value="' + table[i] + '" />' + table[i]);
document.write('</td>');
document.write('<td id=' + 'wireless'+ count + '>'); 
document.write(table[i+4]);     
document.write('</td>');
document.write('<td id='+ 'dhcp_select_ip_' + count + '>');
document.write('<input type="hidden" name="dhcp_select_ip_' + count + '"  value="' + table[i+1] + '" />' + table[i+1]);
document.write('</td>');
document.write('<td id='+ 'dhcp_select_mac_' + count + '>');
document.write('<input type="hidden" name="dhcp_select_mac_' + count + '"  value="' + table[i+2] + '" />' + table[i+2]);
document.write('</td>');
document.write('<td id='+ 'dhcp_select_check_' + count + '>');
if( ret == '1' )
document.write('&nbsp;');
else
draw_checkbox('dhcp_select_check_' + count);
document.write('</td>');
document.write('</tr>');
count++;
if(ret == 1)
break;
i = i + 5;
}
<!-- Wenxuan add-->
if(ret != 1)
{
document.write('<td id=h0 style="display:none">'); 
document.write(wlanadv.none);     
document.write('</td>');
document.write('<td id=h1 style="display:none">'); 
document.write(wlanadv.none);     
document.write('</td>');
document.write('<td id=h2 style="display:none">'); 
document.write(wlanadv.none);     
document.write('</td>');
document.write('<td id=h3 style="display:none">'); 
document.write(wlanadv.none);     
document.write('</td>');
document.write('<td id=h4 style="display:none">'); 
document.write('&nbsp;');
document.write('</td>');
}
<!-- Wenxuan add-->
</script>
</tbody>
</table>
</div>
<div class="text-right" style="margin-top: -1em; margin-bottom: 1em;">
<script>draw_button("javascript:select_add()", sbutton.addcli, '', 'short')</script>
</div>
<script>draw_table(MAINFUN2,dhcp.manualadd);</script>
<div class="table-box-warpper table-responsive">
<table class="table table-info-bg table-bordered">
<thead>
<tr>
<td><script>Capture(dhcp.entercli)</script></td>
<td><script>Capture(dhcp.assignip)</script></td>
<td><script>Capture(dhcp.tomac)</script></td>
<td>&nbsp;</td>
</tr>
</thead>
<tbody>
<tr>
<td>
<input type="text" maxLength="15" size="13" name="manual_name" value="" onblur="valid_name1(this,'')" />
</td>
<td dir="ltr">
<% prefix_ip_get("lan_ipaddr",1); %>
<input type="text" class="num" maxLength="3" style="width:40px" name="manual_ip" value="0" onBlur="valid_ip_range(this)" />
</td>
<td>
<input type="text" maxLength="17" size="15" name="manual_mac" value="00:00:00:00:00:00" onBlur="valid_macs_17(this)" />
</td>
<td>
<script>draw_button("javascript:manual_add()", portsrv.add, 'add1')</script>
</td>
</tr>
</tbody>
</table>
</div>
<script>draw_table(MAINTITLE,dhcp.clires);</script>
<div class="table-box-warpper table-responsive">
<table class="table table-info-bg table-bordered">
<thead>
<tr>
<td><script>Capture(share.cliname)</script></td>
<td><script>Capture(dhcp.assignip)</script></td>
<td><script>Capture(dhcp.tomac)</script></td>
<td>&nbsp;</td>
</tr>
</thead>
<tbody id="dhcp_statics_table">
</tbody>
</table>
</div>
</div>
<% web_include_file("pop_Bottom.asp"); %>
</FORM></CENTER></BODY></HTML>
