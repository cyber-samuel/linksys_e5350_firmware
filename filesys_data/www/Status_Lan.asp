<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Local Network Status</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
document.title = statopmenu.localnet;
var close_session = "<% get_session_status(); %>";
var dhcp_win = null;
function ViewDHCP()
{	
if ( close_session == "1" )
showPopout('DHCPTable.asp');
else
showPopout('DHCPTable.asp?session_id=<% nvram_get("session_key"); %>');
return;
if ( close_session == "1" )
{
dhcp_win = self.open('DHCPTable.asp','inLogTable','alwaysRaised,resizable,scrollbars,width=920,height=600');
}
else
{
dhcp_win = self.open('DHCPTable.asp?session_id=<% nvram_get("session_key"); %>','inLogTable','alwaysRaised,resizable,scrollbars,width=920,height=600');
}
dhcp_win.focus();
}
function exit()
{
closeWin(dhcp_win);
}
var switch_mode = "<% nvram_get("switch_mode");%>";
var bridge_mode = "<% nvram_get("wbridge_mode");%>";
</SCRIPT>
</HEAD>
<BODY onunload="exit()">
<FORM name="status_lan" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" />
<% web_include_file("Top.asp"); %>
<script>draw_table(MAINFUN2,statopmenu.localnet);</script>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(share.locmacaddr)</script></td>
<td><% nvram_get("lan_hwaddr"); %>&nbsp;</td>
</tr>
<tr>
<td><script>Capture(share.routeripaddr)</script></td>
<td>
<script>
if( switch_mode == "1" )
Capture('<% nvram_get("switch_ipaddr"); %>');
else
Capture('<% nvram_get("lan_ipaddr"); %>');
</script>
</td>
</tr>
<tr>
<td><script>Capture(share.submask)</script></td>
<td>
<script>
if( switch_mode == "1" )
Capture('<% nvram_get("switch_netmask"); %>');
else
Capture('<% nvram_get("lan_netmask"); %>');
</script>
</td>
</tr>
<tr>
<td><script>Capture(stalan.ipv6localaddr)</script></td>
<td>
<script>
(function(){
var addr = '<% get_ipv6_linklocal_addr(); %>';
if( switch_mode == "1" || addr == '' )
Capture(share.na);
else
Capture(addr.split(' ')[1]);
})();
</script>
</td>
</tr>
<tr>
<td><script>Capture(setupcontent.prefix_addr)</script></td>
<td>
<script>
(function(){
var wan_ipv6_proto = "<% nvram_get("wan_ipv6_proto"); %>";
var ipv6_prefix_addr = "<% nvram_get("ipv6_delegate_prefix"); %>";
var ipv6_prefix_length = "<% nvram_get("ipv6_delegate_prefixlen"); %>";
var text = '&nbsp;';
if( ipv6_prefix_addr.length )
text = ipv6_prefix_addr + '/' + ipv6_prefix_length;
if( (switch_mode != "1") && (wan_ipv6_proto == "dhcp" || wan_ipv6_proto == "tunnel" || wan_ipv6_proto == "pppoe") )
Capture(text);
else
Capture(share.na);
})();
</script>
</td>
</tr>
</tbody>
</table>
<script>draw_table(MAINFUN2,share.dhcpsrv);</script>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(share.dhcpsrv)</script></td>
<td>
<script>
(function(){
var lan_ptl = "<% nvram_get("lan_proto"); %>"; 
if( switch_mode != "1" && lan_ptl == "dhcp" && bridge_mode != "1" )
Capture(share.enabled);
else
Capture(share.disabled);
})();
</script>
</td>
</tr>
<tr>
<td><script>Capture(stalan.startip)</script></td>
<td><% prefix_ip_get("lan_ipaddr",2); %><% nvram_get("dhcp_start"); %></td>
</tr>
<tr>
<td><script>Capture(stalan.endip)</script></td>
<td>
<script>
(function(){
var prefix = "<% prefix_ip_get("lan_ipaddr",2); %>";
var lanip = <% get_single_ip("lan_ipaddr",3); %>;
var start = <% nvram_get("dhcp_start"); %>;
var num = <% nvram_get("dhcp_num"); %>;
if(lanip<start || lanip>start+num-1)
Capture(prefix + (start+num-1));
else
Capture(prefix + (start+num));
})();
</script>
</td>
</tr>
<tr>
<td><script>draw_button('javascript:ViewDHCP()', stabutton.dhcpclitbl)</script></td>
<td>&nbsp;</td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</BODY></HTML>
