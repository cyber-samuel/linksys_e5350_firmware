<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Wireless Network</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">function ViewDHCP(){self.open('DHCPTable.asp', 'DHCP', 'alwaysRaised,resizable,scrollbars,width=560,height=400');}</SCRIPT>
<script>
document.title = bmenu.wirelessnet;
var close_session = "<% get_session_status(); %>";
var wl0_net_mode = "<% nvram_get("net_mode_24g"); %>";
var wl0_nbw = "<% nvram_get("nbw_24g"); %>";
var wl0_channel = '<% nvram_get("channel_24g"); %>';
var wl0_nctrlsb = "<% nvram_get("wl0_nctrlsb"); %>";
var cur_nctrlsb = '<% wl_cur_nctrlsb(); %>';
var cur_channel = '<% wl_cur_channel(); %>';
var cur_nbw = '<% wl_cur_nbw(); %>';
var wl1_net_mode = "<% nvram_get("net_mode_5g"); %>";
var wl1_nbw = "<% nvram_get("nbw_5g"); %>";
var wl1_channel = '<% nvram_get("channel_5g"); %>';
var wl1_nctrlsb = "<% nvram_get("wl1_nctrlsb"); %>";
var wl_40m_disable = "<% nvram_get("wl_40m_disable"); %>";
var cur_nctrlsb_0 = '<% wl_cur_nctrlsb(0); %>';
var cur_channel_0 = '<% wl_cur_channel(0); %>';
var cur_nbw_0 = '<% wl_cur_nbw(0); %>';
var cur_nctrlsb_1 = '<% wl_cur_nctrlsb(1); %>';
var cur_channel_1 = '<% wl_cur_channel(1); %>';
var cur_nbw_1 = '<% wl_cur_nbw(1); %>';	
var wl0_security_mode = "<% nvram_get("wl0_security_mode"); %>";
var wl1_security_mode = "<% nvram_get("wl1_security_mode"); %>";
var wl0_crypto = "<% nvram_get("wl0_crypto"); %>";
var wl1_crypto = "<% nvram_get("wl1_crypto"); %>";
var wl0_closed = "<% nvram_get("closed_24g"); %>";
var wl1_closed = "<% nvram_get("closed_5g"); %>";
</script>
</HEAD>
<BODY>
<FORM name="status_wifi" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" />
<% web_include_file("Top.asp"); %>
<script>draw_table(MAINFUN2,wlanleftmenu.hgstatus);</script>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(share.macaddr)</script></td>
<td>
<script>
if('<% nvram_get("wl1_hwaddr"); %>' != '')
Capture('<% nvram_get("wl1_hwaddr"); %>');
else
Capture(satusroute.localtime);
</script>
</td>
</tr>
<tr>
<td><script>Capture(stawlan.mode)</script></td>
<td>
<script>
if( wl1_net_mode == 'mixed' )
Capture(wlansetup.mixed);
else if( wl1_net_mode == 'a-only' )
Capture(wlansetup.aonly);
else if( wl1_net_mode == 'n-only' )
Capture(wlansetup.nonly);
else if( wl1_net_mode == 'bg-mixed' )
Capture(wlansetup.bgmixed);
else if( wl1_net_mode == 'disabled' )
Capture(share.disabled);
else if( wl1_net_mode == 'ac-mixed' )
Capture(wlansetup.acmixed);
</script>
</td>
</tr>
<tr>
<td><script>Capture(wlansetup.ssid)</script></td>
<td>
<% nvram_get_len("ssid_5g","25"); %>
</td>
</tr>
<tr>
<td><script>Capture(wlansetup.radioband)</script></td>
<td>
<script>
if( wl1_net_mode == "disabled" || cur_channel_1 == "" )
Capture(share.na);
/*
else if(wl1_nbw == "20MHz" || wl1_nbw == "20")
Capture(wlansetup.standard20);
else if(wl1_nbw == "40MHz" || wl1_nbw == "40")
Capture(wlansetup.wide40);
else
Capture(wlansetup.wideauto);	
*/
else if(cur_nbw_1 == "Auto")
Capture(wlansetup.onlyauto);
else if(cur_nbw_1 == "20MHz")
Capture(wlansetup.standard20);
else if(cur_nbw_1 == "40Mhz" || cur_nbw_1 == "40MHz")
Capture(wlansetup.wide40);
else if(cur_nbw_1 == "80MHz")
Capture(wlansetup.wide80);
else
Capture(cur_nbw_1);
</script>
</td>
</tr>
<tr>
<td><script>Capture(wlansetup.channel)</script></td>
<td>
<script>
if(wl1_net_mode == "disabled" || cur_channel_1 == "")
Capture(share.na);
else
Capture(cur_channel_1);		
/*
else {	// 40
if(cur_nctrlsb_1 == "upper") {
Capture(parseInt(cur_channel_1)+2);
}
else {
Capture(parseInt(cur_channel_1)-2);
}
}*/
</script>
</td>
</tr>
<tr>
<td><script>Capture(bmenu.security)</script></td>
<td>
<script>
if (wl1_security_mode == 'disabled')
Capture(share.disabled);
else if (wl1_security_mode == 'wep')
Capture(wlansec.wep);
else if (wl1_security_mode == 'wpa_personal')
if(wl1_crypto == 'tkip')
Capture(hwlsec2.wpa2mixed);
else
Capture(hwlsec2.wpapersonal);
else if (wl1_security_mode == 'wpa2_personal')
Capture(hwlsec2.wpa2personal);
else if (wl1_security_mode == 'wpa_enterprise')
Capture(hwlsec2.wpaenterprise);
else if (wl1_security_mode == 'wpa2_enterprise')
Capture(hwlsec2.wpa2enterprise);
else if (wl1_security_mode == 'radius')
Capture(wlansec.radius);
else if(wl1_security_mode == 'wpa_wpa2_mixed')
Capture(hwlsec2.wpa2mixed);
</script>
</td>
</tr>
<tr>
<td><script>Capture(wlansetup.ssidbroadcast)</script></td>
<td>
<script>
if (wl1_closed == '0')
Capture(share.enabled);
else
Capture(share.disabled);
</script>
</td>
</tr>
</tbody>
</table>
<!-- 5G wireless over and start 2.4G wireless -->
<script>draw_table(MAINFUN2,wlanleftmenu.lgstatus);</script>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(share.macaddr)</script></td>
<td>
<script>
if('<% nvram_get("wl0_hwaddr"); %>' != '')
Capture('<% nvram_get("wl0_hwaddr"); %>');
else
Capture(satusroute.localtime);
</script>
</td>
</tr>
<tr>
<td><script>Capture(stawlan.mode)</script></td>
<td>
<script>
if( wl0_net_mode == 'mixed' )
Capture(wlansetup.mixed);
else if( wl0_net_mode == 'b-only' )
Capture(wlansetup.bonly);
else if( wl0_net_mode == 'g-only' )
Capture(wlansetup.gonly);
else if( wl0_net_mode == 'n-only' )
Capture(wlansetup.nonly);
else if( wl0_net_mode == 'bg-mixed' )
Capture(wlansetup.bgmixed);
else if( wl0_net_mode == 'disabled' )
Capture(share.disabled);
</script>
</td>
</tr>
<tr>
<td><script>Capture(wlansetup.ssid)</script></td>
<td><% nvram_get_len("ssid_24g","25"); %>&nbsp;</td>
</tr>
<tr>
<td><script>Capture(wlansetup.radioband)</script></td>
<td>
<script>
if( wl0_net_mode == "disabled" || cur_channel_0 == "" )
Capture(share.na);
/*
else if(wl_40m_disable == "1" || cur_nbw_0 == "20MHz" || cur_nbw_0 == "20")
Capture(wlansetup.standard20);
else
Capture(wlansetup.wideauto);
*/
else if(cur_nbw_0 == "Auto")
Capture(wlansetup.onlyauto);
else if(cur_nbw_0 == "20MHz")
Capture(wlansetup.standard20);
else if(cur_nbw_0 == "40Mhz" || cur_nbw_0 == "40MHz")
Capture(wlansetup.wide40);
else
Capture(cur_nbw_0);
</script>
</td>
</tr>
<tr>
<td><script>Capture(wlansetup.channel)</script></td>
<td>
<script>
if(wl0_net_mode == "disabled" || cur_channel_0 == "")
Capture(share.na);
else
Capture(cur_channel_0);		
/*
else {	// 40
if(cur_nctrlsb_0 == "upper") {
Capture(parseInt(cur_channel_0)+2);
}
else {
Capture(parseInt(cur_channel_0)-2);
}
}
*/
</script>
</td>
</tr>
<tr>
<td><script>Capture(bmenu.security)</script></td>
<td>
<script>
if (wl0_security_mode == 'disabled')
Capture(share.disabled);
else if (wl0_security_mode == 'wep')
Capture(wlansec.wep);
else if (wl0_security_mode == 'wpa_personal')
Capture(hwlsec2.wpapersonal);
else if (wl0_security_mode == 'wpa2_personal')
{
if (wl0_crypto == 'aes')
Capture(hwlsec2.wpa2personal);
else
Capture(hwlsec2.wpa2mixed);
}			
else if (wl0_security_mode == 'wpa_enterprise')
Capture(hwlsec2.wpaenterprise);
else if (wl0_security_mode == 'wpa2_enterprise')
Capture(hwlsec2.wpa2enterprise);
else if (wl0_security_mode == 'radius')
Capture(wlansec.radius);
else if(wl0_security_mode == 'wpa_wpa2_mixed')
Capture(hwlsec2.wpa2mixed);
</script>
</td>
</tr>
<tr>
<td><script>Capture(wlansetup.ssidbroadcast)</script></td>
<td>
<script>
if (wl0_closed == '0')
Capture(share.enabled);
else
Capture(share.disabled);
</script>
</td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</BODY></HTML>
