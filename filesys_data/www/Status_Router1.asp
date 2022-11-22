<% nvram_status_get("hidden1"); %>
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
<% nvram_status_get("hidden2"); %>
<tr>
<td><script>Capture(setupcontent.interipaddr)</script></td>
<td><% nvram_status_get("wan_ipaddr"); %>&nbsp;</td>
</tr>
<tr>
<td><script>Capture(share.submask)</script></td>
<td><% nvram_status_get("wan_netmask"); %>&nbsp;</td>
</tr>
<tr>
<td><script>Capture(share.defgateway)</script></td>
<td><% nvram_status_get("wan_gateway"); %>&nbsp;</td>
</tr>
<tr>
<td><script>Capture(share.dns)</script>1</td>
<td>
<script>
var wan_link = '<% nvram_status_get("wan_link"); %>';
(function(){
var wan_dns0 = '<% nvram_status_get("wan_dns0"); %>';
if(wan_dns0 == '' || wan_link == '0')
Capture(share.na)&nbsp;
else    
Capture(wan_dns0);
})();
</script>
</td>
</tr>
<tr>
<td><script>Capture(share.dns)</script>2</td>
<td>
<script>
(function(){
var wan_dns1 = '<% nvram_status_get("wan_dns1"); %>';
if(wan_dns1 == '' || wan_link == '0')
Capture(share.na)&nbsp;
else    
Capture(wan_dns1);
})();
</script>
</td>
</tr>
<tr>
<td><script>Capture(share.dns)</script>3</td>
<td>
<script>
(function(){
var wan_dns2 = '<% nvram_status_get("wan_dns2"); %>';
if(wan_dns2 == '' || wan_link == '0')
Capture(share.na)&nbsp;
else    
Capture(wan_dns2);
})();
</script>
</td>
</tr>
<tr>
<td><script>Capture(share.mtu)</script></td>
<td>
<script>
(function(){
var wan_mtu = <% nvram_get("wan_mtu"); %>;
var wan_run_mtu = <% nvram_get("wan_run_mtu"); %>;	
if(wan_link == '0')
{
Capture(wan_mtu);
}
else if(wan_mtu < wan_run_mtu)
{	
Capture(wan_mtu);
}
else
Capture(wan_run_mtu);
})();
</script>
</td>
</tr>
<script>
(function(){
var display_lease = 1;
<% nvram_invmatch("wan_proto", "dhcp", "display_lease = 0;"); %>
<% nvram_match("switch_mode", "1", "display_lease = 0;"); %>
if (display_lease)
{
var time = <% nvram_get("wan_lease"); %>,
day  = 0,
hour = 0,
min  = 0,
sec  = 0,
str  = '';
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
sec = time%60;
}
if(day == 1)
str += day + ' ' + stacontent.day + ' ';
else if(day > 1)
str += day + ' ' + stacontent.days + ' ';
if(hour)
str += hour + ' ' + stacontent.hour + ' ';
if(min)
str += min + ' ' + stacontent.min + ' ';
if(sec)
str += min + ' ' + stacontent.sec + ' ';
Capture('<tr>');
Capture('<td>' + errmsg.err42 + '</td>');
if(str == '')
{
Capture('<td>');
Capture(share.na);
Capture('</td>');
}
else
{
Capture('<td>' + str + '</td>');
}
Capture('</tr>');
}
})();
</script>
