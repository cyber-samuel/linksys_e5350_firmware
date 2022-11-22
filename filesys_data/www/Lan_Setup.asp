<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Basic Setup</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<link rel="stylesheet" href="dhtmlwindow<% ui_position("match", "_rtl"); %>.css" type="text/css" />
<script type="text/javascript" src="dhtmlwindow.js">
/***********************************************
* DHTML Window Widget- ? Dynamic Drive (www.dynamicdrive.com)
* This notice must stay intact for legal use.
* Visit http://www.dynamicdrive.com/ for full source code
***********************************************/
</script>
<link rel="stylesheet" href="modal.css" type="text/css" />
<script type="text/javascript" src="modal.js"></script>
<script type="text/javascript" src="language.js" charset="UTF-8"></script>
<SCRIPT language="JavaScript">
setFormActions({
save:    true,
cancel:		true
});
document.title = topmenu.basicsetup;
var close_session = "<% get_session_status(); %>";
var EN_DIS2 = '<% nvram_get("mtu_enable"); %>';	
var DHCPRef = null;
function valid_url(I)
{
var match = 0;
for(i=0 ; i<I.value.length; i++){
ch = I.value.charAt(i);
if(ch == '.'){
match = 1;
break;
}
}
if(match == 0 || (match == 1 && i == 0) || (match == 1 && i == I.value.length-1)) {
alert("Illegal HTTP Format!");
I.value = I.defaultValue;	
return false;
}
else
return true;
}
function valid_mtu(I)
{
var min = '<% get_mtu("min"); %>';
var max = '<% get_mtu("max"); %>';
valid_range(I,min,max,"MTU");
d = parseInt(I.value, 10);
if(d > max) {
I.value = max ;
}
if(d < min) {
I.value = max ;
}
}
function SelMTU(num,F)
{
mtu_enable_disable(F,num);
}
function mtu_enable_disable(F,I)
{
EN_DIS1 = I;
if ( I == "0" )
choose_disable(F.wan_mtu);
else
choose_enable(F.wan_mtu);
}
function SetControlStatus(F,status,startname,endname)
{
var start = '';
var end = '';
var total = F.elements.length;
for(i=0 ; i < total ; i++){
if(F.elements[i].name == startname)       start = i;
if(F.elements[i].name == endname)         end = i;
}
if(start == '' || end == '')    
return true;
for(i = start; i<=end ;i++)
{
if(status==0)
{
choose_disable(F.elements[i]);
}
else
{
choose_enable(F.elements[i]);
}
}
}
function to_submit(F)
{
/*Wenxuan add edge need*/
var userAgent = navigator.userAgent;
var isEdge = userAgent.indexOf("Edge") > -1;
if(isEdge)
{
if(!valid_range(F.dhcp_lease,0,9999,'DHCP%20Lease%20Time') || !valid_range(F.lan_ipaddr_0,1,223,'IP') || !valid_range(F.lan_ipaddr_1,0,255,'IP') || !valid_range(F.lan_ipaddr_2,0,255,'IP') || !valid_range(F.lan_ipaddr_3,1,254,'IP') || !valid_range(F.wan_dns0_0,0,223,'DNS') || !valid_range(F.wan_dns0_1,0,255,'DNS') || !valid_range(F.wan_dns0_2,0,255,'DNS') || !valid_range(F.wan_dns0_3,0,254,'DNS') || !valid_range(F.wan_dns1_0,0,223,'DNS') || !valid_range(F.wan_dns1_1,0,255,'DNS') || !valid_range(F.wan_dns1_2,0,255,'DNS') || !valid_range(F.wan_dns1_3,0,254,'DNS') || !valid_range(F.wan_dns2_0,0,223,'DNS') || !valid_range(F.wan_dns2_1,0,255,'DNS') || !valid_range(F.wan_dns2_2,0,255,'DNS') || !valid_range(F.wan_dns2_3,0,254,'DNS') || !valid_range(F.wan_wins_0,0,223,'WINS') || !valid_range(F.wan_wins_1,0,255,'WINS') || !valid_range(F.wan_wins_2,0,255,'WINS') || !valid_range(F.wan_wins_3,0,254,'WINS') || !Sel_SubMask_onblur(document.setup.lan_netmask,document.setup,'dhcp_start') || !Sel_SubMask_onblur(document.setup.lan_netmask,document.setup,'dhcp_num'))
return;
}
/*Wenxuan add edge need*/
var wan_ipv6_dhcp = "<% nvram_get("wan_ipv6_dhcp"); %>";
if(F._lan_proto.checked == true )	F.lan_proto.value = "dhcp";
else					F.lan_proto.value = "static";
if(F.lan_ipaddr_0.value == '127')
{
alert(errmsg.err62);
F.lan_ipaddr_0.focus();
return;
}
if(F.switch_mode.value==1 ||
F.switch_mode.value != '<% nvram_get("switch_mode"); %>')
{
F.wait_time.value="40";
F.need_reboot.value="1";
}
if(F.switch_mode.value==0)
{	
var lanip = F.lan_ipaddr_3.value ; 
/*Jemmy add for setting device name 2010.2.24*/
F.hnap_devicename.value = F.machine_name.value;
F.dhcp_start.value = F.dhcp_start_tmp.value;
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "/*"); %>
if ( parseInt(lanip) == parseInt(F.dhcp_start_tmp.value) )
{	
F.dhcp_start.value++;
F.dhcp_start_conflict.value = 1;
}
else
F.dhcp_start_conflict.value = 0;
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "*/"); %>
DHCP_IP_RANGE(F,F.lan_netmask.value,F.lan_ipaddr_3.value);
var sip = DHCP_START_IP[0];
if ( sip == 100 ) sip = 0 ; 
var num = sip+parseInt(F.dhcp_num.value); 
var xnum = parseInt(parseInt(sip)+parseInt(MAX_RANGE_COUNT));
if ( parseInt(lanip) == parseInt(F.dhcp_start.value) )
{
alert(errmsg.err62);
return ; 
}
if ( parseInt(F.dhcp_start.value) < parseInt(sip) )  
{
alert(errmsg.err2);
return ; 
}
if ( RANGE_SET == 1 ) 
{
if  (((parseInt(sip) > parseInt(num)) || (parseInt(xnum) < parseInt(num))) && F._lan_proto.checked == true)
{
alert(errmsg.err2);
return ; 	
}
}
else if ( RANGE_SET == 2 ) 
{
if ( (parseInt(num) < parseInt(sip)) || (parseInt(num) > parseInt(xnum)) )
{
alert(errmsg.err2);
return ; 	
}
}
/*if (document.getElementById("DymRange").innerHTML == "")
{
alert(errmsg.err2);
return;
}*/
/*if(is_lanip(IP_LAST,document.setup.dhcp_start_tmp.value)) {
alert(errmsg.err62);
document.setup.dhcp_start_tmp.focus();
return;
}*/
var a1 = parseInt(F.dhcp_start.value,10);
var a2 = parseInt(F.dhcp_num.value,10);
if( a1 + a2 > 255){
alert(errmsg.err2);
return ;
}
if( F.lan_netmask.value != "255.255.255.0" && !check_reservated_IP(F.lan_ipaddr_3, F.lan_netmask) && F._lan_proto.checked == true)
return;
if(DHCPRef)
DHCPRef.close();
if (valid_value(F) && valid_lan_ip(F)){
if ( F.lan_netmask.value == "255.255.255.252"){
choose_disable(F.dhcp_start_tmp);
choose_disable(F.dhcp_num);
}
}
}
else
{
alert("Not need to set up LAN settings.");
return;
}
if (!valid_device_name(document.forms[0].machine_name)){
return;
}
F.machine_name.defaultValue=F.machine_name.value;
F.submit_button.value = "index";
F.gui_action.value = "Apply";
if(F.need_redirect.value == "1")
{
var url;
var lanip = F.lan_ipaddr_0.value +"."+F.lan_ipaddr_1.value+"."+F.lan_ipaddr_2.value +"."+F.lan_ipaddr_3.value;
var https_enable = '<% nvram_get("https_enable"); %>';
var http_enable = '<% nvram_get("http_enable"); %>';
if(https_enable == "1" && http_enable == "0")
url = "https://"+lanip;
else if(http_enable == "1" && https_enable == "0" )
url = "http://"+lanip;
else if(http_enable == "1" && https_enable == "1")
url = "http://"+lanip;
ajaxSubmit("80","true",url);
}
else
ajaxSubmit("35","false");
}
function valid_value(F)
{
var ipaddr,lanip,wanip,wanmask, wangw;
lanip = F.lan_ipaddr_0.value +"."+F.lan_ipaddr_1.value+"."+F.lan_ipaddr_2.value +"."+F.lan_ipaddr_3.value;
wanip = "<% nvram_get("wan_ipaddr"); %>";
wanmask = "<% nvram_get("wan_netmask"); %>";
wangw = "<% nvram_get("wan_gateway"); %>";
if(F.now_proto.value == "static" 
|| (F.now_proto.value=="pptp" <% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "/*"); %>
&& F.sel_pptp_dhcp.value == "0" <% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "*/"); %>))
{
if(lanip == wanip)
{
alert(errmsg.err79);
return false; 
}
if (wanip != "" && wanmask != "" && valid_gn_ip(wanip, wanmask) == false)
{
alert(gn.err6);
return false;
}
}
if(!valid_dhcp_server(F))
return false;
return true; 
}
function valid_hb(I,M)
{
if(I.value == "0.0.0.0" || I.value == "255.255.255.255") {
alert(errmsg2.err0);
I.value = I.defaultValue;
return false;
}
return valid_name(I,M);
}
function valid_dhcp_server(F)
{
if(F.lan_proto.selectedIndex == 0)
return true;
F.dhcp_start.value = F.dhcp_start_tmp.value;
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "/*"); %>
if(F.lan_ipaddr_3.value == F.dhcp_start_tmp.value)
F.dhcp_start.value++;
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "*/"); %>
a1 = parseInt(F.dhcp_start.value,10);
a2 = parseInt(F.dhcp_num.value,10);
if( a1 + a2 > 255 ){
alert(errmsg.err2);
return false;
} 
if(!valid_ip_for_dns(F,"F.wan_dns0","DNS1",MASK_NO))
return false;
if(!valid_ip_for_dns(F,"F.wan_dns1", "DNS2",MASK_NO))
return false;
if(!valid_ip_for_dns(F,"F.wan_dns2","DNS3",MASK_NO))
return false;
if(!valid_ip(F,"F.wan_wins","WINS",MASK_NO))
return false;
valid_same_dns_ex(F,"F.wan_dns0","F.wan_dns1","F.wan_dns2");   
return true;
}
function SelDHCP(T,F)
{
dhcp_enable_disable(F,T);
}
function dhcp_enable_disable(F,T)
{
var start = '';
var end = '';
var total = F.elements.length;
for(i=0 ; i < total ; i++){
if(F.elements[i].name == "dhcp_res")	start = i;
if(F.elements[i].name == "wan_wins_3")	end = i;
}
if(start == '' || end == '')	return true;
if( F._lan_proto.checked == false ) {
EN_DIS = 0;
for(i = start; i<=end ;i++)
choose_disable(F.elements[i]);
}
else {
EN_DIS = 1;
for(i = start; i<=end ;i++)
choose_enable(F.elements[i]);
Sel_SubMask(F.lan_netmask,F,0);
}
if(F.now_proto.value == "static") {
disable_second_dns();
}
}
function getstyle(sname)
{
var i, j;
for (i=0;i<document.styleSheets.length;i++) {
var rules;
if (document.styleSheets[i].cssRules) {
rules = document.styleSheets[i].cssRules;
}
else {
rules = document.styleSheets[i].rules;
}
for (j=0;j<rules.length;j++) {
var s1,s2;
s1 = rules[j].selectorText.toUpperCase();
s2 = sname.toUpperCase();
if (s1==s2) {
return rules[j].style;
}
}
}
return undefined;
} 
function init()
{
var F = document.setup;
var str;
var sip;
var num;
var eip;	
var lang = "<%nvram_get("detect_lang");%>";
var wan_proto = "<% nvram_get("wan_proto"); %>";
var i, j;
var swmode = '<% nvram_get("switch_mode");%>';
var bridge_mode = "<% nvram_get("wbridge_mode");%>";
if( swmode == 1  )
{
alert(share.brdgmwn);
choose_disable(F.lan_ipaddr_0);
choose_disable(F.lan_ipaddr_1);
choose_disable(F.lan_ipaddr_2);
choose_disable(F.lan_ipaddr_3);
choose_disable(F.lan_netmask);
choose_disable(F.machine_name);
choose_disable(F._lan_proto);
choose_disable(F.dhcp_res);
choose_disable(F.dhcp_start_tmp);
choose_disable(F.dhcp_num);
choose_disable(F.dhcp_lease)
choose_disable(F.wan_dns0_0);
choose_disable(F.wan_dns0_1);
choose_disable(F.wan_dns0_2);
choose_disable(F.wan_dns0_3);
choose_disable(F.wan_dns1_0);
choose_disable(F.wan_dns1_1);
choose_disable(F.wan_dns1_2);
choose_disable(F.wan_dns1_3);
choose_disable(F.wan_dns2_0);
choose_disable(F.wan_dns2_1);
choose_disable(F.wan_dns2_2);
choose_disable(F.wan_dns2_3);
choose_disable(F.wan_wins_0);
choose_disable(F.wan_wins_1);
choose_disable(F.wan_wins_2);
choose_disable(F.wan_wins_3);
}
if(wan_proto == "static")
{
for (var i = 0 ; i < 4 ; i++)
for (var j = 0 ; j < 3 ; j++)
eval("document.getElementById(\"dns"+j+i+"\").value = 0;");
}
if(F.switch_mode.value==0)
{
F.dhcp_start_tmp.value = '<% nvram_get("dhcp_start");%>';
F.dhcp_start.value = F.dhcp_start_tmp.value;		
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "/*"); %>
F.dhcp_start_conflict.value = '<% nvram_get("dhcp_start_conflict"); %>';
if ( F.dhcp_start_conflict.value == 1 )
F.dhcp_start_tmp.value--;
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "*/"); %>
sip = F.dhcp_start.value ; //'<% nvram_get("dhcp_start"); %>';
num = F.dhcp_num.value; //'<% nvram_get("dhcp_num");%>';
eip = parseInt(parseInt(num)+parseInt(sip)-1);
}
if(F.switch_mode.value==0)
{
dhcp_enable_disable(document.setup,'<% nvram_get("lan_proto"); %>');
<% support_invmatch("DUAL_IMAGE_SUPPORT", "1", "//"); %> init_dual_image();
if ( '<% nvram_selget("time_zone"); %>' == '+12 2 4' ) {
document.setup.time_zone.selectedIndex = '37';
}
if(document.setup.now_proto.value == "static") {
disable_second_dns();
}
if ((parseInt(sip)<parseInt(F.lan_ipaddr_3.value)) && (parseInt(eip)>=parseInt(F.lan_ipaddr_3.value)))RANGESET = 2 ; 	     else RANGESET = 1; 
if ( RANGESET == 1 ) 
{
document.getElementById("DymRange").innerHTML = "<% prefix_ip_get("lan_ipaddr",1); %> "+sip+" "+portforward.to+" "+eip;
}
else if ( RANGESET == 2 ) 
{
document.getElementById("DymRange").innerHTML = "<% prefix_ip_get("lan_ipaddr",1); %> "+sip+" "+portforward.to+" "+parseInt(parseInt(F.lan_ipaddr_3.value)-1);
/*if ( parseInt(F.lan_ipaddr_3.value)+1 > eip )*/ eip = eip + 1 ; 
document.getElementById("DymRange").innerHTML += "<BR><% prefix_ip_get("lan_ipaddr",1); %> "+ parseInt(parseInt(F.lan_ipaddr_3.value)+1) + " "+portforward.to+" " + eip;
}
update_checked(F._lan_proto);	
if(F.lan_netmask.options[F.lan_netmask.selectedIndex].value == "255.255.255.252" || F._lan_proto.checked == false) {
choose_disable(F.dhcp_start_tmp);
choose_disable(F.dhcp_num);
}
else {
choose_enable(F.dhcp_start_tmp);
choose_enable(F.dhcp_num);
}
}
if(bridge_mode == 1)
{
alert(wlanbridge.warn);
choose_disable(F.lan_ipaddr_0);
choose_disable(F.lan_ipaddr_1);
choose_disable(F.lan_ipaddr_2);
choose_disable(F.lan_ipaddr_3);
choose_disable(F.lan_netmask);
choose_disable(F.machine_name);
choose_disable(F._lan_proto);
choose_disable(F.dhcp_res);
choose_disable(F.dhcp_start_tmp);
choose_disable(F.dhcp_num);
choose_disable(F.dhcp_lease)
choose_disable(F.wan_dns0_0);
choose_disable(F.wan_dns0_1);
choose_disable(F.wan_dns0_2);
choose_disable(F.wan_dns0_3);
choose_disable(F.wan_dns1_0);
choose_disable(F.wan_dns1_1);
choose_disable(F.wan_dns1_2);
choose_disable(F.wan_dns1_3);
choose_disable(F.wan_dns2_0);
choose_disable(F.wan_dns2_1);
choose_disable(F.wan_dns2_2);
choose_disable(F.wan_dns2_3);
choose_disable(F.wan_wins_0);
choose_disable(F.wan_wins_1);
choose_disable(F.wan_wins_2);
choose_disable(F.wan_wins_3);
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
setInitFormData(function(){
to_submit(document.forms[0])
});
}
function disable_second_dns()
{
document.getElementById("dns00").disabled = true;
document.getElementById("dns01").disabled = true;
document.getElementById("dns02").disabled = true;
document.getElementById("dns03").disabled = true;
document.getElementById("dns10").disabled = true;
document.getElementById("dns11").disabled = true;
document.getElementById("dns12").disabled = true;
document.getElementById("dns13").disabled = true;
document.getElementById("dns20").disabled = true;
document.getElementById("dns21").disabled = true;
document.getElementById("dns22").disabled = true;
document.getElementById("dns23").disabled = true;
}
function enable_second_dns()
{
document.getElementById("dns00").disabled = false;
document.getElementById("dns01").disabled = false;
document.getElementById("dns02").disabled = false;
document.getElementById("dns03").disabled = false;
document.getElementById("dns10").disabled = false;
document.getElementById("dns11").disabled = false;
document.getElementById("dns12").disabled = false;
document.getElementById("dns13").disabled = false;
document.getElementById("dns20").disabled = false;
document.getElementById("dns21").disabled = false;
document.getElementById("dns22").disabled = false;
document.getElementById("dns23").disabled = false;
}
function valid_gn_ip(I,M)
{	
var ip = new Array(4);
var mask = new Array(4);
var a_gn_lan_ip = new Array();
var a_lan_mask = new Array();
var gn_lan_ip = '<% nvram_get("gn_lan_ipaddr"); %>';
var gn_lan_mask = '<% nvram_get("gn_lan_netmask"); %>';
a_lan_ip = gn_lan_ip.split(".");
a_lan_mask = gn_lan_mask.split(".");
ip = I.split(".");
mask = M.split(".");
if((((a_lan_ip[0] & mask[0]) == (ip[0] & mask[0])) && ((a_lan_ip[1] & mask[1]) == (ip[1] & mask[1])) && 
((a_lan_ip[2] & mask[2]) == (ip[2] & mask[2])) && ((a_lan_ip[3] & mask[3]) == (ip[3] & mask[3])))
||(((a_lan_ip[0] & a_lan_mask[0]) == (ip[0] & a_lan_mask[0])) && ((a_lan_ip[1] & a_lan_mask[1]) == (ip[1] & a_lan_mask[1])) && 
((a_lan_ip[2] & a_lan_mask[2]) == (ip[2] & a_lan_mask[2])) && ((a_lan_ip[3] & a_lan_mask[3]) == (ip[3] & a_lan_mask[3]))))
{
return false;
}
return true;
}
function valid_lan_ip(F)
{
var mask = new Array(4);
var ip = new Array(4);
var netid = new Array(4);
var brcastip = new Array(4);	
var lanip;
for(i=0,j=0;i<4;i++,j=j+4)
{
ip[i]=eval("F.lan_ipaddr_"+i).value;
mask[i]=F.lan_netmask.value.substring(j, j + 3);
netid[i]=eval(ip[i]&mask[i]);
if(i<3)
brcastip[i]=netid[i];
else
brcastip[i]=eval(netid[i]+255-mask[i]);	
}
startip = eval(netid[3]+1);
endip = eval(brcastip[3]-1);
if( ip[0] == netid[0] && ip[1] == netid[1] && ip[2] == netid[2] && ip[3] == netid[3])
{
alert(errmsg.err14+" ["+startip+"-"+endip+"]");
F.lan_ipaddr_3.focus();
return false ; 
}
if( ip[0] == brcastip[0] && ip[1] == brcastip[1] && ip[2] == brcastip[2] && ip[3] == brcastip[3])
{
alert(errmsg.err14+" ["+startip+"-"+endip+"]");
F.lan_ipaddr_3.focus();
return false ; 
}	
if( (F.lan_ipaddr_0.value != F.lan_ipaddr_0.defaultValue) || (F.lan_ipaddr_1.value != F.lan_ipaddr_1.defaultValue) || (F.lan_ipaddr_2.value != F.lan_ipaddr_2.defaultValue) || (F.lan_ipaddr_3.value != F.lan_ipaddr_3.defaultValue) )
{
F.wait_time.value="21";
F.need_redirect.value="1";
}
return true;
}
function DHCP_Res()
{
showPopout('DHCP_Static.asp?session_id=<% nvram_get("session_key"); %>');
return;
if ( close_session == "1" )
{
DHCPRef = window.open('DHCP_Static.asp','DHCPResTable','alwaysRaised,resizable,scrollbars,width=710,height=500');
}
else
{
DHCPRef = window.open('DHCP_Static.asp?session_id=<% nvram_get("session_key"); %>','DHCPResTable','alwaysRaised,resizable,scrollbars,width=710,height=500');
}
DHCPRef.focus();
if( DHCPRef.opener == null )
DHCPRef.opener = window;
}
function Sel_SubMask(F,I,M)
{
var flg, MSG;
if(I.switch_mode.value==0)
{
if ( I._lan_proto.checked == false ) return ; // IF DHCP Server is disabled.
}	
if ( M )
{ 
if ( I.lan_ipaddr_3.value <= 0 || I.lan_ipaddr_3.value >254)
return false ; 
}
MSG = DHCP_IP_RANGE(I,F.value,I.lan_ipaddr_3.value);
switch ( RANGE_SET ) 
{
case 0 :
case -1 :
alert(MSG);
I.lan_ipaddr_3.value = I.lan_ipaddr_3.defaultValue;
return false; 
case 1 : 	
document.getElementById("DymRange").innerHTML = "<% prefix_ip_get("lan_ipaddr",1); %> " + DHCP_START_IP[0] + " "+portforward.to+" " + DHCP_END_IP[0];
I.dhcp_num.value = RANGE_COUNT;
I.dhcp_start_tmp.value = DHCP_START_IP[0];
break;
case 2 : 
document.getElementById("DymRange").innerHTML = "<% prefix_ip_get("lan_ipaddr",1); %> " + DHCP_START_IP[0] + " "+portforward.to+" " + DHCP_END_IP[0];
document.getElementById("DymRange").innerHTML += "<BR><% prefix_ip_get("lan_ipaddr",1); %> "+ DHCP_START_IP[1] + " "+portforward.to+" " + DHCP_END_IP[1];
I.dhcp_num.value = RANGE_COUNT;
I.dhcp_start_tmp.value = DHCP_START_IP[0];
break;
}
if(F.value == "255.255.255.252") {
choose_disable(I.dhcp_start_tmp);
choose_disable(I.dhcp_num);
}
else {
choose_enable(I.dhcp_start_tmp);
choose_enable(I.dhcp_num);
I.dhcp_num.defaultValue = I.dhcp_num.value;
I.dhcp_start_tmp.defaultValue = I.dhcp_start_tmp.value;
}
if( M == 0 && F.value != "255.255.255.0" )
check_reservated_IP(I.lan_ipaddr_3, F);
}
function check_reservated_IP(lanIp, Mask)
{
var static_route = "<% nvram_get("dhcp_statics"); %>";
if( static_route.length > 0 )
{
var route_array = static_route.split(";");
var submask = parseInt(Mask.value.split(".")[3]);
var subnet = submask & parseInt(lanIp.value);
var reserve_ip;
for ( var i = 0; i < (route_array.length-1); i++ ) {
reserve_ip = parseInt(route_array[i].split(" ")[1]);
if ((reserve_ip & submask) != subnet && document.forms[0]._lan_proto.checked == true)
{
alert(errmsg.err102 + ' '+ '['+ document.getElementById("DymRange").innerHTML + ']');
return false;
}
}
}
return true;
}
function Sel_SubMask_onblur(F,I,string)
{
var et = 256;
var st = 0;
var sip = new Array();
var eip = new Array();
var mask = new Array();
var lanip3;
var ucount;
var iplen, iprange;
var i;
var set2 = false;
var start_ip, max_num, dhcp_max_num;
var start_ip_min, start_ip_max;
mask = F.value.split(".");
iprange = 256 - parseInt(mask[3]);
iplen = 256 / iprange;
lanip3 = parseInt(I.lan_ipaddr_3.value);
start_ip_min = (parseInt(mask[3])&lanip3) + 1;
start_ip_max = start_ip_min + iprange - 3;
/* check if the lan ip is valid */
if( lanip3 == start_ip_min - 1 )
{
alert(errmsg.err77);
return false;
}
else if ( lanip3 == start_ip_max + 1 )
{
alert(errmsg.err78);
return false;
}
if( string == "dhcp_start" && valid_range(I.dhcp_start_tmp,start_ip_min,start_ip_max,"DHCP%20starting%20IP") == false )
{
return false;
}
I.dhcp_start.value = I.dhcp_start_tmp.value;
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "/*"); %>
if(I.lan_ipaddr_3.value == I.dhcp_start_tmp.value)
I.dhcp_start.value++;
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "*/"); %>
start_ip = parseInt(I.dhcp_start.value);
max_num = parseInt(I.dhcp_num.value);
if (lanip3 > start_ip)
dhcp_max_num = (parseInt(mask[3])&start_ip) + iprange - 3;
else
dhcp_max_num = (parseInt(mask[3])&start_ip) + iprange - 2;
if( string == "dhcp_num" && valid_range(I.dhcp_num,1,dhcp_max_num-start_ip+1,"Number%20of%20DHCP%20users") == false )
{
return false;
}
if ((iprange - 3) >= max_num)
ucount = max_num ;
else
{
alert(errmsg.err2);
return false;
}
now_count = ucount;
for(i = 0; i < iplen; i++)
{
if (iplen == 1) 
{
sip[0] = start_ip;
if((parseInt(lanip3) > parseInt(sip[0])) && ((parseInt(lanip3) - parseInt(sip[0])) < parseInt(ucount)))
{
eip[0] = parseInt(lanip3) - 1;
sip[1] = parseInt(lanip3) + 1;
eip[1] = parseInt(sip[1]) + parseInt(ucount) - (parseInt(eip[0]) - parseInt(sip[0])) - 2;
set2 = true; 
}
else 
eip[0] = parseInt(sip[0])+parseInt(ucount) - 1;
et = 256;
break;
}
else
{
st = i*iprange; 
et = (i + 1) * iprange;
if ((st < lanip3) && (lanip3 < et))
{
st = st + 1 ; //It can not be the network IP
if (st == lanip3)
{
sip[0] = st+1;
if((st < start_ip) && (start_ip <= et))
{
sip[0] = start_ip;
}
eip[0] = parseInt(sip[0]) + parseInt(ucount) - 1;
}
else
{
if (lanip3 - st >= ucount)
{
sip[0] = st ; 
if((st < start_ip) && (start_ip < et))
{
sip[0] = start_ip;
}
if((parseInt(lanip3) > parseInt(sip[0])) 
&& ((parseInt(lanip3) - parseInt(sip[0])) < parseInt(ucount)))
{
eip[0] = parseInt(lanip3) - 1;
sip[1] = parseInt(lanip3) + 1;
eip[1] = parseInt(sip[1]) + parseInt(ucount) - (parseInt(eip[0]) - parseInt(sip[0])) - 2;
set2 = true; 
}
else 
eip[0] = parseInt(sip[0]) + parseInt(ucount) - 1;
}
else
{
sip[0] = st ; 
if((st < start_ip) && (start_ip < et))
{
sip[0] = start_ip;
}
if((parseInt(lanip3) > parseInt(sip[0])) 
&& ((parseInt(lanip3) - parseInt(sip[0])) < parseInt(ucount)))
{
eip[0] = parseInt(lanip3) - 1;
sip[1] = parseInt(lanip3) + 1;
eip[1] = parseInt(sip[1]) + parseInt(ucount) - (parseInt(eip[0]) - parseInt(sip[0])) - 2;
set2 = true; 
}
else 
eip[0] = parseInt(sip[0]) + parseInt(ucount) - 1;
}
}                       
break;          
}
}
}
if((!set2 && (parseInt(sip[0]) + parseInt(ucount)) > (et - 1)) 
|| (set2 && (parseInt(sip[0]) + parseInt(ucount) + 1) > (et - 1)))
{
alert(errmsg.err2);
return false;
}
document.getElementById("DymRange").innerHTML =	"<% prefix_ip_get("lan_ipaddr",1); %> "+ sip[0] + " "+portforward.to+" " + eip[0];
if (set2 == true)
{
document.getElementById("DymRange").innerHTML += "<BR>" +"<% prefix_ip_get("lan_ipaddr",1); %> "+ sip[1] + " "+portforward.to+" " + eip[1];
}
I.dhcp_num.value = ucount;
if(I.dhcp_start.value != sip[0])
I.dhcp_start_tmp.value = sip[0];
return true;
}
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "/*"); %>
function selpptpmode(I)
{
var F = document.setup ; 
var len = F.elements.length;
var start ; 
var end ; 
var i ; 
for(i=0; i<len; i++)
{
if(F.elements[i].name=="wan_ipaddr") start = i ; 
if(F.elements[i].name=="wan_pptp_dns2_3") end = i ; 
}
if ( start == '' || end == '') return true ; 
for(i=start; i<=end; i++)
{
if ( I == 0 ) 
choose_enable(F.elements[i]);
else
choose_disable(F.elements[i]);
}
if ( I == 0 ) 
disable_second_dns();
else
enable_second_dns();
}
function getall(F,I)
{
var i , data=""; 
for(i=0; i<4; i++)
{
data = data + eval(I+"_"+i).value ; 
if ( i < 3 ) data = data + "." ; 
}
return data ; 
}
function getall_dns(F,I)
{
var i , data=""; 
for(i=0; i<4; i++)
{
data = data + eval(I+"_"+i+"[0]").value ; 
if ( i < 3 ) data = data + "." ; 
}
return data ; 
}
function valid_same_dns(F,N0,N1,N2)
{
var dns0, dns1, dns2;
dns0 = getall_dns(F,N0);
dns1 = getall_dns(F,N1);
dns2 = getall_dns(F,N2);
if(dns1 == dns0)
{
for(i=0;i<4;i++)
eval(N1+"_"+i+"[0]").value = 0;
}
if(dns2 == dns0)
{
for(i=0;i<4;i++)
eval(N2+"_"+i+"[0]").value = 0;
}
if(dns2 == dns1)
{
for(i=0;i<4;i++)
eval(N2+"_"+i+"[0]").value = 0;
}
}
function valid_same_dns_ex(F,N0,N1,N2)
{
var dns0, dns1, dns2;
dns0 = getall(F,N0);
dns1 = getall(F,N1);
dns2 = getall(F,N2);
if(dns1 == dns0)
{
for(i=0;i<4;i++)
eval(N1+"_"+i).value = 0;
}
if(dns2 == dns0)
{
for(i=0;i<4;i++)
eval(N2+"_"+i).value = 0;
}
if(dns2 == dns1)
{
for(i=0;i<4;i++)
eval(N2+"_"+i).value = 0;
}
}
function valid_ip_for_dns(F,N,M1,flag){
var m = new Array(4);
M = unescape(M1);
m = N.split('.');
if(m[0] == 127 || m[0] == 224){
alert(M + " : " + errmsg.err31);
return false;
}
if(m[0] == "0" && (m[1] != "0" || m[2] != "0" || m[3] != "0"))
{
alert(M + " : " + errmsg.err31);
return false;
}
if(m[0] == "0" && m[1] == "0" && m[2] == "0" && m[3] == "0"){
if(flag & ZERO_NO){
alert(errmsg.staticnodns);
return false;
}       
}
if((m[0] != "0" || m[1] != "0" || m[2] != "0") && m[3] == "0"){
if(flag & MASK_NO){
alert(M + " : " + errmsg.err31);
return false;
}       
}
return true;
}
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "*/"); %>
function valid_ip_for_dns_ex(F,N,M1,flag){
var m = new Array(4);
M = unescape(M1);
for(i=0;i<4;i++)
{
m[i] = document.getElementById(N+i).value;
}
if(m[0] == 127 || m[0] == 224){
alert(M + " : " + errmsg.err31);
return false;
}
if(m[0] == "0" && (m[1] != "0" || m[2] != "0" || m[3] != "0"))
{
alert(M + " : " + errmsg.err31);
return false;
}
if(m[0] == "0" && m[1] == "0" && m[2] == "0" && m[3] == "0"){
if(flag & ZERO_NO){
alert(errmsg.staticnodns);         
return false;
}
}
if((m[0] != "0" || m[1] != "0" || m[2] != "0") && m[3] == "0"){
if(flag & MASK_NO){
alert(M + " : " + errmsg.err31);
return false;
}       
}
return true;
}
function leave_page()
{
valid_lan_ip(document.setup);
if(document.setup.need_redirect.value == "0")
return checkFormChanged(document.setup);
}
function exit()
{
if (DHCPRef)
DHCPRef.close();
}
</SCRIPT>
</HEAD>
<BODY onload="init()" onunload="exit()" onbeforeunload = "return leave_page()">
<FORM name="setup" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="lan_proto" />
<input type="hidden" name="now_proto" value="<% nvram_gozila_get("wan_proto"); %>" />
<input type="hidden" name="wan_proto" value="<% nvram_get("wan_proto"); %>" />
<input type="hidden" name="sel_pptp_dhcp" value="<% nvram_get("sel_pptp_dhcp"); %>" />
<input type="hidden" name="daylight_time" value="0" />
<input type="hidden" name="switch_mode_dhcp" value="<% nvram_get("switch_mode_dhcp");%>" />
<input type="hidden" name="switch_mode" value="<% nvram_gozila_get("switch_mode");%>" />
<input type="hidden" name="switch_ipaddr" value="4" />
<input type="hidden" name="hnap_devicename" value="<% nvram_get("hnap_devicename");%>" />
<input type="hidden" name="need_reboot" value="0" />
<input type="hidden" name="need_redirect" value="0" />
<input type="hidden" name="user_language" />
<input type="hidden" name="wait_time" value="0" />
<input type="hidden" name="dhcp_start" value="<% nvram_get("dhcp_start");%>" />
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "<!--"); %>
<input type="hidden" name="dhcp_start_conflict" value="0" />
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "-->"); %>
<input type="hidden" name="lan_ipaddr" value="4" />
<% web_include_file("Top.asp"); %>
<script>draw_table(MAINFUN2,lefemenu.routerip);</script>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(share.ipaddr)</script></td>
<td>
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,1,223,'IP')" style="width:40px" value="<% get_single_ip("lan_ipaddr","0"); %>" name="lan_ipaddr_0" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'IP')" style="width:40px" value="<% get_single_ip("lan_ipaddr","1"); %>" name="lan_ipaddr_1" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'IP')" style="width:40px" value="<% get_single_ip("lan_ipaddr","2"); %>" name="lan_ipaddr_2" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,1,254,'IP')" onchange="Sel_SubMask(this.form.lan_netmask,this.form,1)" style="width:40px" value="<% get_single_ip("lan_ipaddr","3"); %>" name="lan_ipaddr_3" />
</td>
</tr>
<tr>
<td><script>Capture(share.submask)</script></td>
<td>
<script>
(function(){
var str = [
'255.255.255.0',
'255.255.255.128',
'255.255.255.192',
'255.255.255.224',
'255.255.255.240',
'255.255.255.248',
'255.255.255.252'
];
draw_select('lan_netmask', str, str, 'Sel_SubMask(this.form.lan_netmask,this.form,0)', '<% nvram_get("lan_netmask"); %>');
})();
</script>
</td>
</tr>
<tr>
<td><script>Capture(share.routename)</script></td>
<td>
<input type="text" maxLength="15" size="17" name="machine_name" value="<% nvram_get("machine_name"); %>" />
</td>
</tr>
</tbody>
</table>
<script>draw_table(MAINFUN2,lefemenu.dhcpserverset);</script>
<table class="table table-info">
<tbody>
<tr>
<td>
<!--            <script>draw_radio('lan_proto', share.enabled, 'dhcp', "SelDHCP('dhcp',this.form)" <% nvram_match("lan_proto","dhcp",", 0"); %>);</script>
<script>draw_radio('lan_proto', share.disabled, 'static', "SelDHCP('static',this.form)" <% nvram_match("lan_proto","static",", 0"); %>);</script>       -->
<script>draw_checkbox('_lan_proto', share.dhcpsrv, 'dhcp', "SelDHCP('dhcp',this.form)" <% nvram_match("lan_proto","dhcp",", 1"); %>);</script></td>
<td>
<script>draw_button("javascript:DHCP_Res()", adbutton.dhcpres, 'dhcp_res')</script>
</td>
</tr>
<input type="hidden" name="dhcp_check">
<tr>
<td><script>Capture(share.startipaddr)</script></td>
<td>
<% prefix_ip_get("lan_ipaddr",1); %>
<input type="text" maxLength="3" onBlur="Sel_SubMask_onblur(this.form.lan_netmask,this.form,'dhcp_start')" style="width:40px" value="<% nvram_get("dhcp_start");%>" name="dhcp_start_tmp" class="num"/ >
</td>
</tr>
<tr>
<td><script>Capture(setupcontent.maxdhcpusr)</script></td>
<td>
<input type="text" maxLength="3" onBlur="Sel_SubMask_onblur(this.form.lan_netmask,this.form,'dhcp_num')" style="width:40px" value="<% nvram_get("dhcp_num");%>" name="dhcp_num" class="num"/ >
</td>
</tr>
<tr>
<td><script>Capture(setupcontent.dhcprange)</script></td>
<td><span id="DymRange"></span></td>
</tr>
<tr>
<td><script>Capture(share.clileasetime)</script></td>
<td>
<input type="text" maxLength="4" onBlur="valid_range(this,0,9999,'DHCP%20Lease%20Time')" style="width:50px" value="<% nvram_get("dhcp_lease"); %>" name="dhcp_lease" class="num" />
<script>Capture(setupcontent.clileasetimemin)</script>
</td>
</tr>
<tr>
<td><script>Capture(setupcontent.stadns1)</script></td>
<td>
<input type="hidden" name="wan_dns" value="4" />
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,223,'DNS')" style="width:40px" value="<% get_dns_ip("wan_dns","0","0"); %>" name="wan_dns0_0" id="dns00" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'DNS')" style="width:40px" value="<% get_dns_ip("wan_dns","0","1"); %>" name="wan_dns0_1" id="dns01" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'DNS')" style="width:40px" value="<% get_dns_ip("wan_dns","0","2"); %>" name="wan_dns0_2" id="dns02" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,254,'DNS')" style="width:40px" value="<% get_dns_ip("wan_dns","0","3"); %>" name="wan_dns0_3" id="dns03" />
</td>
</tr>
<tr>
<td><script>Capture(setupcontent.stadns2)</script></td>
<td>
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,223,'DNS')" style="width:40px" value="<% get_dns_ip("wan_dns","1","0"); %>" name="wan_dns1_0" id="dns10" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'DNS')" style="width:40px" value="<% get_dns_ip("wan_dns","1","1"); %>" name="wan_dns1_1" id="dns11" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'DNS')" style="width:40px" value="<% get_dns_ip("wan_dns","1","2"); %>" name="wan_dns1_2" id="dns12" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,254,'DNS')" style="width:40px" value="<% get_dns_ip("wan_dns","1","3"); %>" name="wan_dns1_3" id="dns13" />
</td>
</tr>
<tr>
<td><script>Capture(hindex2.dns3)</script></td>
<td>
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,223,'DNS')" style="width:40px" value="<% get_dns_ip("wan_dns","2","0"); %>" name="wan_dns2_0" id="dns20" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'DNS')" style="width:40px" value="<% get_dns_ip("wan_dns","2","1"); %>" name="wan_dns2_1" id="dns21" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'DNS')" style="width:40px" value="<% get_dns_ip("wan_dns","2","2"); %>" name="wan_dns2_2" id="dns22" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,254,'DNS')" style="width:40px" value="<% get_dns_ip("wan_dns","2","3"); %>" name="wan_dns2_3" id="dns23" />
</td>
</tr>
<tr>
<td><script>Capture(share.wins)</script></td>
<td>
<input type="hidden" name="wan_wins" value="4" />
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,223,'WINS')" style="width:40px" value="<% get_single_ip("wan_wins","0"); %>" name="wan_wins_0" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'WINS')" style="width:40px" value="<% get_single_ip("wan_wins","1"); %>" name="wan_wins_1" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'WINS')" style="width:40px" value="<% get_single_ip("wan_wins","2"); %>" name="wan_wins_2" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,254,'WINS')" style="width:40px" value="<% get_single_ip("wan_wins","3"); %>" name="wan_wins_3" />
</td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
