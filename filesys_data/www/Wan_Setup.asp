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
cancel:	 true
});
document.title = topmenu.basicsetup;
var close_session = "<% get_session_status(); %>";
var EN_DIS2 = '<% nvram_get("mtu_enable"); %>';	
var wan_proto = '<% nvram_get("wan_proto"); %>';
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
var min = 576; 
var max;
var temp = document.getElementsByName("wan_proto");
for(var i=0;i<temp.length;i++)
{
if(temp[i].checked)
var wanproto = temp[i].value;
}
if( wanproto == "dhcp" || wanproto == "static")
{
max = "1500";
}
else if(wanproto == "pppoe")
max = "1492";
else if(wanproto == "pptp")
max = "1460";
else if(wanproto == "l2tp")
max = "1460";
if(!valid_range(I,min,max,"MTU"))
return false;
d = parseInt(I.value, 10);
if(d > max) {
I.value = max ;
}
if(d < min) {
I.value = max ;
}
return true;
}
function SelMTU(F)
{	
mtu_enable_disable(F);
}
function mtu_enable_disable(F)
{
if ( F.mtu_enable.value == "0" )
choose_disable(F.wan_mtu);
else
choose_enable(F.wan_mtu);
}
function disable_value(F,wanproto)
{
if(wanproto == "dhcp")
{
F.wan_hostname.disabled = "";
F.wan_domain.disabled = "";
F.mtu_enable.disabled = "";
F.wan_mtu.disabled = "";
F.wan_ipaddr.disabled = "true";
F.wan_ipaddr_0.disabled = "true";
F.wan_ipaddr_1.disabled = "true";
F.wan_ipaddr_2.disabled = "true";
F.wan_ipaddr_3.disabled = "true";
F.wan_netmask.disabled = "true";
F.wan_netmask_0.disabled = "true";
F.wan_netmask_1.disabled = "true";
F.wan_netmask_2.disabled = "true";
F.wan_netmask_3.disabled = "true";
F.wan_gateway.disabled = "true";
F.wan_gateway_0.disabled = "true";
F.wan_gateway_1.disabled = "true";
F.wan_gateway_2.disabled = "true";
F.wan_gateway_3.disabled = "true";
F.wan_dns.disabled = "";
F.wan_dns0_0.disabled = "";
F.wan_dns0_1.disabled = "";
F.wan_dns0_2.disabled = "";
F.wan_dns0_3.disabled = "";
F.wan_dns1_0.disabled = "";
F.wan_dns1_1.disabled = "";
F.wan_dns1_2.disabled = "";
F.wan_dns1_3.disabled = "";
F.wan_dns2_0.disabled = "";
F.wan_dns2_1.disabled = "";
F.wan_dns2_2.disabled = "";
F.wan_dns2_3.disabled = "";
F.ppp_username.disabled = "true";
F.ppp_passwd.disabled = "true";
F.ppp_service.disabled = "true";
F.ppp_demand[0].disabled = "true";
F.ppp_demand[1].disabled = "true";
F.ppp_idletime.disabled = "true";
F.ppp_redialperiod.disabled = "true";
F.sel_pptp_dhcp[0].disabled = "true";
F.sel_pptp_dhcp[1].disabled = "true";
F.wan_pptp_gateway.disabled = "true";
F.wan_pptp_gateway_0.disabled = "true";
F.wan_pptp_gateway_1.disabled = "true";
F.wan_pptp_gateway_2.disabled = "true";
F.wan_pptp_gateway_3.disabled = "true";
F.wan_pptp_dns0_0.disabled = "true";
F.wan_pptp_dns0_1.disabled = "true";
F.wan_pptp_dns0_2.disabled = "true";
F.wan_pptp_dns0_3.disabled = "true";
F.wan_pptp_dns1_0.disabled = "true";
F.wan_pptp_dns1_1.disabled = "true";
F.wan_pptp_dns1_2.disabled = "true";
F.wan_pptp_dns1_3.disabled = "true";
F.wan_pptp_dns2_0.disabled = "true";
F.wan_pptp_dns2_1.disabled = "true";
F.wan_pptp_dns2_2.disabled = "true";
F.wan_pptp_dns2_3.disabled = "true";
F.pptp_server_ip.disabled = "true";
F.pptp_server_ip_0.disabled = "true";
F.pptp_server_ip_1.disabled = "true";
F.pptp_server_ip_2.disabled = "true";
F.pptp_server_ip_3.disabled = "true";
F.l2tp_server_ip.disabled = "true";
F.l2tp_server_ip_0.disabled = "true";
F.l2tp_server_ip_1.disabled = "true";
F.l2tp_server_ip_2.disabled = "true";
F.l2tp_server_ip_3.disabled = "true";
F.bridge_mode_sel.disabled = "true";
F.switch_ipaddr_0.disabled = "true";
F.switch_ipaddr_1.disabled = "true";
F.switch_ipaddr_2.disabled = "true";
F.switch_ipaddr_3.disabled = "true";
F.switch_netmask_0.disabled = "true";
F.switch_netmask_1.disabled = "true";
F.switch_netmask_2.disabled = "true";
F.switch_netmask_3.disabled = "true";
F.switch_gateway_0.disabled = "true";
F.switch_gateway_1.disabled = "true";
F.switch_gateway_2.disabled = "true";
F.switch_gateway_3.disabled = "true";
F.wbridge_ssid.disabled = "true";
F.wbridge_band.disabled = "true";
F.wbridge_security_mode.disabled = "true";
F.wbridge_wpa_psk.disabled = "true";
}
if(wanproto == "static")
{
F.wan_hostname.disabled = "";
F.wan_domain.disabled = "";
F.mtu_enable.disabled = "";
F.wan_mtu.disabled = "";
F.wan_ipaddr.disabled = "";
F.wan_ipaddr_0.disabled = "";
F.wan_ipaddr_1.disabled = "";
F.wan_ipaddr_2.disabled = "";
F.wan_ipaddr_3.disabled = "";
F.wan_netmask.disabled = "";
F.wan_netmask_0.disabled = "";
F.wan_netmask_1.disabled = "";
F.wan_netmask_2.disabled = "";
F.wan_netmask_3.disabled = "";
F.wan_gateway.disabled = "";
F.wan_gateway_0.disabled = "";
F.wan_gateway_1.disabled = "";
F.wan_gateway_2.disabled = "";
F.wan_gateway_3.disabled = "";
F.wan_dns.disabled = "";
F.wan_dns0_0.disabled = "";
F.wan_dns0_1.disabled = "";
F.wan_dns0_2.disabled = "";
F.wan_dns0_3.disabled = "";
F.wan_dns1_0.disabled = "";
F.wan_dns1_1.disabled = "";
F.wan_dns1_2.disabled = "";
F.wan_dns1_3.disabled = "";
F.wan_dns2_0.disabled = "";
F.wan_dns2_1.disabled = "";
F.wan_dns2_2.disabled = "";
F.wan_dns2_3.disabled = "";
F.ppp_username.disabled = "true";
F.ppp_passwd.disabled = "true";
F.ppp_service.disabled = "true";
F.ppp_demand[0].disabled = "true";
F.ppp_demand[1].disabled = "true";
F.ppp_idletime.disabled = "true";
F.ppp_redialperiod.disabled = "true";
F.sel_pptp_dhcp[0].disabled = "true";
F.sel_pptp_dhcp[1].disabled = "true";
F.wan_pptp_gateway.disabled = "true";
F.wan_pptp_gateway_0.disabled = "true";
F.wan_pptp_gateway_1.disabled = "true";
F.wan_pptp_gateway_2.disabled = "true";
F.wan_pptp_gateway_3.disabled = "true";
F.wan_pptp_dns0_0.disabled = "true";
F.wan_pptp_dns0_1.disabled = "true";
F.wan_pptp_dns0_2.disabled = "true";
F.wan_pptp_dns0_3.disabled = "true";
F.wan_pptp_dns1_0.disabled = "true";
F.wan_pptp_dns1_1.disabled = "true";
F.wan_pptp_dns1_2.disabled = "true";
F.wan_pptp_dns1_3.disabled = "true";
F.l2tp_server_ip_2.disabled = "true";
F.l2tp_server_ip_3.disabled = "true";
F.bridge_mode_sel.disabled = "true";
F.switch_ipaddr_0.disabled = "true";
F.switch_ipaddr_1.disabled = "true";
F.switch_ipaddr_2.disabled = "true";
F.switch_ipaddr_3.disabled = "true";
F.switch_netmask_0.disabled = "true";
F.switch_netmask_1.disabled = "true";
F.switch_netmask_2.disabled = "true";
F.switch_netmask_3.disabled = "true";
F.switch_gateway_0.disabled = "true";
F.switch_gateway_1.disabled = "true";
F.switch_gateway_2.disabled = "true";
F.switch_gateway_3.disabled = "true";
F.wbridge_ssid.disabled = "true";
F.wbridge_band.disabled = "true";
F.wbridge_security_mode.disabled = "true";
F.wbridge_wpa_psk.disabled = "true";
}
if(wanproto == "pppoe")
{
F.wan_hostname.disabled = "";
F.wan_domain.disabled = "";
F.mtu_enable.disabled = "";
F.wan_mtu.disabled = "";
F.wan_ipaddr.disabled = "true";
F.wan_ipaddr_0.disabled = "true";
F.wan_ipaddr_1.disabled = "true";
F.wan_ipaddr_2.disabled = "true";
F.wan_ipaddr_3.disabled = "true";
F.wan_netmask.disabled = "true";
F.wan_netmask_0.disabled = "true";
F.wan_netmask_1.disabled = "true";
F.wan_netmask_2.disabled = "true";
F.wan_netmask_3.disabled = "true";
F.wan_gateway.disabled = "true";
F.wan_gateway_0.disabled = "true";
F.wan_gateway_1.disabled = "true";
F.wan_gateway_2.disabled = "true";
F.wan_gateway_3.disabled = "true";
F.wan_dns.disabled = "";
F.wan_dns0_0.disabled = "";
F.wan_dns0_1.disabled = "";
F.wan_dns0_2.disabled = "";
F.wan_dns0_3.disabled = "";
F.wan_dns1_0.disabled = "";
F.wan_dns1_1.disabled = "";
F.wan_dns1_2.disabled = "";
F.wan_dns1_3.disabled = "";
F.wan_dns2_0.disabled = "";
F.wan_dns2_1.disabled = "";
F.wan_dns2_2.disabled = "";
F.wan_dns2_3.disabled = "";
F.ppp_username.disabled = "";
F.ppp_passwd.disabled = "";
F.ppp_service.disabled = "";
F.ppp_demand[0].disabled = "";
F.ppp_demand[1].disabled = "";
F.ppp_idletime.disabled = "";
F.ppp_redialperiod.disabled = "";
F.sel_pptp_dhcp[0].disabled = "true";
F.sel_pptp_dhcp[1].disabled = "true";
F.wan_pptp_gateway.disabled = "true";
F.wan_pptp_gateway_0.disabled = "true";
F.wan_pptp_gateway_1.disabled = "true";
F.wan_pptp_gateway_2.disabled = "true";
F.wan_pptp_gateway_3.disabled = "true";
F.wan_pptp_dns0_0.disabled = "true";
F.wan_pptp_dns0_1.disabled = "true";
F.wan_pptp_dns0_2.disabled = "true";
F.wan_pptp_dns0_3.disabled = "true";
F.wan_pptp_dns1_0.disabled = "true";
F.wan_pptp_dns1_1.disabled = "true";
F.wan_pptp_dns1_2.disabled = "true";
F.wan_pptp_dns1_3.disabled = "true";
F.wan_pptp_dns2_0.disabled = "true";
F.wan_pptp_dns2_1.disabled = "true";
F.wan_pptp_dns2_2.disabled = "true";
F.wan_pptp_dns2_3.disabled = "true";
F.pptp_server_ip.disabled = "true";
F.pptp_server_ip_0.disabled = "true";
F.pptp_server_ip_1.disabled = "true";
F.pptp_server_ip_2.disabled = "true";
F.pptp_server_ip_3.disabled = "true";
F.l2tp_server_ip.disabled = "true";
F.l2tp_server_ip_0.disabled = "true";
F.l2tp_server_ip_1.disabled = "true";
F.l2tp_server_ip_2.disabled = "true";
F.l2tp_server_ip_3.disabled = "true";
F.bridge_mode_sel.disabled = "true";
F.switch_ipaddr_0.disabled = "true";
F.switch_ipaddr_1.disabled = "true";
F.switch_ipaddr_2.disabled = "true";
F.switch_ipaddr_3.disabled = "true";
F.switch_netmask_0.disabled = "true";
F.switch_netmask_1.disabled = "true";
F.switch_netmask_2.disabled = "true";
F.switch_netmask_3.disabled = "true";
F.switch_gateway_0.disabled = "true";
F.switch_gateway_1.disabled = "true";
F.switch_gateway_2.disabled = "true";
F.switch_gateway_3.disabled = "true";
F.wbridge_ssid.disabled = "true";
F.wbridge_band.disabled = "true";
F.wbridge_security_mode.disabled = "true";
F.wbridge_wpa_psk.disabled = "true";
}
if(wanproto == "pptp")
{
F.wan_hostname.disabled = "";
F.wan_domain.disabled = "";
F.mtu_enable.disabled = "";
F.wan_mtu.disabled = "";
F.wan_ipaddr.disabled = "";
F.wan_ipaddr_0.disabled = "";
F.wan_ipaddr_1.disabled = "";
F.wan_ipaddr_2.disabled = "";
F.wan_ipaddr_3.disabled = "";
F.wan_netmask.disabled = "";
F.wan_netmask_0.disabled = "";
F.wan_netmask_1.disabled = "";
F.wan_netmask_2.disabled = "";
F.wan_netmask_3.disabled = "";
F.wan_gateway.disabled = "true";
F.wan_gateway_0.disabled = "true";
F.wan_gateway_1.disabled = "true";
F.wan_gateway_2.disabled = "true";
F.wan_gateway_3.disabled = "true";
F.wan_dns.disabled = "";
F.wan_dns0_0.disabled = "";
F.wan_dns0_1.disabled = "";
F.wan_dns0_2.disabled = "";
F.wan_dns0_3.disabled = "";
F.wan_dns1_0.disabled = "";
F.wan_dns1_1.disabled = "";
F.wan_dns1_2.disabled = "";
F.wan_dns1_3.disabled = "";
F.wan_dns2_0.disabled = "";
F.wan_dns2_1.disabled = "";
F.wan_dns2_2.disabled = "";
F.wan_dns2_3.disabled = "";
F.ppp_username.disabled = "";
F.ppp_passwd.disabled = "";
F.ppp_service.disabled = "true";
F.ppp_demand[0].disabled = "";
F.ppp_demand[1].disabled = "";
F.ppp_idletime.disabled = "true";
F.ppp_redialperiod.disabled = "true";
F.sel_pptp_dhcp[0].disabled = "";
F.sel_pptp_dhcp[1].disabled = "";
F.wan_pptp_gateway.disabled = "";
F.wan_pptp_gateway_0.disabled = "";
F.wan_pptp_gateway_1.disabled = "";
F.wan_pptp_gateway_2.disabled = "";
F.wan_pptp_gateway_3.disabled = "";
F.wan_pptp_dns0_0.disabled = "";
F.wan_pptp_dns0_1.disabled = "";
F.wan_pptp_dns0_2.disabled = "";
F.wan_pptp_dns0_3.disabled = "";
F.wan_pptp_dns1_0.disabled = "";
F.wan_pptp_dns1_1.disabled = "";
F.wan_pptp_dns1_2.disabled = "";
F.wan_pptp_dns1_3.disabled = "";
F.wan_pptp_dns2_0.disabled = "";
F.wan_pptp_dns2_1.disabled = "";
F.wan_pptp_dns2_2.disabled = "";
F.wan_pptp_dns2_3.disabled = "";
F.pptp_server_ip.disabled = "";
F.pptp_server_ip_0.disabled = "";
F.pptp_server_ip_1.disabled = "";
F.pptp_server_ip_2.disabled = "";
F.pptp_server_ip_3.disabled = "";
F.l2tp_server_ip.disabled = "true";
F.l2tp_server_ip_0.disabled = "true";
F.l2tp_server_ip_1.disabled = "true";
F.l2tp_server_ip_2.disabled = "true";
F.l2tp_server_ip_3.disabled = "true";
F.bridge_mode_sel.disabled = "true";
F.switch_ipaddr_0.disabled = "true";
F.switch_ipaddr_1.disabled = "true";
F.switch_ipaddr_2.disabled = "true";
F.switch_ipaddr_3.disabled = "true";
F.switch_netmask_0.disabled = "";
F.switch_netmask_1.disabled = "";
F.switch_netmask_2.disabled = "";
F.switch_netmask_3.disabled = "";
F.switch_gateway_0.disabled = "true";
F.switch_gateway_1.disabled = "true";
F.switch_gateway_2.disabled = "true";
F.switch_gateway_3.disabled = "true";
F.wbridge_ssid.disabled = "true";
F.wbridge_band.disabled = "true";
F.wbridge_security_mode.disabled = "true";
F.wbridge_wpa_psk.disabled = "true";
}
if(wanproto == "l2tp")
{
F.wan_hostname.disabled = "";
F.wan_domain.disabled = "";
F.mtu_enable.disabled = "";
F.wan_mtu.disabled = "";
F.wan_ipaddr.disabled = "true";
F.wan_ipaddr_0.disabled = "true";
F.wan_ipaddr_1.disabled = "true";
F.wan_ipaddr_2.disabled = "true";
F.wan_ipaddr_3.disabled = "true";
F.wan_netmask.disabled = "true";
F.wan_netmask_0.disabled = "true";
F.wan_netmask_1.disabled = "true";
F.wan_netmask_2.disabled = "true";
F.wan_netmask_3.disabled = "true";
F.wan_gateway.disabled = "true";
F.wan_gateway_0.disabled = "true";
F.wan_gateway_1.disabled = "true";
F.wan_gateway_2.disabled = "true";
F.wan_gateway_3.disabled = "true";
F.wan_dns.disabled = "";
F.wan_dns0_0.disabled = "";
F.wan_dns0_1.disabled = "";
F.wan_dns0_2.disabled = "";
F.wan_dns0_3.disabled = "";
F.wan_dns1_0.disabled = "";
F.wan_dns1_1.disabled = "";
F.wan_dns1_2.disabled = "";
F.wan_dns1_3.disabled = "";
F.wan_dns2_0.disabled = "";
F.wan_dns2_1.disabled = "";
F.wan_dns2_2.disabled = "";
F.wan_dns2_3.disabled = "";
F.ppp_username.disabled = "";
F.ppp_passwd.disabled = "";
F.ppp_service.disabled = "true";
F.ppp_demand[0].disabled = "";
F.ppp_demand[1].disabled = "";
F.ppp_idletime.disabled = "";
F.ppp_redialperiod.disabled = "";
F.sel_pptp_dhcp[0].disabled = "true";
F.sel_pptp_dhcp[1].disabled = "true";
F.wan_pptp_gateway.disabled = "true";
F.wan_pptp_gateway_0.disabled = "true";
F.wan_pptp_gateway_1.disabled = "true";
F.wan_pptp_gateway_2.disabled = "true";
F.wan_pptp_gateway_3.disabled = "true";
F.wan_pptp_dns0_0.disabled = "true";
F.wan_pptp_dns0_1.disabled = "true";
F.wan_pptp_dns0_2.disabled = "true";
F.wan_pptp_dns0_3.disabled = "true";
F.wan_pptp_dns1_0.disabled = "true";
F.wan_pptp_dns1_1.disabled = "true";
F.wan_pptp_dns1_2.disabled = "true";
F.wan_pptp_dns1_3.disabled = "true";
F.wan_pptp_dns2_0.disabled = "true";
F.wan_pptp_dns2_1.disabled = "true";
F.wan_pptp_dns2_2.disabled = "true";
F.wan_pptp_dns2_3.disabled = "true";
F.pptp_server_ip.disabled = "true";
F.pptp_server_ip_0.disabled = "true";
F.pptp_server_ip_1.disabled = "true";
F.pptp_server_ip_2.disabled = "true";
F.pptp_server_ip_3.disabled = "true";
F.l2tp_server_ip.disabled = "";
F.l2tp_server_ip_0.disabled = "";
F.l2tp_server_ip_1.disabled = "";
F.l2tp_server_ip_2.disabled = "";
F.l2tp_server_ip_3.disabled = "";
F.bridge_mode_sel.disabled = "true";
F.switch_ipaddr_0.disabled = "true";
F.switch_ipaddr_1.disabled = "true";
F.switch_ipaddr_2.disabled = "true";
F.switch_ipaddr_3.disabled = "true";
F.switch_netmask_0.disabled = "true";
F.switch_netmask_1.disabled = "true";
F.switch_netmask_2.disabled = "true";
F.switch_netmask_3.disabled = "true";
F.switch_gateway_0.disabled = "true";
F.switch_gateway_1.disabled = "true";
F.switch_gateway_2.disabled = "true";
F.switch_gateway_3.disabled = "true";
F.wbridge_ssid.disabled = "true";
F.wbridge_band.disabled = "true";
F.wbridge_security_mode.disabled = "true";
F.wbridge_wpa_psk.disabled = "true";
}
if(wanproto == "auto")
{
F.wan_hostname.disabled = "true";
F.wan_domain.disabled = "true";
F.mtu_enable.disabled = "true";
F.wan_mtu.disabled = "true";
F.wan_ipaddr.disabled = "true";
F.wan_ipaddr_0.disabled = "true";
F.wan_ipaddr_1.disabled = "true";
F.wan_ipaddr_2.disabled = "true";
F.wan_ipaddr_3.disabled = "true";
F.wan_netmask.disabled = "true";
F.wan_netmask_0.disabled = "true";
F.wan_netmask_1.disabled = "true";
F.wan_netmask_2.disabled = "true";
F.wan_netmask_3.disabled = "true";
F.wan_gateway.disabled = "true";
F.wan_gateway_0.disabled = "true";
F.wan_gateway_1.disabled = "true";
F.wan_gateway_2.disabled = "true";
F.wan_gateway_3.disabled = "true";
F.wan_dns.disabled = "";
F.wan_dns0_0.disabled = "";
F.wan_dns0_1.disabled = "";
F.wan_dns0_2.disabled = "";
F.wan_dns0_3.disabled = "";
F.wan_dns1_0.disabled = "";
F.wan_dns1_1.disabled = "";
F.wan_dns1_2.disabled = "";
F.wan_dns1_3.disabled = "";
F.wan_dns2_0.disabled = "";
F.wan_dns2_1.disabled = "";
F.wan_dns2_2.disabled = "";
F.wan_dns2_3.disabled = "";
F.ppp_username.disabled = "true";
F.ppp_passwd.disabled = "true";
F.ppp_service.disabled = "true";
F.ppp_demand[0].disabled = "true";
F.ppp_demand[1].disabled = "true";
F.ppp_idletime.disabled = "true";
F.ppp_redialperiod.disabled = "true";
F.sel_pptp_dhcp[0].disabled = "true";
F.sel_pptp_dhcp[1].disabled = "true";
F.wan_pptp_gateway.disabled = "true";
F.wan_pptp_gateway_0.disabled = "true";
F.wan_pptp_gateway_1.disabled = "true";
F.wan_pptp_gateway_2.disabled = "true";
F.wan_pptp_gateway_3.disabled = "true";
F.wan_pptp_dns0_0.disabled = "true";
F.wan_pptp_dns0_1.disabled = "true";
F.wan_pptp_dns0_2.disabled = "true";
F.wan_pptp_dns0_3.disabled = "true";
F.wan_pptp_dns1_0.disabled = "true";
F.wan_pptp_dns1_1.disabled = "true";
F.wan_pptp_dns1_2.disabled = "true";
F.wan_pptp_dns1_3.disabled = "true";
F.wan_pptp_dns2_0.disabled = "true";
F.wan_pptp_dns2_1.disabled = "true";
F.wan_pptp_dns2_2.disabled = "true";
F.wan_pptp_dns2_3.disabled = "true";
F.pptp_server_ip.disabled = "true";
F.pptp_server_ip_0.disabled = "true";
F.pptp_server_ip_1.disabled = "true";
F.pptp_server_ip_2.disabled = "true";
F.pptp_server_ip_3.disabled = "true";
F.l2tp_server_ip.disabled = "true";
F.l2tp_server_ip_0.disabled = "true";
F.l2tp_server_ip_1.disabled = "true";
F.l2tp_server_ip_2.disabled = "true";
F.l2tp_server_ip_3.disabled = "true";
F.bridge_mode_sel.disabled = "";
F.switch_ipaddr_0.disabled = "";
F.switch_ipaddr_1.disabled = "";
F.switch_ipaddr_2.disabled = "";
F.switch_ipaddr_3.disabled = "";
F.switch_netmask_0.disabled = "";
F.switch_netmask_1.disabled = "";
F.switch_netmask_2.disabled = "";
F.switch_netmask_3.disabled = "";
F.switch_gateway_0.disabled = "";
F.switch_gateway_1.disabled = "";
F.switch_gateway_2.disabled = "";
F.switch_gateway_3.disabled = "";
F.wbridge_ssid.disabled = "true";
F.wbridge_band.disabled = "true";
F.wbridge_security_mode.disabled = "true";
F.wbridge_wpa_psk.disabled = "true";
}
if(wanproto == "wbridge")
{
F.wan_hostname.disabled = "true";
F.wan_domain.disabled = "true";
F.mtu_enable.disabled = "true";
F.wan_mtu.disabled = "true";
F.wan_ipaddr.disabled = "true";
F.wan_ipaddr_0.disabled = "true";
F.wan_ipaddr_1.disabled = "true";
F.wan_ipaddr_2.disabled = "true";
F.wan_ipaddr_3.disabled = "true";
F.wan_netmask.disabled = "true";
F.wan_netmask_0.disabled = "true";
F.wan_netmask_1.disabled = "true";
F.wan_netmask_2.disabled = "true";
F.wan_netmask_3.disabled = "true";
F.wan_gateway.disabled = "true";
F.wan_gateway_0.disabled = "true";
F.wan_gateway_1.disabled = "true";
F.wan_gateway_2.disabled = "true";
F.wan_gateway_3.disabled = "true";
F.wan_dns.disabled = "";
F.wan_dns0_0.disabled = "";
F.wan_dns0_1.disabled = "";
F.wan_dns0_2.disabled = "";
F.wan_dns0_3.disabled = "";
F.wan_dns1_0.disabled = "";
F.wan_dns1_1.disabled = "";
F.wan_dns1_2.disabled = "";
F.wan_dns1_3.disabled = "";
F.wan_dns2_0.disabled = "";
F.wan_dns2_1.disabled = "";
F.wan_dns2_2.disabled = "";
F.wan_dns2_3.disabled = "";
F.ppp_username.disabled = "true";
F.ppp_passwd.disabled = "true";
F.ppp_service.disabled = "true";
F.ppp_demand[0].disabled = "true";
F.ppp_demand[1].disabled = "true";
F.ppp_idletime.disabled = "true";
F.ppp_redialperiod.disabled = "true";
F.sel_pptp_dhcp[0].disabled = "true";
F.sel_pptp_dhcp[1].disabled = "true";
F.wan_pptp_gateway.disabled = "true";
F.wan_pptp_gateway_0.disabled = "true";
F.wan_pptp_gateway_1.disabled = "true";
F.wan_pptp_gateway_2.disabled = "true";
F.wan_pptp_gateway_3.disabled = "true";
F.wan_pptp_dns0_0.disabled = "true";
F.wan_pptp_dns0_1.disabled = "true";
F.wan_pptp_dns0_2.disabled = "true";
F.wan_pptp_dns0_3.disabled = "true";
F.wan_pptp_dns1_0.disabled = "true";
F.wan_pptp_dns1_1.disabled = "true";
F.wan_pptp_dns1_2.disabled = "true";
F.wan_pptp_dns1_3.disabled = "true";
F.wan_pptp_dns2_0.disabled = "true";
F.wan_pptp_dns2_1.disabled = "true";
F.wan_pptp_dns2_2.disabled = "true";
F.wan_pptp_dns2_3.disabled = "true";
F.pptp_server_ip.disabled = "true";
F.pptp_server_ip_0.disabled = "true";
F.pptp_server_ip_1.disabled = "true";
F.pptp_server_ip_2.disabled = "true";
F.pptp_server_ip_3.disabled = "true";
F.l2tp_server_ip.disabled = "true";
F.l2tp_server_ip_0.disabled = "true";
F.l2tp_server_ip_1.disabled = "true";
F.l2tp_server_ip_2.disabled = "true";
F.l2tp_server_ip_3.disabled = "true";
F.bridge_mode_sel.disabled = "";
F.switch_ipaddr_0.disabled = "";
F.switch_ipaddr_1.disabled = "";
F.switch_ipaddr_2.disabled = "";
F.switch_ipaddr_3.disabled = "";
F.switch_netmask_0.disabled = "";
F.switch_netmask_1.disabled = "";
F.switch_netmask_2.disabled = "";
F.switch_netmask_3.disabled = "";
F.switch_gateway_0.disabled = "true";
F.switch_gateway_1.disabled = "true";
F.switch_gateway_2.disabled = "true";
F.switch_gateway_3.disabled = "true";	
F.wbridge_ssid.disabled = "";
F.wbridge_band.disabled = "";
F.wbridge_security_mode.disabled = "";
F.wbridge_wpa_psk.disabled = "";
}
}
function SelWAN(F,flag)
{
var temp = document.getElementsByName("wan_proto");
for(var i=0;i<temp.length;i++)
{
if(temp[i].checked)
var wanproto = temp[i].value;
}
disable_value(F,wanproto);
if(flag == 0){
document.getElementById('trhostname').style.display = "none";
document.getElementById('trdomainname').style.display = "none";
document.getElementById('trmtu').style.display = "none";
document.getElementById('trmtusize').style.display = "none";
document.getElementById('trinderipaddr').style.display = "none";
document.getElementById('trsubmask').style.display = "none";
document.getElementById('trgateway').style.display = "none";
document.getElementById('trdns').style.display = "none";
document.getElementById('trdns1').style.display = "none";
document.getElementById('trdns2').style.display = "none";
document.getElementById('trusrname1').style.display = "none";
document.getElementById('trpasswd').style.display = "none";
document.getElementById('trsrvname').style.display = "none";
document.getElementById('trconndemand').style.display = "none";
document.getElementById('trkeepalive').style.display = "none";
document.getElementById('trpptpdhcp').style.display = "none";
document.getElementById('trpptpstaticip').style.display = "none";
document.getElementById('trdefgateway').style.display = "none";
document.getElementById('trpptpdns1').style.display = "none";
document.getElementById('pptpdns2').style.display = "none";
document.getElementById('pptpdns3').style.display = "none";
document.getElementById('trgateway1').style.display = "none";
document.getElementById('class').style.display = "none";
document.getElementById('trsrvipaddr').style.display = "none";
document.getElementById('trbridge').style.display = "none";
document.getElementById('tripaddr').style.display = "none";
document.getElementById('submask1').style.display = "none";
document.getElementById('trdefgateway1').style.display = "none";
document.getElementById('trroutename').style.display = "none";
document.getElementById('ssid').style.display = "none";
document.getElementById('networkband').style.display = "none";
document.getElementById('secmode').style.display = "none";
document.getElementById('passphrase').style.display = "none";
document.getElementById('class1').style.display = "none";
document.getElementById('lefe').style.display = "none";
}
if(wanproto == "dhcp")
{
document.getElementById('trhostname').style.display = "";
document.getElementById('trdomainname').style.display = "";
document.getElementById('trmtu').style.display = "";
document.getElementById('trmtusize').style.display = "";
document.getElementById('lefe').style.display = "";
SelMTU(F);
F.wbridge_mode.value = "0";
}
if(wanproto == "static")
{
document.getElementById('trhostname').style.display = "";
document.getElementById('trdomainname').style.display = "";
document.getElementById('trmtu').style.display = "";
document.getElementById('trmtusize').style.display = "";
document.getElementById('trinderipaddr').style.display = "";
document.getElementById('trsubmask').style.display = "";
document.getElementById('trdns').style.display = "";
document.getElementById('trdns1').style.display = "";
document.getElementById('trdns2').style.display = "";
document.getElementById('trgateway').style.display = "";
document.getElementById('lefe').style.display = "";
SelMTU(F);
F.wbridge_mode.value = "0";
if('<% nvram_get("wan_proto"); %>' != 'static')
{
for (var i = 0 ; i < 4 ; i++)
for (var j = 0 ; j < 3 ; j++)
{
eval("F.wan_dns"+j+"_"+i+".value = 0;");
eval("F.wan_dns"+j+"_"+i+".defaultValue = 0;");
}
}
}
if(wanproto == "pppoe")
{
document.getElementById('trhostname').style.display = "";
document.getElementById('trdomainname').style.display = "";
document.getElementById('trmtu').style.display = "";
document.getElementById('trmtusize').style.display = "";
document.getElementById('trusrname1').style.display = "";
document.getElementById('trpasswd').style.display = "";
document.getElementById('trsrvname').style.display = "";
document.getElementById('trconndemand').style.display = "";
document.getElementById('trkeepalive').style.display = "";
document.getElementById('lefe').style.display = "";
ppp_enable_disable(F,'<% nvram_get("ppp_demand_pppoe"); %>');
SelMTU(F);
F.wbridge_mode.value = "0";
}
if(wanproto == "pptp")
{
document.getElementById('trhostname').style.display = "";
document.getElementById('trdomainname').style.display = "";
document.getElementById('trmtu').style.display = "";
document.getElementById('trmtusize').style.display = "";
document.getElementById('trpptpdhcp').style.display = "";
document.getElementById('trpptpstaticip').style.display = "";
document.getElementById('trconndemand').style.display = "";
document.getElementById('trkeepalive').style.display = "";
document.getElementById('trdefgateway').style.display = "";
document.getElementById('trpptpdns1').style.display = "";
document.getElementById('pptpdns2').style.display = "";
document.getElementById('pptpdns3').style.display = "";
document.getElementById('class').style.display = "";
document.getElementById('trgateway1').style.display = "";
document.getElementById('trusrname1').style.display = "";
document.getElementById('trpasswd').style.display = "";
document.getElementById('trinderipaddr').style.display = "";
document.getElementById('trsubmask').style.display = "";
document.getElementById('lefe').style.display = "";
var pptp_able;
if(F.sel_pptp_dhcp[0].checked == true)
pptp_able = 1;	
else
pptp_able = 0;
selpptpmode(pptp_able);
ppp_enable_disable(F,'<% nvram_get("ppp_demand_pptp"); %>');
SelMTU(F);
F.wbridge_mode.value = "0";
}
if(wanproto == "l2tp")
{
document.getElementById('trhostname').style.display = "";
document.getElementById('trdomainname').style.display = "";
document.getElementById('trmtu').style.display = "";
document.getElementById('trmtusize').style.display = "";
document.getElementById('trsrvipaddr').style.display = "";
document.getElementById('trusrname1').style.display = "";
document.getElementById('trpasswd').style.display = "";
document.getElementById('trconndemand').style.display = "";
document.getElementById('trkeepalive').style.display = "";
document.getElementById('lefe').style.display = "";
ppp_enable_disable(F,'<% nvram_get("ppp_demand_l2tp"); %>');
SelMTU(F);
F.wbridge_mode.value = "0";
}
if(wanproto == "auto")
{
document.getElementById('trbridge').style.display = "";
document.getElementById('tripaddr').style.display = "";
document.getElementById('submask1').style.display = "";
document.getElementById('trdefgateway1').style.display = "";
document.getElementById('trroutename').style.display = "";
F.switch_mode.value = "1";
F.bridge_mode_sel.disabled = "";
if('<% nvram_get("switch_mode_dhcp"); %>' == 1)
F.bridge_mode_sel.value = 0;
else
F.bridge_mode_sel.value = 1;
update_selected(F.bridge_mode_sel);
SelBridgeDhcp(F.bridge_mode_sel.selectedIndex,F);
F.wbridge_mode.value = "0";
}
else
{
F.switch_mode.value = "0";
}
if(wanproto == "wbridge")
{
document.getElementById('ssid').style.display = "";
document.getElementById('networkband').style.display = "";
document.getElementById('secmode').style.display = "";
document.getElementById('passphrase').style.display = ""; 	       
document.getElementById('class1').style.display = "";
SelWLSecMode(F.wbridge_security_mode.selectedIndex,F);
document.getElementById('trbridge').style.display = "";
document.getElementById('tripaddr').style.display = "";
document.getElementById('submask1').style.display = "";
document.getElementById('trroutename').style.display = "";
F.bridge_mode_sel.value = 0;
update_selected(F.bridge_mode_sel);
SelBridgeDhcp(F.bridge_mode_sel.selectedIndex,F);
F.bridge_mode_sel.disabled = "true";
F.wbridge_mode.value = "1";
}
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
function SelBridgeDhcp(num,F)
{
if(num==0)
{
F.switch_mode_dhcp.value = 1;
SetControlStatus(F,0,"switch_ipaddr_0","switch_gateway_3");
}
else
{
F.switch_mode_dhcp.value = 0;
SetControlStatus(F,1,"switch_ipaddr_0","switch_gateway_3");
}
}
function SelWLSecMode(num, F)
{
if (num == 0)
{
F.wbridge_wpa_psk.disabled= true;
}else{
F.wbridge_wpa_psk.disabled = false;
}               
}
function isxdigit1(I,M)
{
for(i=0 ; i<I.value.length; i++){
ch = I.value.charAt(i).toLowerCase();
if(ch >= '0' && ch <= '9' || ch >= 'a' && ch <= 'f'){}
else{
alert(M + errmsg2.err4);
I.value = I.defaultValue;	
return false;
}
}
return true;
}
function SelPPP(num,F)
{
F.submit_button.value = "index";
F.change_action.value = "gozila_cgi";
F.mpppoe_enable.value = F.mpppoe_enable.options[num].value;
F.submit();
}
function reboot(F)
{
if(!confirm(other.warning))
return;
F.wait_time.value="40";
F.submit_button.value = "index";
F.change_action.value = "gozila_cgi";
F.submit_type.value="reboot";
F.submit();
}
function valid_wpa_psk(F)
{
if(F.wbridge_security_mode.value == "wpa2_personal" || F.wbridge_security_mode.value == "wpa_personal"){
if(F.wbridge_wpa_psk.value.length == 64){
if(!isxdigit1(F.wbridge_wpa_psk, wlansec.passphrase)) return false;
}       
else if(F.wbridge_wpa_psk.value.length >=8 && F.wbridge_wpa_psk.value.length <= 63 ){
if(!isascii(F.wbridge_wpa_psk,wlansec.passphrase)) return false;
}
else{
alert(errmsg2.err5);
return false;
}
}
return true;    
}
function to_submit(F)
{
var temp = document.getElementsByName("wan_proto");
for(var i=0;i<temp.length;i++)
{
if(temp[i].checked)
var wanproto = temp[i].value;
}
if(wanproto != "static" && '<% nvram_get("wan_proto"); %>' == "static")
{
for (var i = 0 ; i < 4 ; i++)
for (var j = 0 ; j < 3 ; j++)
{
eval("document.setup.wan_dns"+j+"_"+i+".value = 0;");
}
}
if(wanproto == "wbridge" && F.wbridge_ssid.value == ""){
alert(errmsg2.err2);
F.wbridge_ssid.focus();
return;
}
var wan_ipv6_dhcp = "<% nvram_get("wan_ipv6_dhcp"); %>";
if(wanproto =="auto")
F.switch_mode.value = 1;
else
F.switch_mode.value = 0;
if(F.switch_mode.value==0 && F.wbridge_mode.value == 0)
{	
choose_disable(F.switch_ipaddr);
choose_disable(F.switch_mode_dhcp);
}
else
{
choose_enable(F.switch_mode_dhcp);
if(F.switch_mode_dhcp.value == 1)
choose_disable(F.switch_ipaddr);
else
{
choose_enable(F.switch_ipaddr);
if(!valid_ip(F,"F.switch_ipaddr","IP",ZERO_NO|MASK_NO))
return;
if(!valid_mask(F,"F.switch_netmask",ZERO_NO|BCST_NO))
return;
if(!valid_ip(F,"F.switch_gateway","Gateway",ZERO_NO|MASK_NO))
return;
if(!valid_ip_gw(F,"F.switch_ipaddr","F.switch_netmask","F.switch_gateway"))
return;
if (valid_gn_ip(F, "F.switch_ipaddr_", "F.switch_netmask_", "1") == false)
{
alert(gn.err6);
return;
}
}
}
/*Wenxuan add edge need*/
var userAgent = navigator.userAgent;
var isEdge = userAgent.indexOf("Edge") > -1;
if(isEdge)
{
if(wanproto == "dhcp")
{
if(F.mtu_enable.value == 1)
{
if(!valid_mtu(F.wan_mtu))
return;
}
}
if(wanproto == "static")
{
if(!valid_range(F.wan_ipaddr_0,1,223,'IP') || !valid_range(F.wan_ipaddr_1,0,255,'IP') || !valid_range(F.wan_ipaddr_2,0,255,'IP') || !valid_range(F.wan_ipaddr_3,1,254,'IP') || !valid_range(F.wan_dns0_0,0,223,'DNS') || !valid_range(F.wan_dns0_1,0,255,'DNS') || !valid_range(F.wan_dns0_2,0,255,'DNS') || !valid_range(F.wan_dns0_3,0,254,'DNS') || !valid_range(F.wan_dns1_0,0,223,'DNS') || !valid_range(F.wan_dns1_1,0,255,'DNS') || !valid_range(F.wan_dns1_2,0,255,'DNS') || !valid_range(F.wan_dns1_3,0,254,'DNS') || !valid_range(F.wan_dns2_0,0,223,'DNS') || !valid_range(F.wan_dns2_1,0,255,'DNS') || !valid_range(F.wan_dns2_2,0,255,'DNS') || !valid_range(F.wan_dns2_3,0,254,'DNS' )|| !valid_range(F.wan_netmask_0,0,255,'netmask') || !valid_range(F.wan_netmask_1,0,255,'netmask') || !valid_range(F.wan_netmask_2,0,255,'netmask') || !valid_range(F.wan_netmask_3,0,255,'netmask') || !valid_range(F.wan_gateway_0,1,223,'IP') || !valid_range(F.wan_gateway_1,0,255,'IP') || !valid_range(F.wan_gateway_2,0,255,'IP') || !valid_range(F.wan_gateway_3,1,254,'IP'))
return; 
if(F.mtu_enable.value == 1)
{
if(!valid_mtu(F.wan_mtu))
return;
}
}
if(wanproto == "pptp")
{
if(F.sel_pptp_dhcp[1].checked == true)
{
if(!valid_range(F.wan_pptp_gateway_0,0,223,'IP') || !valid_range(F.wan_pptp_gateway_1,0,255,'IP') || !valid_range(F.wan_pptp_gateway_2,0,255,'IP') || !valid_range(F.wan_pptp_gateway_3,1,254,'IP') || !valid_range(F.wan_pptp_dns0_0,0,223,'DNS') || !valid_range(F.wan_pptp_dns0_1,0,255,'DNS') || !valid_range(F.wan_pptp_dns0_2,0,255,'DNS') || !valid_range(F.wan_pptp_dns0_3,0,254,'DNS') || !valid_range(F.wan_pptp_dns1_0,0,223,'DNS') || !valid_range(F.wan_pptp_dns1_1,0,255,'DNS') || !valid_range(F.wan_pptp_dns1_2,0,255,'DNS') || !valid_range(F.wan_pptp_dns1_3,0,254,'DNS') || !valid_range(F.wan_pptp_dns2_0,0,223,'DNS') || !valid_range(F.wan_pptp_dns2_1,0,255,'DNS') || !valid_range(F.wan_pptp_dns2_2,0,255,'DNS') || !valid_range(F.wan_pptp_dns2_3,0,254,'DNS'))
return;
}
if(F.mtu_enable.value == 1)
{
if(!valid_mtu(F.wan_mtu))
return;
}
if(!valid_range(F.pptp_server_ip_0,0,223,'IP') || !valid_range(F.pptp_server_ip_1,0,255,'IP') || !valid_range(F.pptp_server_ip_2,0,255,'IP') || !valid_range(F.pptp_server_ip_3,1,254,'IP')) 
return;
if(!valid_range(F.ppp_idletime,1,9999,'Idle%20time') || !valid_range(F.ppp_redialperiod,20,180,'Redial%20period'))
return;
}
if(wanproto == "l2tp")
{
if(!valid_range(F.l2tp_server_ip_0,0,223,'IP') || !valid_range(F.l2tp_server_ip_1,0,255,'IP') || !valid_range(F.l2tp_server_ip_2,0,255,'IP') || !valid_range(F.l2tp_server_ip_3,0,254,'IP')) 
return;
if(F.mtu_enable.value == 1)
{
if(!valid_mtu(F.wan_mtu))
return;
}
if(!valid_range(F.ppp_idletime,1,9999,'Idle%20time') || !valid_range(F.ppp_redialperiod,20,180,'Redial%20period'))
return;
}
if(wanproto == "pppoe")
{
if(!valid_range(F.ppp_idletime,1,9999,'Idle%20time') || !valid_range(F.ppp_redialperiod,20,180,'Redial%20period'))
return;
if(F.mtu_enable.value == 1)
{
if(!valid_mtu(F.wan_mtu))
return;
}
}
if(wanproto == "auto")
{
if(F.bridge_mode_sel.value == 1)
{
if(!valid_range(F.switch_ipaddr_0,1,223,'IP') || !valid_range(F.switch_ipaddr_1,0,255,'IP') || !valid_range(F.switch_ipaddr_2,0,255,'IP') || !valid_range(F.switch_ipaddr_3,1,254,'IP') || !valid_range(F.switch_netmask_0,0,255,'netmask') || !valid_range(F.switch_netmask_1,0,255,'netmask') || !valid_range(F.switch_netmask_2,0,255,'netmask') || !valid_range(F.switch_netmask_3,0,255,'netmask') || !valid_range(F.switch_gateway_0,1,223,'IP') || !valid_range(F.switch_gateway_1,0,255,'IP') || !valid_range(F.switch_gateway_2,0,255,'IP') || !valid_range(F.switch_gateway_3,1,254,'IP') )
return;
}
}
}
/*Wenxuan add edge need*/
if(F.switch_mode.value==1 ||
F.switch_mode.value != '<% nvram_get("switch_mode"); %>')
{
F.wait_time.value="40";
F.need_reboot.value="1";
}
if(F.wbridge_mode.value == 1)
F.need_reboot.value="1";
if (valid_value(F)){
if (wan_ipv6_dhcp=="on"){
if(wanproto=="pppoe")
F.wan_ipv6_proto.value="pppoe";
else
if (wanproto=="pptp" || wanproto=="l2tp")
F.wan_ipv6_proto.value="disabled";
else
F.wan_ipv6_proto.value="dhcp";
}
else
F.wan_ipv6_proto.value='<% nvram_get("wan_ipv6_proto"); %>';
if (wanproto == "dslite"){
F.wan_ipv6_proto.value = "dhcp";
}
if(F.wbridge_mode.value == 1 && !valid_wpa_psk(F))
return;
F.submit_button.value = "Wan_Setup";
F.gui_action.value = "Apply";
F.wan_mtu.defaultValue = F.wan_mtu.value;
if(F.wbridge_mode.value == 1 || F.switch_mode.value == 1)
{
var url;
var https_enable = '<% nvram_get("https_enable"); %>';
var http_enable = '<% nvram_get("http_enable"); %>';
var userAgent = navigator.userAgent;                       
var isMacOS = userAgent.indexOf("Mac OS X") > -1;
if(https_enable == "1" && http_enable == "0")
{
if(isMacOS)
url = "https://"+F.machine_name.value+".local";
else
url = "https://"+F.machine_name.value;
}
else
{
if(isMacOS)
url = "http://"+F.machine_name.value+".local";
else
url = "http://"+F.machine_name.value;
}
ajaxSubmit("90","true",url);
}
else if(wan_proto == "auto" || wan_proto == "wbridge")
{
var url;
var lanip = '<% nvram_get("lan_ipaddr"); %>';
var https_enable = '<% nvram_get("https_enable"); %>';
var http_enable = '<% nvram_get("http_enable"); %>';
if(https_enable == "1" && http_enable == "0")
url = "https://"+lanip;
else
url = "http://"+lanip;
ajaxSubmit("80","true",url);
}
else
ajaxSubmit(35,"false");
}
}
function valid_value(F)
{
var temp = document.getElementsByName("wan_proto");
for(var i=0;i<temp.length;i++)
{
if(temp[i].checked)
var wanproto = temp[i].value;
}
var ipaddr,lanip,wanip;
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "/*"); %>
if(wanproto == "pptp" || wanproto == "static"){
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "*/"); %>
if(wanproto == "static" || (wanproto=="pptp" 
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "/*"); %>
&& F.sel_pptp_dhcp[1].checked == true
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "*/"); %>
))
{
if(!valid_ip(F,"F.wan_ipaddr","IP",ZERO_NO|MASK_NO))
return false;
lanip='<% nvram_get("lan_ipaddr"); %>';
wanip = F.wan_ipaddr_0.value +"."+F.wan_ipaddr_1.value+"."+F.wan_ipaddr_2.value +"."+F.wan_ipaddr_3.value;
if(lanip == wanip)
{
alert(errmsg.err79);
return false; 
}
if(!valid_mask(F,"F.wan_netmask",ZERO_NO|BCST_NO))
return false;	
if (valid_gn_ip(F, "F.wan_ipaddr_", "F.wan_netmask_", "1") == false)
{
alert(gn.err6);
return false;
}
}
if(wanproto == "static"){
if(!valid_ip(F,"F.wan_gateway","Gateway",ZERO_NO|MASK_NO))
return false;
if(!valid_ip_for_dns_ex(F,"static_dns0","DNS1",ZERO_NO|MASK_NO) || 
!valid_ip_for_dns_ex(F,"static_dns1","DNS2",MASK_NO) ||
!valid_ip_for_dns_ex(F,"static_dns2","DNS3",MASK_NO))
{ 
return false;
}
valid_same_dns(F,"F.wan_dns0","F.wan_dns1","F.wan_dns2");
if(!valid_ip_gw(F,"F.wan_ipaddr","F.wan_netmask","F.wan_gateway"))
return false;
if(valid_subnet(F,"F.wan_ipaddr","F.wan_netmask","F.lan_ipaddr")) {
alert(errmsg.err81);
return false;
}
}
if(wanproto == "pptp"){
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "/*"); %>
if(F.sel_pptp_dhcp[1].checked == true)
{
if(!valid_ip(F,"F.wan_pptp_gateway","Gateway",ZERO_NO|MASK_NO))
return false;
if(!valid_ip_gw(F,"F.wan_ipaddr","F.wan_netmask","F.wan_pptp_gateway"))
return false;
}
if(!valid_ip(F,"F.pptp_server_ip","PPTP Server IP",ZERO_NO|MASK_NO))
return false;
if(F.sel_pptp_dhcp[1].checked == true)
{
if(!valid_ip_for_dns(F,"F.wan_pptp_dns0","DNS1",MASK_NO) 
|| !valid_ip_for_dns(F,"F.wan_pptp_dns1","DNS2",MASK_NO) 
|| !valid_ip_for_dns(F,"F.wan_pptp_dns2","DNS3",MASK_NO) )
{
return false;
}
valid_same_dns_ex(F,"F.wan_pptp_dns0","F.wan_pptp_dns1","F.wan_pptp_dns2"); 
if(F.pptp_server_ip_0.value == F.wan_ipaddr_0.value 
&& F.pptp_server_ip_1.value == F.wan_ipaddr_1.value 
&& F.pptp_server_ip_2.value == F.wan_ipaddr_2.value 
&& F.pptp_server_ip_3.value == F.wan_ipaddr_3.value)
{
alert(errmsg.pptpsameserver);
return false;
}
}
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "*/"); %>
<% support_match("PPTP_DHCPC_SUPPORT", "1", "/*"); %>
if(!valid_ip(F,"F.pptp_server_ip","Gateway",ZERO_NO|MASK_NO))
return false;
if(!valid_ip_gw(F,"F.wan_ipaddr","F.wan_netmask","F.pptp_server_ip"))
return false;
<% support_match("PPTP_DHCPC_SUPPORT", "1", "*/"); %>
}
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "/*"); %>
}
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "*/"); %>
if(wanproto == "pppoe" || wanproto == "pptp" || wanproto == "l2tp" || wanproto == "heartbeat"){
if(F.ppp_username.value == ""){
alert(errmsg.err0);
F.ppp_username.focus();
return false;
}
if(F.ppp_passwd.value == ""){
alert(errmsg.err6);
F.ppp_passwd.focus();
return false;
}
}
if(wanproto == "auto" || wanproto == "wbridge")
{
if(!valid_device_name(F.machine_name))
{
return false;
}
}
return true ; 
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
if( a1 + a2 > 255){
alert(errmsg.err2);
return false;
} 
if(!valid_ip_for_dns(F,"F.wan_dns0","DNS1",MASK_NO))
return false;
if(!valid_ip_for_dns(F,"F.wan_dns1","DNS2",MASK_NO))
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
var temp = document.getElementsByName("wan_proto");
for(var i=0;i<temp.length;i++)
{
if(temp[i].checked)
var wanproto = temp[i].value;
}
var start = '';
var end = '';
var total = F.elements.length;
for(i=0 ; i < total ; i++){
if(F.elements[i].name == "dhcp_res")	start = i;
if(F.elements[i].name == "wan_wins_3")	end = i;
}
if(start == '' || end == '')	return true;
if( T == "static" ) {
EN_DIS = 0;
for(i = start; i<=end ;i++)
choose_disable(F.elements[i]);
}
else {
EN_DIS = 1;
for(i = start; i<=end ;i++)
choose_enable(F.elements[i]);
}
if(wanproto == "static") {
disable_second_dns();
}
}
function SelTime(num,f)
{
var str = f.time_zone.options[num].value;
var Arr = new Array();
Arr = str.split(' ');
aaa = Arr[2];
daylight_enable_disable(f,aaa);
}
function ppp_enable_disable(F,I)
{
var temp = document.getElementsByName("wan_proto");
for(var i=0;i<temp.length;i++)
{
if(temp[i].checked)
var wanproto = temp[i].value;
}
F.ppp_demand_pppoe.value = "9";
F.ppp_demand_pptp.value = "9";
F.ppp_demand_l2tp.value = "9";
F.ppp_demand_hb.value = "9";
if(wanproto=="pppoe"){
F.ppp_demand_pppoe.value = I;
}else if(wanproto=="pptp"){
F.ppp_demand_pptp.value = I;
}else if(wanproto=="l2tp"){
F.ppp_demand_l2tp.value = I;
}else if(wanproto=="auto"){
F.ppp_demand_hb.value = I;
}
if( F.ppp_demand[1].checked == true && F.ppp_demand[0].checked == false){
choose_disable(F.ppp_idletime);
choose_enable(F.ppp_redialperiod);
}
else{
choose_enable(F.ppp_idletime);
choose_disable(F.ppp_redialperiod);
}
}
function dslite_enable_disable(F,I)
{
if( I == "0"){
choose_enable(F.dslite_info);
}
else{
choose_disable(F.dslite_info);
}
}
function daylight_enable_disable(F,aaa)
{
if(aaa == 0){
F._daylight_time.checked = false;
choose_disable(F._daylight_time);
F.daylight_time.value = 0;
}
else{
F._daylight_time.checked = true;
choose_enable(F._daylight_time);                
F.daylight_time.value = 1;
}
}
function init_dual_image()
{
var boot_from = '<% nvram_get("boot_from"); %>';
var boot_from_fixed = '<% nvram_get("boot_from_fixed"); %>';
var skip_prompt = '<% nvram_get("skip_prompt"); %>';
if(boot_from == "2" && skip_prompt != "1" && boot_from_fixed != "2") 
{
if(confirm("Using backup image 2 due to the image 1 was broken. Click the Confirm button to skip prompt next time.")) 
{
document.setup.submit_button.value = "index";
document.setup.change_action.value = "gozila_cgi";
document.setup.submit_type.value = "skip_prompt";
document.setup.submit();		
}
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
SelWAN(F,1);
/*John@0702
if(lang == "nl")
{
var dhcp_button = document.getElementsByName("dhcp_res");
var funfield = getstyle(".FUNFIELD");
dhcp_button[0].style.width = 110;
getstyle(".FUNNAME2").width = 100;	// from 131px to 100px
funfield.width = 316;				// from 300px to 331px
funfield.paddingLeft = 15;			// from 0px to 15px
}
else if(lang == "ru")
{
var dhcp_button = document.getElementsByName("dhcp_res");
var funfield = getstyle(".FUNFIELD");
dhcp_button[0].style.width = 140;
getstyle(".FUNNAME2").width = 95;	// from 131px to 95px
funfield.width = 311;				// from 300px to 336px
funfield.paddingLeft = 25;			// from 0px to 25px
}
*/
mtu_enable_disable(document.setup,'<% nvram_get("mtu_enable"); %>');
/*John@0702
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
str = F.time_zone.options[F.time_zone.selectedIndex].value;
Arr = new Array();
var RANGESET ; 
Arr = str.split(' ');
aaa = Arr[2];
if(aaa == 0){
document.setup._daylight_time.checked = false;
choose_disable(document.setup._daylight_time);
document.setup.daylight_time.value = 0;
}
*/
if(F.switch_mode.value==0)
{
if(document.setup.wan_proto.value == "pppoe")
ppp_enable_disable(document.setup,'<% nvram_get("ppp_demand_pppoe"); %>');
else if(document.setup.wan_proto.value == "pptp")
ppp_enable_disable(document.setup,'<% nvram_get("ppp_demand_pptp"); %>');
else if(document.setup.wan_proto.value == "l2tp")
ppp_enable_disable(document.setup,'<% nvram_get("ppp_demand_l2tp"); %>');
else if(document.setup.wan_proto.value == "heartbeat")
ppp_enable_disable(document.setup,'<% nvram_get("ppp_demand_hb"); %>');
dhcp_enable_disable(document.setup,'<% nvram_get("lan_proto"); %>');
if (document.setup.wan_proto.value == "dslite")
dslite_enable_disable(document.setup,'<% nvram_get("dslite_config"); %>');
else {
var max_mtu = <% get_mtu("max"); %>;
if(document.setup.wan_mtu.value > max_mtu || document.setup.mtu_enable.value == '0') 
document.setup.wan_mtu.value = max_mtu;
}
/*John@0702
<% support_invmatch("DUAL_IMAGE_SUPPORT", "1", "//"); %> init_dual_image();
if ( '<% nvram_selget("time_zone"); %>' == '+12 2 4' ) {
document.setup.time_zone.selectedIndex = '37';
}
if(document.setup.now_proto.value == "static") {
disable_second_dns();
}
*/
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "/*"); %>
if(document.setup.wan_proto.value == "pptp") {
pptp_dhcp = "<% nvram_else_match("sel_pptp_dhcp","1","1", "0"); %>" ; 
update_checked(document.setup.ppp_demand[1]);
update_checked(document.setup.ppp_demand[0]);
selpptpmode(pptp_dhcp);
if ( pptp_dhcp == 1 ) 
document.setup.sel_pptp_dhcp[0].checked = true ; 
else
document.setup.sel_pptp_dhcp[1].checked = true ; 
}
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "*/"); %>
/*John@0702
if ((parseInt(sip)<parseInt(F.lan_ipaddr_3.value)) && (parseInt(eip)>=parseInt(F.lan_ipaddr_3.value)))RANGESET = 2 ; 	     else RANGESET = 1; 
if ( RANGESET == 1 ) 
{
document.getElementById("DymRange").innerHTML = "<% prefix_ip_get("lan_ipaddr",1); %> "+sip+" to "+eip;
}
else if ( RANGESET == 2 ) 
{
document.getElementById("DymRange").innerHTML = "<% prefix_ip_get("lan_ipaddr",1); %> "+sip+" to "+parseInt(parseInt(F.lan_ipaddr_3.value)-1);
eip = eip + 1 ; 
document.getElementById("DymRange").innerHTML += "<BR><% prefix_ip_get("lan_ipaddr",1); %> "+ parseInt(parseInt(F.lan_ipaddr_3.value)+1) + " to " + eip;
}
if ( F.lan_proto[1].checked == true ) return ; // IF DHCP Server is disabled.
if(F.lan_netmask.options[F.lan_netmask.selectedIndex].value == "255.255.255.252") {
choose_disable(F.dhcp_start_tmp);
choose_disable(F.dhcp_num);
}
else {
choose_enable(F.dhcp_start_tmp);
choose_enable(F.dhcp_num);
}
*/
}
if(F.switch_mode.value==1)
{	
SetControlStatus(F,0,"dhcp_start","ppp_demand_hb");
if(F.switch_mode_dhcp.value==1)
{
SetControlStatus(F,0,"switch_ipaddr_0","switch_gateway_3");
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
document.getElementById("dns00").disabled = "";
document.getElementById("dns01").disabled = "";
document.getElementById("dns02").disabled = "";
document.getElementById("dns03").disabled = "";
document.getElementById("dns10").disabled = "";
document.getElementById("dns11").disabled = "";
document.getElementById("dns12").disabled = "";
document.getElementById("dns13").disabled = "";
document.getElementById("dns20").disabled = "";
document.getElementById("dns21").disabled = "";
document.getElementById("dns22").disabled = "";
document.getElementById("dns23").disabled = "";
}
function valid_gn_ip(F,I,M,flag)
{	
var mask = new Array(4);
var ip = new Array(4);
var a_gn_lan_ip = new Array();
var a_lan_mask = new Array();
var gn_lan_ip = '<% nvram_get("gn_lan_ipaddr"); %>';
var gn_lan_mask = '<% nvram_get("gn_lan_netmask"); %>';
a_lan_ip = gn_lan_ip.split(".");
a_lan_mask = gn_lan_mask.split(".");
var i = 0;
for(i=0,j=0;i<4;i++,j=j+4)
{
ip[i]=eval(I+i).value;
if(flag == "0")
{
mask[i]=M.value.substring(j, j + 3);
}
else
mask[i]=eval(M+i).value;
}
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
if (valid_gn_ip(F, "F.lan_ipaddr_", F.lan_netmask, "0") == false)
{
alert(gn.err6);
F.lan_ipaddr_0.focus();
return false;
}
if( (F.lan_ipaddr_0.value != F.lan_ipaddr_0.defaultValue) || (F.lan_ipaddr_1.value != F.lan_ipaddr_1.defaultValue) || (F.lan_ipaddr_2.value != F.lan_ipaddr_2.defaultValue) || (F.lan_ipaddr_3.value != F.lan_ipaddr_3.defaultValue) )
{
F.wait_time.value="21";
F.need_reboot.value="1";
}
return true;
}
function DHCP_Res()
{	
if ( close_session == "1" )
showPopout('DHCP_Static.asp');
else	
showPopout('DHCP_Static.asp?session_id=<% nvram_get("session_key"); %>');
return;
if ( close_session == "1" )
{
DHCPRef = window.open('DHCP_Static.asp','DHCPResTable','alwaysRaised,resizable,scrollbars,width=710,height=500');
}
else
{
DHCPRef = window.open('DHCP_Static.asp;session_id=<% nvram_get("session_key"); %>','DHCPResTable','alwaysRaised,resizable,scrollbars,width=710,height=500');
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
if ( I.lan_proto[1].checked == true ) return ; // IF DHCP Server is disabled.
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
return false; 
case 1 : 	
document.getElementById("DymRange").innerHTML = "<% prefix_ip_get("lan_ipaddr",1); %> " + DHCP_START_IP[0] + " to " + DHCP_END_IP[0];
I.dhcp_num.value = RANGE_COUNT;
I.dhcp_start_tmp.value = DHCP_START_IP[0];
break;
case 2 : 
document.getElementById("DymRange").innerHTML = "<% prefix_ip_get("lan_ipaddr",1); %> " + DHCP_START_IP[0] + " to " + DHCP_END_IP[0];
document.getElementById("DymRange").innerHTML += "<BR><% prefix_ip_get("lan_ipaddr",1); %> "+ DHCP_START_IP[1] + " to " + DHCP_END_IP[1];
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
if ((reserve_ip & submask) != subnet)
{
alert(errmsg.err102);
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
return;
}
else if ( lanip3 == start_ip_max + 1 )
{
alert(errmsg.err78);
return;
}
if( string == "dhcp_start" && valid_range(I.dhcp_start_tmp,start_ip_min,start_ip_max,"DHCP%20starting%20IP") == false )
{
document.getElementById("DymRange").innerHTML = "";
return;
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
document.getElementById("DymRange").innerHTML = "";     
return;
}
if ((iprange - 3) >= max_num)
ucount = max_num ;
else
{
alert(errmsg.err2);
document.getElementById("DymRange").innerHTML = "";
return;
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
document.getElementById("DymRange").innerHTML = "";     
return;
}
document.getElementById("DymRange").innerHTML =	"<% prefix_ip_get("lan_ipaddr",1); %> "+ sip[0] + " to " + eip[0];
if (set2 == true)
{
document.getElementById("DymRange").innerHTML += "<BR>" +"<% prefix_ip_get("lan_ipaddr",1); %> "+ sip[1] + " to " + eip[1];
}
I.dhcp_num.value = ucount;
if(I.dhcp_start.value != sip[0])
I.dhcp_start_tmp.value = sip[0];
}
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "/*"); %>
function selpptpmode(I)
{
var F = document.setup ; 
var len = F.elements.length;
var start ; 
var end ; 
var i ; 
choose_enable(F.sel_pptp_dhcp[0]);
choose_enable(F.sel_pptp_dhcp[1]);
for(i=0; i<len; i++)
{
if(F.elements[i].name=="wan_ipaddr") start = i ; 
if(F.elements[i].name=="wan_pptp_dns2_3") end = i ; 
}
if ( start == '' || end == '') {
return true ; 
}
for(i=start; i<=end; i++)
{
if ( I == 0 ) 
choose_enable(F.elements[i]);
else
choose_disable(F.elements[i]);
}
}
function valid_wan_ip(F)
{
var temp = document.getElementsByName("wan_proto");
for(var i=0;i<temp.length;i++)
{
if(temp[i].checked)
var wanproto = temp[i].value;
}
var arrLanMask = new Array(4);
arrLanMask = F.lan_netmask.options[F.lan_netmask.selectedIndex].value.split(".");
if((wanproto == "pptp" && F.sel_pptp_dhcp[1].checked == true) || wanproto == "static")
{
if(((F.lan_ipaddr_0.value & arrLanMask[0]) == (F.wan_ipaddr_0.value & arrLanMask[0])) 
&& ((F.lan_ipaddr_1.value & arrLanMask[1]) == (F.wan_ipaddr_1.value & arrLanMask[1]))
&& ((F.lan_ipaddr_2.value & arrLanMask[2]) == (F.wan_ipaddr_2.value & arrLanMask[2]))
&& ((F.lan_ipaddr_3.value & arrLanMask[3]) == (F.wan_ipaddr_3.value & arrLanMask[3])))
{
alert(errmsg.err74);
return true;
}	
}
if(wanproto == "pptp")
{
if(((F.lan_ipaddr_0.value & arrLanMask[0]) == (F.pptp_server_ip_0.value & arrLanMask[0])) 
&& ((F.lan_ipaddr_1.value & arrLanMask[1]) == (F.pptp_server_ip_1.value & arrLanMask[1]))
&& ((F.lan_ipaddr_2.value & arrLanMask[2]) == (F.pptp_server_ip_2.value & arrLanMask[2]))
&& ((F.lan_ipaddr_3.value & arrLanMask[3]) == (F.pptp_server_ip_3.value & arrLanMask[3])))
{
alert(errmsg.pptpservererr);
return true;
}
}
if(wanproto == "l2tp")
{
if(((F.lan_ipaddr_0.value & arrLanMask[0]) == (F.l2tp_server_ip_0.value & arrLanMask[0])) 
&& ((F.lan_ipaddr_1.value & arrLanMask[1]) == (F.l2tp_server_ip_1.value & arrLanMask[1]))
&& ((F.lan_ipaddr_2.value & arrLanMask[2]) == (F.l2tp_server_ip_2.value & arrLanMask[2]))
&& ((F.lan_ipaddr_3.value & arrLanMask[3]) == (F.l2tp_server_ip_3.value & arrLanMask[3])))
{
alert(errmsg.l2tpservererr);
return true;
}
}
return false;
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
data = data + eval(I+"_"+i).value ; 
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
for(i=0;i<4;i++)
m[i] = eval(N+"_"+i).value
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
function SelLang(num,F)
{
F.submit_button.value = "index";
F.change_action.value = "gozila_cgi";
F.submit_type.value = "language";
<% support_match("AUTO_DETECT_LANGUAGE_SUPPORT", "1", "/*"); %>
F.ui_language.value=F.ui_language.options[num].value;
<% support_match("AUTO_DETECT_LANGUAGE_SUPPORT", "1", "*/"); %>
<% support_invmatch("AUTO_DETECT_LANGUAGE_SUPPORT", "1", "/*"); %>
F.detect_lang.value=F.detect_lang.options[num].value;
<% support_invmatch("AUTO_DETECT_LANGUAGE_SUPPORT", "1", "*/"); %>
F.submit();
}
function exit()
{
if (DHCPRef)
DHCPRef.close();
}
function leave_page()
{
if(document.setup.wbridge_mode.value != 1 && document.setup.switch_mode.value != 1 && '<% nvram_get("wbridge_mode"); %>' != 1 && '<% nvram_get("switch_mode"); %>' != 1)
{
return checkFormChanged(document.setup);	
}	
}
</SCRIPT>
</HEAD>
<BODY onload="init()" onunload="exit()" onbeforeunload = "return leave_page()">
<FORM name="setup" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="next_page" />
<input type="hidden" name="now_proto" value="<% nvram_gozila_get("wan_proto"); %>" />
<input type="hidden" name="daylight_time" value="0" />
<input type="hidden" name="switch_mode_dhcp" value="<% nvram_get("switch_mode_dhcp");%>" />
<input type="hidden" name="switch_mode" value="<% nvram_gozila_get("switch_mode");%>" />
<input type="hidden" name="wbridge_mode" value="<% nvram_get("wbridge_mode");%>" />
<input type="hidden" name="switch_ipaddr" value="4" />
<input type="hidden" name="hnap_devicename" value="<% nvram_get("hnap_devicename");%>" />
<input type="hidden" name="need_reboot" value="0" />
<input type="hidden" name="user_language" />
<input type="hidden" name="wait_time" value="0" />
<input type="hidden" name="dhcp_start" value="<% nvram_get("dhcp_start");%>" />
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "<!--"); %>
<input type="hidden" name="dhcp_start_conflict" value="0" />
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "-->"); %>
<input type="hidden" name="lan_ipaddr" value="4" />
<input type="hidden" name="lan_ipaddr_0" value="<% get_single_ip("lan_ipaddr","0"); %>"/>
<input type="hidden" name="lan_ipaddr_1" value="<% get_single_ip("lan_ipaddr","1"); %>"/>
<input type="hidden" name="lan_ipaddr_2" value="<% get_single_ip("lan_ipaddr","2"); %>"/>
<input type="hidden" name="lan_ipaddr_3" value="<% get_single_ip("lan_ipaddr","3"); %>"/>
<input type="hidden" name="ppp_demand_pppoe" value="9" />
<input type="hidden" name="ppp_demand_pptp" value="9" />
<input type="hidden" name="ppp_demand_l2tp" value="9" />
<input type="hidden" name="ppp_demand_hb" value="9" />
<input type="hidden" name="wan_ipv6_proto" />
<% nvram_invmatch("wan_ipv6_proto", "tunnel", "<!--"); %>
<input type="hidden" name="tunnel_status" value="connecting" />
<% nvram_invmatch("wan_ipv6_proto", "tunnel", "-->"); %>
<% web_include_file("Top.asp"); %>
<script>draw_table(MAINFUN2,lefemenu.intersetup);</script>
<table class="table table-info">
<tbody>
&nbsp;&nbsp;
<script>
(function(){
var str = [ setupcontent.dhcp, share.staticip, share.pppoe, share.pptp, share.bridge ],
val = [ 'dhcp', 'static', 'pppoe', 'pptp', 'auto'  ],
sel = '<% nvram_selget("wan_proto"); %>';
if( '<% support_match("L2TP_SUPPORT", "1", "1"); %>' == '1' )
{
if('<% get_lang(); %>' != 'ar')
{
str = [ setupcontent.dhcp, share.staticip, share.pppoe, share.pptp, hstatrouter2.l2tp, share.bridge, wlanbridge.mode];
val = [ 'dhcp', 'static','pppoe', 'pptp', 'l2tp', 'auto' ,'wbridge'];
}
else
{
str = [ setupcontent.dhcp, share.staticip, hstatrouter2.l2tp, share.pptp, share.pppoe, share.bridge, wlanbridge.mode];
val = [ 'dhcp', 'static','pppoe', 'l2tp', 'pptp', 'auto' ,'wbridge'];
}
}
if( '<% nvram_gozila_get("switch_mode"); %>' != '0' )
sel = 'auto';
draw_radio('wan_proto', str, val, "SelWAN(this.form,0)",val.indexOf(sel));
})();
</script>
<% support_match("PPTP_DHCPC_SUPPORT", "1", "<!--"); %>
<tr id=trinteripaddr style=display:none>
<td colspan="2">
<script>Capture(setupcontent.interipaddr)</script>
</td>
</tr>
<% support_match("PPTP_DHCPC_SUPPORT", "1", "-->"); %>
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "<!--"); %>
<tr id=trpptpdhcp style=display:none>
<td colspan="2">
<script>draw_radio('sel_pptp_dhcp', setupcontent.pptpdhcp, '1', 'selpptpmode(this.value)' <% nvram_match("sel_pptp_dhcp","1",", 0"); %>);</script>
</td>
</tr>
<tr id=trpptpstaticip style=display:none>
<td colspan="2">
<script>draw_radio('sel_pptp_dhcp', setupcontent.pptpstaticip, '0', 'selpptpmode(this.value)' <% nvram_invmatch("sel_pptp_dhcp","1",", 0"); %>);</script>
</td>
</tr>
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "-->"); %>
<tr id=trinderipaddr style=display:none>
<td><script>Capture(share.interipaddr)</script></td>
<td>
<input type="hidden" name="wan_ipaddr" value="4" />
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_ipaddr_0" value="<% get_single_ip("wan_ipaddr","0"); %>" onBlur="valid_range(this,1,223,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_ipaddr_1" value="<% get_single_ip("wan_ipaddr","1"); %>" onBlur="valid_range(this,0,255,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_ipaddr_2" value="<% get_single_ip("wan_ipaddr","2"); %>" onBlur="valid_range(this,0,255,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_ipaddr_3" value="<% get_single_ip("wan_ipaddr","3"); %>" onBlur="valid_range(this,1,254,'IP')" />
</td>
</tr>
<tr id=trsubmask style=display:none>
<td><script>Capture(share.submask)</script></td>
<td>
<input type="hidden" name="wan_netmask" value="4" />
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_netmask_0" value="<% get_single_ip("wan_netmask","0"); %>" onBlur="valid_range(this,0,255,'netmask')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_netmask_1" value="<% get_single_ip("wan_netmask","1"); %>" onBlur="valid_range(this,0,255,'netmask')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_netmask_2" value="<% get_single_ip("wan_netmask","2"); %>" onBlur="valid_range(this,0,255,'netmask')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_netmask_3" value="<% get_single_ip("wan_netmask","3"); %>" onBlur="valid_range(this,0,255,'netmask')" />
</td>
</tr>
<tr id=trgateway style=display:none>
<td><script>Capture(share.gateway)</script></td>
<td>
<input type="hidden" name="wan_gateway" value="4" />
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_gateway_0" value="<% get_single_ip("wan_gateway","0"); %>" onBlur="valid_range(this,1,223,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_gateway_1" value="<% get_single_ip("wan_gateway","1"); %>" onBlur="valid_range(this,0,255,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_gateway_2" value="<% get_single_ip("wan_gateway","2"); %>" onBlur="valid_range(this,0,255,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_gateway_3" value="<% get_single_ip("wan_gateway","3"); %>" onBlur="valid_range(this,1,254,'IP')" />
</td>
</tr>
<tr id=trdns style=display:none>
<td><script>Capture(share.dns)</script> 1</td>
<td>
<input type="hidden" name="wan_dns" value="4" />
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_dns0_0" value="<% get_dns_ip("wan_dns","0","0"); %>" id="static_dns00" onBlur="valid_range(this,0,223,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_dns0_1" value="<% get_dns_ip("wan_dns","0","1"); %>" id="static_dns01" onBlur="valid_range(this,0,255,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_dns0_2" value="<% get_dns_ip("wan_dns","0","2"); %>" id="static_dns02" onBlur="valid_range(this,0,255,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_dns0_3" value="<% get_dns_ip("wan_dns","0","3"); %>" id="static_dns03" onBlur="valid_range(this,0,254,'IP')" />
</td>
</tr>
<tr id=trdns1 style=display:none>
<td><script>Capture(share.dns)</script> 2 (<script>Capture(share.optional)</script>)</td>
<td>
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_dns1_0" value="<% get_dns_ip("wan_dns","1","0"); %>" id="static_dns10" onBlur="valid_range(this,0,223,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_dns1_1" value="<% get_dns_ip("wan_dns","1","1"); %>" id="static_dns11" onBlur="valid_range(this,0,255,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_dns1_2" value="<% get_dns_ip("wan_dns","1","2"); %>" id="static_dns12" onBlur="valid_range(this,0,255,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_dns1_3" value="<% get_dns_ip("wan_dns","1","3"); %>" id="static_dns13" onBlur="valid_range(this,0,254,'IP')" />
</td>
</tr>
<tr id=trdns2 style=display:none>
<td><script>Capture(share.dns)</script> 3 (<script>Capture(share.optional)</script>)</td>
<td>
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_dns2_0" value="<% get_dns_ip("wan_dns","2","0"); %>" id="static_dns20" onBlur="valid_range(this,0,223,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_dns2_1" value="<% get_dns_ip("wan_dns","2","1"); %>" id="static_dns21" onBlur="valid_range(this,0,255,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_dns2_2" value="<% get_dns_ip("wan_dns","2","2"); %>" id="static_dns22" onBlur="valid_range(this,0,255,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_dns2_3" value="<% get_dns_ip("wan_dns","2","3"); %>" id="static_dns23" onBlur="valid_range(this,0,254,'IP')" />
</td>
</tr>
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "<!--"); %>
<tr id=trdefgateway style=display:none>
<td><script>Capture(share.defgateway)</script></td>
<td>
<input type="hidden" name="wan_pptp_gateway" value="4" />
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_pptp_gateway_0" value="<% get_single_ip("wan_pptp_gateway","0"); %>" onBlur="valid_range(this,1,223,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_pptp_gateway_1" value="<% get_single_ip("wan_pptp_gateway","1"); %>" onBlur="valid_range(this,0,255,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_pptp_gateway_2" value="<% get_single_ip("wan_pptp_gateway","2"); %>" onBlur="valid_range(this,0,255,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_pptp_gateway_3" value="<% get_single_ip("wan_pptp_gateway","3"); %>" onBlur="valid_range(this,1,254,'IP')" />
</td>
</tr>
<tr id=trpptpdns1 style=display:none>
<td><script>Capture(setupcontent.pptpdns1)</script>&nbsp;(<script>Capture(share.optional)</script>)</td>
<td>
<input type="hidden" name="wan_pptp_dns" value="4" />
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_pptp_dns0_0" value="<% get_dns_ip("wan_dns","0","0"); %>" onBlur="valid_range(this,0,223,'DNS')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_pptp_dns0_1" value="<% get_dns_ip("wan_dns","0","1"); %>" onBlur="valid_range(this,0,255,'DNS')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_pptp_dns0_2" value="<% get_dns_ip("wan_dns","0","2"); %>" onBlur="valid_range(this,0,255,'DNS')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_pptp_dns0_3" value="<% get_dns_ip("wan_dns","0","3"); %>" onBlur="valid_range(this,0,254,'DNS')" />
</td>
</tr>
<tr id=pptpdns2 style=display:none>
<td><script>Capture(setupcontent.pptpdns2)</script>&nbsp;(<script>Capture(share.optional)</script>)</td>
<td>
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_pptp_dns1_0" value="<% get_dns_ip("wan_dns","1","0"); %>" onBlur="valid_range(this,0,223,'DNS')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_pptp_dns1_1" value="<% get_dns_ip("wan_dns","1","1"); %>" onBlur="valid_range(this,0,255,'DNS')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_pptp_dns1_2" value="<% get_dns_ip("wan_dns","1","2"); %>" onBlur="valid_range(this,0,255,'DNS')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_pptp_dns1_3" value="<% get_dns_ip("wan_dns","1","3"); %>" onBlur="valid_range(this,0,254,'DNS')" />
</td>
</tr>
<tr id=pptpdns3 style=display:none>
<td><script>Capture(setupcontent.pptpdns3)</script>&nbsp;(<script>Capture(share.optional)</script>)</td>
<td>
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_pptp_dns2_0" value="<% get_dns_ip("wan_dns","2","0"); %>" onBlur="valid_range(this,0,223,'DNS')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_pptp_dns2_1" value="<% get_dns_ip("wan_dns","2","1"); %>" onBlur="valid_range(this,0,255,'DNS')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_pptp_dns2_2" value="<% get_dns_ip("wan_dns","2","2"); %>" onBlur="valid_range(this,0,255,'DNS')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="wan_pptp_dns2_3" value="<% get_dns_ip("wan_dns","2","3"); %>" onBlur="valid_range(this,0,254,'DNS')" />
</td>
</tr>
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "-->"); %>
<tr id=class style=display:none>
<td colspan="2">
<hr class="table-title-underline">
</td>
</tr>
<tr id=trgateway1 style=display:none>
<td>
<% support_match("PPTP_DHCPC_SUPPORT", "1", "<!--"); %>
<script>Capture(setupcontent.gateway)</script>
<% support_match("PPTP_DHCPC_SUPPORT", "1", "-->"); %>
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "<!--"); %>
<script>Capture(setupcontent.srvipaddr)</script>
<% support_invmatch("PPTP_DHCPC_SUPPORT", "1", "-->"); %>
</td>
<td>
<input type="hidden" name="pptp_server_ip" value="4" />
<input type="text" class="num" maxLength="3" style="width:40px" name="pptp_server_ip_0" value="<% get_single_ip("pptp_server_ip","0"); %>" onBlur="valid_range(this,1,223,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="pptp_server_ip_1" value="<% get_single_ip("pptp_server_ip","1"); %>" onBlur="valid_range(this,0,255,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="pptp_server_ip_2" value="<% get_single_ip("pptp_server_ip","2"); %>" onBlur="valid_range(this,0,255,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="pptp_server_ip_3" value="<% get_single_ip("pptp_server_ip","3"); %>" onBlur="valid_range(this,1,254,'IP')" />
</td>
</tr>
<tr id=trsrvipaddr style=display:none>
<td><script>Capture(setupcontent.srvipaddr)</script></td>
<td>
<input type="hidden" name="l2tp_server_ip" value="4" />
<input type="text" class="num" maxLength="3" style="width:40px" name="l2tp_server_ip_0" value="<% get_single_ip("l2tp_server_ip","0"); %>" onBlur="valid_range(this,1,223,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="l2tp_server_ip_1" value="<% get_single_ip("l2tp_server_ip","1"); %>" onBlur="valid_range(this,0,255,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="l2tp_server_ip_2" value="<% get_single_ip("l2tp_server_ip","2"); %>" onBlur="valid_range(this,0,255,'IP')" /> .
<input type="text" class="num" maxLength="3" style="width:40px" name="l2tp_server_ip_3" value="<% get_single_ip("l2tp_server_ip","3"); %>" onBlur="valid_range(this,1,254,'IP')" />
</td>
</tr>
<tr id=trusrname1 style=display:none>
<td><script>Capture(share.usrname1)</script></td>
<td>
<input type="text" maxLength="63" size="26" name="ppp_username" value="<% nvram_get("ppp_username"); %>" onBlur="valid_name(this,'User%20Name')" />
</td>
</tr>
<tr id=trpasswd style=display:none>
<td><script>Capture(share.passwd)</script></td>
<td>
<input type="password" maxLength="63" size="26" name="ppp_passwd" value="<% nvram_invmatch("ppp_passwd","","d6nw5v1x2pc7st9m"); %>" onBlur="valid_name(this,'Password')" />
</td>
</tr>
<tr id=trsrvname style=display:none>
<td><script>Capture(share.srvname)</script>&nbsp;(<script>Capture(share.optional)</script>)</td>
<td>
<input type="text" maxLength="63" size="26" name="ppp_service" value="<% nvram_get("ppp_service"); %>" onBlur="valid_name(this,'')" />
</td>
</tr>
<tr id=trconndemand style=display:none>
<td colspan="2">
<script>draw_radio('ppp_demand', '', '1', 'ppp_enable_disable(this.form,1)' <% nvram_match("ppp_demand","1",", 0"); %>);</script>
<script>Capture(setupcontent.conndemand)</script>
<input type="text" class="num" maxLength="4" style="width:45px" name="ppp_idletime" value="<% nvram_get("ppp_idletime"); %>" onBlur="valid_range(this,1,9999,'Idle%20time')" />
<script>Capture(setupcontent.minute)</script>
</td>
</tr>
<tr id=trkeepalive style=display:none>
<td colspan="2">
<script>draw_radio('ppp_demand', '', '0', 'ppp_enable_disable(this.form,0)' <% nvram_match("ppp_demand","0",", 0"); %>);</script>
<script>Capture(setupcontent.keepalive)</script>
<input type="text" class="num" maxLength="4" style="width:45px" name="ppp_redialperiod" value="<% nvram_get("ppp_redialperiod"); %>" onBlur="valid_range(this,20,180,'Redial%20period')" />
<script>Capture(setupcontent.second)</script>
</td>
</tr>
<tr id=ssid style=display:none>
<TD ><script>Capture(wlansetup.ssid)</script></TD>
<TD ><INPUT maxLength=32 value='<% nvram_get("wbridge_ssid"); %>' name="wbridge_ssid" size="17"  onBlur=valid_name(this,"SSID")></TD>
</tr>
<TR id=networkband style=display:none>		
<TD ><script>Capture(wlanbridge.networkband)</script></TD>
<td><script>draw_radio('wbridge_band',wlansetup.band24g, '0', '' <% nvram_match("wbridge_band","0",", 0"); %>);</script>
<script>draw_radio('wbridge_band',wlansetup.band5g, '1', '' <% nvram_match("wbridge_band","1",", 0"); %>);</script>
</td>
</TR>
<TR id=secmode style=display:none>
<TD ><script>Capture(wlansec.secmode)</script></TD>
<TD>	
<script>
(function(){
var str = [share.disabled, hwlsec2.wpa2personal,hwlsec2.wpapersonal],
val = ['disabled', 'wpa2_personal', 'wpa_personal'];
draw_select('wbridge_security_mode', str, val, 'SelWLSecMode(this.form.wbridge_security_mode.selectedIndex,this.form)', '<% nvram_selget("wbridge_security_mode"); %>');
})();
</script>	
</TD>
</TR>
<TR id=passphrase style=display:none>
<TD ><script>Capture(wlansec.passphrase)</script></TD>
<TD ><INPUT size=26 name=wbridge_wpa_psk value='<% nvram_get("wbridge_wpa_psk"); %>' maxlength=64>					</TD>
</TR>
<tr id=class1 style=display:none>
<td colspan="2">
<hr class="table-title-underline">
</td>
</tr>
<tr id=trbridge style=display:none>
<td><script>Capture(share.bridge)</script></td>
<td>
<script>
(function(){
var str = [share.bridge_autoip, share.bridge_specifyip],
val = ['0', '1'],
sel = val[1];
var switch_mode_dhcp1 = '<% nvram_get("switch_mode_dhcp"); %>';
if( switch_mode_dhcp1 == '' || switch_mode_dhcp1 > 1 )
{
switch_mode_dhcp = 1;
switch_mode_dhcp1 = 1;
}
if( switch_mode_dhcp1 == 1 )
sel = val[0];
draw_select('bridge_mode_sel', str, val, 'SelBridgeDhcp(this.form.bridge_mode_sel.selectedIndex,this.form)', sel);
})();
</script>
</td>
</tr>
<tr id=tripaddr style=display:none>
<td><script>Capture(share.ipaddr)</script></td>
<td>
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,1,223,'IP')" style="width:40px" value="<% get_single_ip("switch_ipaddr","0"); %>" name="switch_ipaddr_0" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'IP')" style="width:40px" value="<% get_single_ip("switch_ipaddr","1"); %>" name="switch_ipaddr_1" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'IP')" style="width:40px" value="<% get_single_ip("switch_ipaddr","2"); %>" name="switch_ipaddr_2" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,1,254,'IP')" style="width:40px" value="<% get_single_ip("switch_ipaddr","3"); %>" name="switch_ipaddr_3" />
</td>
</tr>
<tr id=submask1 style=display:none>
<td><script>Capture(share.submask)</script></td>
<td>
<input type="hidden" name="switch_netmask" value="4" />
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'netmask')" style="width:40px" value="<% get_single_ip("switch_netmask","0"); %>" name="switch_netmask_0" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'netmask')" style="width:40px" value="<% get_single_ip("switch_netmask","1"); %>" name="switch_netmask_1" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'netmask')" style="width:40px" value="<% get_single_ip("switch_netmask","2"); %>" name="switch_netmask_2" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'netmask')" style="width:40px" value="<% get_single_ip("switch_netmask","3"); %>" name="switch_netmask_3" />
</td>
</tr>
<tr id=trdefgateway1 style=display:none>
<td><script>Capture(share.defgateway)</script></td>
<td>
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,1,223,'IP')" style="width:40px" value="<% get_single_ip("switch_gateway","0"); %>" name="switch_gateway_0" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'IP')" style="width:40px" value="<% get_single_ip("switch_gateway","1"); %>" name="switch_gateway_1" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'IP')" style="width:40px" value="<% get_single_ip("switch_gateway","2"); %>" name="switch_gateway_2" /> .
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,1,254,'IP')" style="width:40px" value="<% get_single_ip("switch_gateway","3"); %>" name="switch_gateway_3" />
</td>
</tr>
<tr id=trroutename style=display:none>
<td><script>Capture(share.routename)</script></td>
<td>
<input type="text" maxLength="15" size="17" name="machine_name"  value="<% nvram_get("machine_name"); %>" />
</td>
</tr>
<!-- 2011-11-17 add MTU (default: 1500) to "ds-liste" mode (G8 spec) -->
</tbody>
</table>
<div id=lefe style=display:none>
<script>draw_table(MAINFUN2,lefemenu.optset + '&nbsp;' + lefemenu.requireisp);</script>
</div>
<table class="table table-info">
<tbody>
<tr id=trhostname style=display:none>
<td><script>Capture(share.hostname)</script></td>
<td>
<input type="text" maxLength="39" size="26" name="wan_hostname" value="<% nvram_get("wan_hostname"); %>" onBlur="valid_name(this,'Host%20Name')" />
</td>
</tr>
<tr id=trdomainname style=display:none>
<td><script>Capture(share.domainname)</script></td>
<td>
<input type="text" maxLength="63" name="wan_domain" size="26" value="<% nvram_get("wan_domain"); %>" onBlur="valid_name(this,'Domain%20name',SPACE_NO)" />
</td>
</tr >
<tr id=trmtu style=display:none>
<td><script>Capture(share.mtu)</script></td>
<td>
<script>
(function(){
var str = [share.auto, share.mtumanual],
val = ['0', '1'];
draw_select('mtu_enable', str, val, 'SelMTU(this.form)', '<% nvram_get("mtu_enable"); %>');
})();
</script>
</td>
</tr>
<tr id=trmtusize style=display:none>
<td><script>Capture(share.mtusize)</script></td>
<td>
<input type="text" maxLength="4" onBlur="valid_mtu(this)" style="width:50px" value="<% nvram_get("wan_mtu"); %>" name="wan_mtu" />
</td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
