<!--
<tr>
<td><script>Capture(stacontent.logsta)</script></td>
<td>
<script>
(function(){
var status1 = '<% nvram_status_get("status1"); %>';
var status2 = '<% nvram_status_get("status2"); %>';
if( status1 == 'Status' )				status1 = bmenu.statu;
if( status2 == 'Connecting' )			status2 = hstatrouter2.connecting;
else if( status2 == 'Disconnected' )	status2 = hstatrouter2.disconnected;
else if( status2 == 'Connected' )		status2 = stacontent.conn;
Capture(status2);
Capture('&nbsp;&nbsp;');
var but_arg = '<% nvram_status_get("button1"); %>';
var wan_proto = '<% nvram_get("wan_proto"); %>';
var but_type = '';
if( but_arg == 'Connect' )			but_value = stacontent.connect;
else if( but_arg == 'Disconnect' )	but_value = hstatrouter2.disconnect;
but_type = but_arg + '_' + wan_proto;
draw_button("javascript:Connect(this.form, '" + but_type + "')", but_value);
})();
</script>
</td>
</tr>
-->
<% nvram_match("wan_ipv6_proto", "tunnel", "<!--"); %>
<tr>
<td><script>Capture(setupcontent.interipaddr)</script></td>
<td>
<script>
var wan_proto = '<% nvram_get("wan_ipv6_proto"); %>';
var ipv6_info_buf = '<% get_ipv6_info("wan_ipv6_info"); %>';
var wan_ipv6_info = ipv6_info_buf.split("/");
var is_valid_ipv6_info = false;
if(wan_proto == 'disabled')
Capture(share.na)
else if( ipv6_info_buf == '' || wan_ipv6_info[0] == '' || wan_ipv6_info[0] == '::' )
Capture('0:0:0:0:0:0:0:0');
else {
Capture(wan_ipv6_info[0]);
is_valid_ipv6_info = true;
}
</script>
</td>
</tr>
<tr>
<td><script>Capture(share.defgateway)</script></td>
<td>
<script>
if(wan_proto == 'disabled')
Capture(share.na)
else if( ipv6_info_buf == '' 
|| is_valid_ipv6_info == false
|| wan_ipv6_info[1] == '' || wan_ipv6_info[1] == '::')
Capture('0:0:0:0:0:0:0:0');
else
Capture(wan_ipv6_info[1]);
</script>
</td>
</tr>
<script>
var ipv6_dns = '<% nvram_get("wan_ipv6_dns"); %>';
var tmp = ipv6_dns.split(' ');
if(tmp[0] && is_valid_ipv6_info)
var ipv6_dns1 = tmp[0];
else	
var ipv6_dns1 = '';
if(tmp[1] && is_valid_ipv6_info)
var ipv6_dns2 = tmp[1];
else		
var ipv6_dns2 = '';
if(tmp[2] && is_valid_ipv6_info)
var ipv6_dns3 = tmp[2];
else	
var ipv6_dns3 = '';
</script>
<tr>
<td><script>Capture(share.dns)</script>1</td>
<td>
<script>
if(wan_proto == "disabled" || ipv6_dns1 == "")
Capture(satusroute.localtime);
else
Capture(ipv6_dns1);
</script>
</td>
</tr>
<tr>
<td><script>Capture(share.dns)</script>2</td>
<td>
<script>
if(wan_proto == "disabled" || ipv6_dns2 == "")
Capture(satusroute.localtime);
else
Capture(ipv6_dns2);
</script>
</td>
</tr>
<tr>
<td><script>Capture(share.dns)</script>3</td>
<td>
<script>
if(wan_proto == "disabled" || ipv6_dns3 == "")
Capture(satusroute.localtime);
else
Capture(ipv6_dns3);
</script>
</td>
</tr>
<tr>
<td><script>Capture(errmsg.err42)</script></td>
<td>
<script>
(function(){
var time = <% nvram_get("wan_ipv6_lease"); %>;
day  = 0,
hour = 0,
min  = 0,
sec  = 0,
str  = '';
if( wan_proto == 'disabled' )
Capture(share.na);
else if( time == ' ' )
Capture(satusroute.localtime);
/* IR-B0017355, DUT should show DHCP lease time to 'infinity' not '49710days 6hours 28min 28sec' */
else if (time == 4294967295 /*0xFFFFFFFF*/)
Capture('infinity');
else
{
if(time > (24*60*60)) {
day = Math.floor(time/(24*60*60));
time = time%(24*60*60);
}
if(time > (60*60)) {
hour = Math.floor(time/(60*60));
time = time%(60*60);
}
if(time > 60) {
min = Math.floor(time/60);
time = time%60;
}
/* IR-B0017192, P3, DUT doesn't show DHCP Lease Time of IPv6 */
if(time != 0) { sec = time; }
if(day == 1)
str += day + ' ' + stacontent.day + ' ';
else if(day > 1)
str += day + ' ' + stacontent.days + ' ';
if(hour)
str += hour + ' ' + stacontent.hour + ' ';
if(min)
str += min + ' ' + stacontent.min + ' ';
if(sec)
str += sec + ' ' + stacontent.sec + ' ';
Capture(str);
}
})();
</script>
</td>
</tr>
<% nvram_match("wan_ipv6_proto", "tunnel", "-->"); %>
<% nvram_invmatch("wan_ipv6_proto", "tunnel", "<!--"); %>
<tr>
<td><script>Capture(stacontent.tunnel_status)</script></td>
<td id="tunnel_status">
<script>
(function(){
var s = '<% nvram_get("tunnel_status"); %>';
if(s == 'connected')
Capture(stacontent.conn);
else if(s == 'disconnected')
Capture(hstatrouter2.disconnected);
else if(s == 'connecting')
Capture(hstatrouter2.connecting);
else if(s == 'undetermined')
Capture(hstatrouter2.undetermined);
})();
</script>
</td>
</tr>
<tr>
<td><script>draw_button("javascript:tunnel_reconnect(this.form,'reconnect')", stabutton.reconnect)</script></td>
<td>&nbsp;</td>
</tr>
<% nvram_invmatch("wan_ipv6_proto", "tunnel", "-->"); %>
