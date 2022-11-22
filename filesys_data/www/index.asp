<% web_include_file("copyright.asp"); %>
<% show_status("init"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Router Status</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
refresh: true
});
document.title = share.router;
var close_session = "<% get_session_status(); %>";
function refresh()
{
if ( close_session == "1" )
{
document.location.replace("index.asp");
}
else
{
document.location.replace("index.asp?session_id=<% nvram_get("session_key"); %>");
}
}
function DHCPAction(F,I)
{
F.submit_type.value = I;
F.submit_button.value = "Status_Router";
F.change_action.value = "gozila_cgi";
F.next_page.value="index.asp";
F.submit();
}
function Connect(F,I)
{
F.submit_type.value = I;
F.submit_button.value = "Status_Router";
F.change_action.value = "gozila_cgi";
F.next_page.value="index.asp";
F.submit();
}
function startSetupWizard(close_session){
var wz_status = "<% nvram_get("wizard_status"); %>",
link;
if (wz_status == "save_settings")
{
if(close_session == "1")
link = '/wizard/ck_internet.asp';
else
link = '/wizard/ck_internet.asp?session_id=<% nvram_get("session_key"); %>';
}
else if (wz_status == "get_connect")
{
if(close_session == "1")
link = '/wizard/get_connect.asp';
else
link = '/wizard/get_connect.asp?session_id=<% nvram_get("session_key"); %>';
}
else if (wz_status == "upgrade_fw" || wz_status == "check_fw")
{
if(close_session == "1")
link = '/wizard/success.asp';
else
link = '/wizard/success.asp?session_id=<% nvram_get("session_key"); %>';
}
else
{
if(close_session == "1")
link = '/wizard/index.asp';
else
link = '/wizard/index.asp?session_id=<% nvram_get("session_key"); %>';
}
showWizard(link);
}
function init()
{
var wizard_finish = "<% nvram_get("wizard_finish"); %>";
if(wizard_finish == '1')
{
<% show_status("onload");%>
}
document.forms[0].lice_ch.value = "0";
var close_session = "<% get_session_status(); %>";
if ( close_session == "1" )
{
document.forms[0].action= "apply.cgi";
}
else
{
document.forms[0].action= "apply.cgi?session_id=<% nvram_get("session_key"); %>";
}
if(wizard_finish != "1")
startSetupWizard(close_session);
}
function IPv6_DHCPAction(F,I)
{
F.submit_type.value = I;
F.submit_button.value = "Status_Router";
F.change_action.value = "gozila_cgi";
F.next_page.value="index.asp";
F.submit();
}
function ShowAlert(M)
{
var str = "";
var mode = "";
var wan_ip = "<% nvram_status_get("wan_ipaddr"); %>";
var wan_proto = "<% nvram_get("wan_proto"); %>";
var ac_name = "<% nvram_get("ppp_get_ac"); %>";
var srv_name = "<% nvram_get("ppp_get_srv"); %>";
if(document.status.wan_proto.value == "pppoe")
mode = "PPPoE";
else if(document.status.wan_proto.value == "l2tp")
mode = "L2TP";
else if(document.status.wan_proto.value == "heartbeat")
mode = "HBS";
else
mode = "PPTP";
if(M == "AUTH_FAIL" || M == "PAP_AUTH_FAIL" || M == "CHAP_AUTH_FAIL")
str = mode + hstatrouter2.authfail;
else if(M == "IP_FAIL" || (M == "TIMEOUT" && wan_ip == "0.0.0.0")) {
if(mode == "PPPoE") {
if(hstatrouter2.pppoenoip)	// For DE
str = hstatrouter2.pppoenoip;
else
str = hstatrouter2.noip + mode + hstatrouter2.server;
}
else
str = hstatrouter2.noip + mode + hstatrouter2.server;
}
else if(M == "NEG_FAIL")
str = mode + hstatrouter2.negfail;
else if(M == "LCP_FAIL")
str = mode + hstatrouter2.lcpfail;
else if(M == "TCP_FAIL" || (M == "TIMEOUT" && wan_ip != "0.0.0.0" && wan_proto == "heartbeat"))
str = hstatrouter2.tcpfail + mode + hstatrouter2.server;
else 
str = hstatrouter2.noconn + mode + hstatrouter2.server;
alert(str);
Refresh();
}
var value=0;
function Refresh()
{
var refresh_time = "<% show_status("refresh_time"); %>";
if(refresh_time == "")	refresh_time = 60000;
if (value>=1)
{
if ( close_session == "1" )
{
window.location.replace("index.asp");
}
else
{
window.location.replace("index.asp?session_id=<% nvram_get("session_key"); %>");
}
}
value++;
timerID=setTimeout("Refresh()",refresh_time);
}
function ViewDHCP()
{
dhcp_win = self.open('DHCPTable.asp','inLogTable','alwaysRaised,resizable,scrollbars,width=720,height=450');
dhcp_win.focus();
}
function localtime()
{
var mdata="",wdata;
var index1=-1,index2=-1;
var date1="",tmp="";
var dlen;
date1 = "<% localtime(); %>";
if( date1 == "Not Available")
document.write(satusroute.localtime);
else
{
if ((index1=  date1.indexOf("Mon")) != -1 ) wdata = (bweek.mon);
else if ((index1= date1.indexOf("Tue")) != -1) wdata = (bweek.tue);
else if ((index1= date1.indexOf("Wed")) != -1) wdata = (bweek.wed);
else if ((index1= date1.indexOf("Thu")) != -1) wdata = (bweek.thu);
else if ((index1= date1.indexOf("Fri")) != -1) wdata = (bweek.fri);
else if ((index1= date1.indexOf("Sat")) != -1) wdata = (bweek.sat);
else if ((index1= date1.indexOf("Sun")) != -1) wdata = (bweek.sun);
if ((index2=  date1.indexOf("Jan")) != -1 ) mdata = (bmonth.jan);
else if ((index2= date1.indexOf("Feb")) != -1) mdata = (bmonth.feb);
else if ((index2= date1.indexOf("Mar")) != -1) mdata = (bmonth.mar);
else if ((index2= date1.indexOf("Apr")) != -1) mdata = (bmonth.apr);
else if ((index2= date1.indexOf("May")) != -1) mdata = (bmonth.may);
else if ((index2= date1.indexOf("Jun")) != -1) mdata = (bmonth.jun);
else if ((index2= date1.indexOf("Jul")) != -1) mdata = (bmonth.jul);
else if ((index2= date1.indexOf("Aug")) != -1) mdata = (bmonth.aug);
else if ((index2= date1.indexOf("Sep")) != -1) mdata = (bmonth.sep);
else if ((index2= date1.indexOf("Oct")) != -1) mdata = (bmonth.oct);
else if ((index2= date1.indexOf("Nov")) != -1) mdata = (bmonth.nov);
else if ((index2= date1.indexOf("Dec")) != -1) mdata = (bmonth.dec);
dlen=date1.length;
if(index1!=-1)
{
tmp=wdata+date1.substring(3,dlen);
}
else{	
tmp=date1;
}
date1=tmp;
if(index2!=-1){
if('<% get_lang(); %>' != 'ar')
{
if('<% get_lang(); %>' != 'pl')
tmp=date1.substring(0,index2-index1)+mdata+date1.substring(index2+3,dlen);
else
tmp=date1.substring(0,index2-index1-1)+mdata+" "+date1.substring(index2+3,dlen);
}	
else
{
var a=date1.split(' ');
tmp=a[0] + " " + a[1] + " " + mdata + " " + a[3] + " " + a[4];
}
}
document.write(tmp);
}
}
function replace_date(date1)
{
var flg , mdata="";
var dlen = date1.length;
var date2 ;
if (  date1.indexOf("Jan") != -1 ) mdata = (bmonth.jan);
else if ( date1.indexOf("Feb") != -1) mdata = (bmonth.feb);
else if ( date1.indexOf("Mar") != -1) mdata = (bmonth.mar);
else if ( date1.indexOf("Apr") != -1) mdata = (bmonth.apr);
else if ( date1.indexOf("May") != -1) mdata = (bmonth.may);
else if ( date1.indexOf("Jun") != -1) mdata = (bmonth.jun);
else if ( date1.indexOf("Jul") != -1) mdata = (bmonth.jul);
else if ( date1.indexOf("Aug") != -1) mdata = (bmonth.aug);
else if ( date1.indexOf("Sep") != -1) mdata = (bmonth.sep);
else if ( date1.indexOf("Oct") != -1) mdata = (bmonth.oct);
else if ( date1.indexOf("Nov") != -1) mdata = (bmonth.nov);
else if ( date1.indexOf("Dec") != -1) mdata = (bmonth.dec);
if ( mdata !="")
date2 = mdata + date1.substring(4,dlen);
else
date2 = date1;
document.write(date2);
}
function tunnel_reconnect(F,I)
{
document.getElementById("tunnel_status").innerHTML = "<B>"+hstatrouter2.connecting+"</B>";
F.submit_type.value = I;
F.submit_button.value = "Status_Router";
F.change_action.value = "gozila_cgi";
F.next_page.value="index.asp";
F.submit();
}
</SCRIPT>
<BODY onload="init()">
<FORM name="status" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="next_page" />
<input type="hidden" name="change_action" />
<input type="hidden" name="wan_proto" value="<% nvram_get("wan_proto"); %>" />
<input type="hidden" id="lice_ch" value="0" />
<input type="hidden" id="lice_ch1" value="0" />
<input type="hidden" id="wizard_pppoe_account" value="" />
<input type="hidden" id="wizard_pppoe_passwd" value="" />
<input type="hidden" id="wizard_wl0_ssid" value="" />
<input type="hidden" id="wizard_wl1_ssid" value="" />
<input type="hidden" id="wizard_wl0_passwd" value="" />
<input type="hidden" id="wizard_wl1_passwd" value="" />
<input type="hidden" id="wizard_router_passwd" value="" />
<input type="hidden" id="wizard_email_ck" value="0" />
<% web_include_file("Top.asp"); %>
<script>draw_table(MAINFUN2,staleftmenu.routerinfo);</script>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(share.firmwarever)</script></td>
<td><% get_linksys_firmware_version(); %>&nbsp;<script>replace_date('<% compile_date(); %>');</script></td>
</tr>
<!--tr>
<td><script>Capture(share.firmwareverification)</script></td>
<td><% nvram_get("fw_md5sum"); %>&nbsp;</td>
</tr-->
<tr>
<td><script>Capture(stacontent.curtime)</script></td>
<td><script> localtime();</script></td>
</tr>
<tr>
<td><script>Capture(share.intmacaddr)</script></td>
<td><% nvram_get("wan_hwaddr"); %>&nbsp;</td>
</tr>
<!-- add the Server name by michael at 20080418 -->
<tr>
<td><script>Capture(share.routename)</script></td>
<td><% nvram_get("machine_name"); %>&nbsp;</td>
</tr>
<!-- end by michael -->
<tr>
<td><script>Capture(share.hostname)</script></td>
<td>
<script>
if( '<% nvram_get("wan_hostname"); %>' != '' )
Capture('<% nvram_get_len("wan_hostname","30"); %>');
else
Capture(satusroute.localtime);
</script>&nbsp;
</td>
</tr>
<tr>
<td><script>Capture(share.domainname)</script></td>
<td>
<script>
if( '<% nvram_get("wan_domain"); %>' != '' )
Capture('<% nvram_get_len("wan_domain", "30"); %>');
else
Capture(satusroute.localtime);
</script>
</td>
</tr>
</tbody>
</table>
<script>draw_table(MAINFUN2,share.internetconn);</script>
<table class="table table-info">
<tbody>
<tr>
<td><strong>IPv4</strong></td>
<td>&nbsp;</td>
</tr>
<tr>
<td><script>Capture(stacontent.conntype)</script></td>
<td>
<script>
(function(){
var switch_mode = "<% nvram_get("switch_mode");%>";
if(switch_mode == "1")
Capture(share.bridge);
else
{
var wan_ptl = "<% nvram_get("wan_proto"); %>";
if(wan_ptl == "dhcp")
Capture(setupcontent.dhcp);
else if(wan_ptl == "static")
Capture(hstatrouter2.wan_static);
else if(wan_ptl == "pppoe")
Capture(share.pppoe);
else if(wan_ptl == "pptp")
Capture(share.pptp);
else if(wan_ptl == "l2tp")
Capture(hstatrouter2.l2tp);
else if(wan_ptl == "auto")
Capture(share.bridge);
else if(wan_ptl == "wbridge")
Capture(wlanbridge.name);
}		
})();
</script>
</td>
</tr>
<% show_status_setting(); %>
<script language=javascript>
var display_DHCPAction = 1;
<% nvram_invmatch("wan_proto", "dhcp", "display_DHCPAction = 0;"); %>
<% nvram_match("switch_mode", "1", "display_DHCPAction = 0;"); %>
if (display_DHCPAction)
{
document.write("<tr><td colspan=\"2\">");
draw_button("javascript:DHCPAction(this.form, 'release')", stabutton.dhcprelease);
draw_button("javascript:DHCPAction(this.form, 'renew')", stabutton.dhcprenew);
document.write("</td></tr>");
}
</script>
<tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>
<tr>
<td><strong>IPv6</strong></td>
<td>&nbsp;</td>
</tr>
<tr>
<td><script>Capture(stacontent.conntype)</script></td>
<td>
<script>
(function(){
var wan_ptl = "<% nvram_get("wan_ipv6_proto"); %>";
if(wan_ptl == "dhcp")
Capture(setupcontent.ipv6auto);
else if(wan_ptl == "static")
Capture(setupcontent.static_ipv6);
else if(wan_ptl == "pppoe")
Capture(setupcontent.pppoe_ipv6);
else if(wan_ptl == "tunnel")
Capture(setupcontent.tunnel);
else if(wan_ptl == "disabled")
Capture(share.na);
})();
</script>
</td>
</tr>
<% show_status_ipv6_setting(); %>
<script language=javascript>	
if('<% nvram_get("wan_proto"); %>' != "wbridge" && '<% nvram_get("wan_ipv6_proto"); %>' != "tunnel" && '<% nvram_get("wan_proto"); %>' != "pppoe")
{
document.write("<tr><td colspan=\"2\">");
draw_button("javascript:IPv6_DHCPAction(this.form, 'release6')", stabutton.dhcprelease)
draw_button("javascript:IPv6_DHCPAction(this.form, 'renew6')", stabutton.dhcprenew)
document.write("</td></tr>");
}
</script>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
