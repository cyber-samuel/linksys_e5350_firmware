<!--
*********************************************************
*   Copyright 2003, CyberTAN  Inc.  All Rights Reserved *
*********************************************************
This is UNPUBLISHED PROPRIETARY SOURCE CODE of CyberTAN Inc.
the contents of this file may not be disclosed to third parties,
copied or duplicated in any form without the prior written
permission of CyberTAN Inc.
This software should be used as a reference only, and it not
intended for production use!
THIS SOFTWARE IS OFFERED "AS IS", AND CYBERTAN GRANTS NO WARRANTIES OF ANY
KIND, EXPRESS OR IMPLIED, BY STATUTE, COMMUNICATION OR OTHERWISE.  CYBERTAN
SPECIFICALLY DISCLAIMS ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A SPECIFIC PURPOSE OR NONINFRINGEMENT CONCERNING THIS SOFTWARE
-->
<html><title>System</title>
<script src="common.js"></script>
<SCRIPT language=JavaScript>
function init()
{
/*
var tmp ="<% nvram_get("tmsss_enabled"); %>";
if(tmp == '1')
{
document.sysinfo2.tmsss_status[0].checked = true;
document.sysinfo2.tmsss_status[1].checked = false;		
}
else
{
document.sysinfo2.tmsss_status[0].checked = false;
document.sysinfo2.tmsss_status[1].checked = true;		
}
*/
}
function to_submit(F)
{
F.submit_button.value = "System";
F.change_action.value = "gozila_cgi";
if(F.ipv6_status[0].checked == true) F.ipv6_button.value = "1";
else F.ipv6_button.value = "0";
<% support_invmatch("EGHN_SUPPORT", "1", "/*"); %>
if(F.eghn_status[0].checked == true) F.eghn_button.value = "1";
else F.eghn_button.value = "0";
<% support_invmatch("EGHN_SUPPORT", "1", "*/"); %>
/*
if(F.tmsss_status[0].checked == true) F.tmsss_button.value = "1";
else F.tmsss_button.value = "0";
*/
F.submit_type.value = "system_set";
F.submit();
}
function special_char_trans(I)
{
var bbb = I; 
var ccc = bbb.replace(/\s/g,"&nbsp;");
return ccc; 
}
</SCRIPT>
<body bgcolor=white onload=init()>
<form name=sysinfo2 method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=ipv6_button>
<input type=hidden name=eghn_button>
<input type=hidden name=tmsss_button>
<input type=hidden name=action>
<CENTER>
<TABLE height=100 cellSpacing=1 width=673 border=0>
<TBODY> 
<TR>
<TD width=343 colSpan=2 height=30><B><FONT face=Arial color=#0000ff><SPAN STYLE="FONT-SIZE:14pt">Wireless APs nearby</SPAN></FONT></B></TD>
</TR>
<TR align=middle bgColor=#b3b3b3>
<TH height=30><FONT face=Arial><SPAN STYLE="FONT-SIZE: 10pt">Network Name</SPAN></FONT></TH>
<TH height=30><FONT face=Arial><SPAN STYLE="FONT-SIZE: 10pt">BSSID</SPAN></FONT></TH>
<TH height=30><FONT face=Arial><SPAN STYLE="FONT-SIZE: 10pt">Channel</SPAN></FONT></TH>
<TH height=30><FONT face=Arial><SPAN STYLE="FONT-SIZE: 10pt">RSSI Info</SPAN></FONT></TH>
</TR>
<script language=javascript>
var table = new Array();
<% dump_wl_ap_table("table", "AAA"); %>
function AAA(name, bssid, channel, rssi)
{
this.name = name;
this.bssid = bssid;
this.channel = channel;
this.rssi = rssi;
}
var i = 0;
for(i=0;;i++) {
if(table.length == i) {
break;
}
document.write("<tr bgcolor=#cccccc align=middle>");
document.write("<td><SPAN STYLE=\"FONT-SIZE: 10pt\">"+table[i].name+"</td>");
document.write("<td><SPAN STYLE=\"FONT-SIZE: 10pt\">"+table[i].bssid+"</td>");
document.write("<td><SPAN STYLE=\"FONT-SIZE: 10pt\">"+table[i].channel+"</td>");
document.write("<td><SPAN STYLE=\"FONT-SIZE: 10pt\">"+table[i].rssi+"</td></tr>");
}
</script>
</TBODY></TABLE> 
<p></p>
<!--------------------------------list wireless connected clients--------- --
-->
<TABLE height=100 cellSpacing=1 width=673 border=0>
<TBODY> 
<TR>
<TD colSpan=2 height=30><B><FONT face=Arial color=#0000ff><SPAN STYLE="FONT-SIZE:14pt">Current connected wireless clients list</SPAN></FONT></B></TD>
</TR>
<TR align=middle bgColor=#b3b3b3>
<TH height=30><FONT face=Arial><SPAN STYLE="FONT-SIZE: 10pt">MAC Address</SPAN></FONT></TH>
<TH height=30><FONT face=Arial><SPAN STYLE="FONT-SIZE: 10pt">Tx Rate</SPAN></FONT></TH>
<TH height=30><FONT face=Arial><SPAN STYLE="FONT-SIZE: 10pt">Rx Rate</SPAN></FONT></TH>
<TH height=30><FONT face=Arial><SPAN STYLE="FONT-SIZE: 10pt">RSSI Info</SPAN></FONT></TH>
<TH height=30><FONT face=Arial><SPAN STYLE="FONT-SIZE: 10pt">Radio Band</SPAN></FONT></TH>
</TR>
<script language=javascript>
var table = new Array();
<% dump_wl_client_table("table", "AAA"); %>
function AAA(mac, tx, rx, rssi, band)
{
this.mac = mac;
this.tx = tx;
this.rx = rx;
this.band = band;
this.rssi = rssi;
}
var i = 0;
for(i=0;;i++) {
if(table.length == i) {
break;
}
document.write("<tr bgcolor=#cccccc align=middle>");
document.write("<td><SPAN STYLE=\"FONT-SIZE: 10pt\">"+table[i].mac+"</td>");
document.write("<td><SPAN STYLE=\"FONT-SIZE: 10pt\">"+table[i].tx+"</td>");
document.write("<td><SPAN STYLE=\"FONT-SIZE: 10pt\">"+table[i].rx+"</td>");
document.write("<td><SPAN STYLE=\"FONT-SIZE: 10pt\">"+table[i].rssi+"</td>");
document.write("<td><SPAN STYLE=\"FONT-SIZE: 10pt\">"+table[i].band+"</td></tr>");
}
</script>
</TBODY></TABLE> 
<p></p>
<!--------------------------------list wireless channel information--------- --
-->
<TABLE height=100 cellSpacing=1 width=673 border=0>
<TBODY> 
<TR>
<TD colSpan=2 height=30><B><FONT face=Arial color=#0000ff><SPAN STYLE="FONT-SIZE:14pt">Current Wireless Channel information</SPAN></FONT></B></TD>  
</TR>
<TR align=middle bgColor=#b3b3b3>
<TH height=30><FONT face=Arial><SPAN STYLE="FONT-SIZE: 10pt">Network Band</SPAN></FONT></TH>
<TH height=30><FONT face=Arial><SPAN STYLE="FONT-SIZE: 10pt">Channel Width</SPAN></FONT></TH>
<TH height=30><FONT face=Arial><SPAN STYLE="FONT-SIZE: 10pt">Channel</SPAN></FONT></TH>
</TR>
<script language=javascript>
var cur_channel_0 = '<% wl_cur_channel(0); %>';
var cur_nbw_0 = '<% wl_cur_nbw(0); %>';
var cur_channel_1 = '<% wl_cur_channel(1); %>';
var cur_nbw_1 = '<% wl_cur_nbw(1); %>';
var wl0_net_mode = "<% nvram_get("wl0_net_mode"); %>";
var wl1_net_mode = "<% nvram_get("wl1_net_mode"); %>";
document.write("<tr bgcolor=#cccccc align=middle>");
document.write("<td><SPAN STYLE=\"FONT-SIZE: 10pt\">2.4 GHz Wireless Network</td>");
if(wl0_net_mode == "disabled" || cur_channel_0 == "")
{
document.write("<td><SPAN STYLE=\"FONT-SIZE: 10pt\">N/A</td>");
document.write("<td><SPAN STYLE=\"FONT-SIZE: 10pt\">N/A</td></tr>");
}
else{
document.write("<td><SPAN STYLE=\"FONT-SIZE: 10pt\">"+cur_nbw_0+"</td>");
document.write("<td><SPAN STYLE=\"FONT-SIZE: 10pt\">"+cur_channel_0+"</td></tr>");
}
document.write("<tr bgcolor=#cccccc align=middle>");
document.write("<td><SPAN STYLE=\"FONT-SIZE: 10pt\">5 GHz Wireless Network</td>");
if(wl1_net_mode == "disabled" || cur_channel_1 == "")
{
document.write("<td><SPAN STYLE=\"FONT-SIZE: 10pt\">N/A</td>");
document.write("<td><SPAN STYLE=\"FONT-SIZE: 10pt\">N/A</td></tr>");
}
else{
document.write("<td><SPAN STYLE=\"FONT-SIZE: 10pt\">"+cur_nbw_1+"</td>");
document.write("<td><SPAN STYLE=\"FONT-SIZE: 10pt\">"+cur_channel_1+"</td></tr>");
}
</script>
</TBODY></TABLE> 
<TABLE cellSpacing=0 cellPadding=10 width=873 border=1>
<TBODY>
<BR></BR>
<TR>
<TD colSpan=6 height=30><B><FONT face=Arial color=#0000ff><SPAN STYLE="FONT-SIZE:14pt">iwconfig ath0</SPAN></FONT></B></TD>
<TR align=middle bgColor=#b3b3b3>		
<TR>
<TD width=812>
<% show_sysinfo("ath0info"); %>
</TD></TR></TBODY></TABLE> 
<p></p>
<P> <INPUT type=button value=" Refresh " onClick=window.location.replace("CBT_SystemWireless.asp?session_id=<% nvram_get("session_key"); %>")></P></CENTER>
</FORM>
</BODY>
</HTML>
