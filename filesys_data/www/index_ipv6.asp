<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>IPv6 Setup</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
save:    true,
cancel:  true
});
document.title = topmenu.ipv6setup;
var close_session = "<% get_session_status(); %>";
var wan_proto = '<% nvram_get("wan_proto"); %>';
function init()
{
var wan_ipv6_dhcp = "<% nvram_selget("wan_ipv6_dhcp"); %>";
var F = document.setup_ipv6;
if(wan_ipv6_dhcp=="on")
F._wan_ipv6_dhcp.checked=true;
else
F._wan_ipv6_dhcp.checked=false;
update_checked(F._wan_ipv6_dhcp);
Seltunnel(wan_ipv6_dhcp,F);
if(F.select_tunnel_mode.value==2){
var tunnel_prefix=F.tunnel_prefix.value.match(/::$/);
var tunnel_prefix_show;
if(tunnel_prefix=="::"){
tunnel_prefix_show=F.tunnel_prefix.value.split("::");
F.tunnel_prefix_show.value=tunnel_prefix_show[0];
}
else
F.tunnel_prefix_show.value=F.tunnel_prefix.value;
}
var swmode = '<% nvram_get("switch_mode");%>';
if( swmode == 1)
alert(share.brdgmwn);
var bridge_mode = "<% nvram_get("wbridge_mode");%>";
if(bridge_mode == "1")
alert(wlanbridge.warn);
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
function update_tunnel(F)
{
if(F._wan_ipv6_dhcp.checked == true)
{
F.tunnel_prefix.disabled = "true";
F.tunnel_prefix_len.disabled = "true";
F.tunnel_br.disabled = "true";
F.ipv4_mask_len.disabled = "true";
}
else if(F.select_tunnel_mode.value == 0 || F.select_tunnel_mode.value == 1)
{
F.tunnel_prefix.disabled = "true";
F.tunnel_prefix_len.disabled = "true";
F.tunnel_br.disabled = "true";
F.ipv4_mask_len.disabled = "true";
document.getElementById('table').style.display = "none";
document.getElementById('prefix').style.display = "none";
document.getElementById('prefix_length').style.display = "none";
document.getElementById('relay').style.display = "none";
document.getElementById('ipv4_masklength').style.display = "none";
}
else{
F.tunnel_prefix.disabled = "";
F.tunnel_prefix_len.disabled = "";
F.tunnel_br.disabled = "";
F.ipv4_mask_len.disabled = "";
document.getElementById('table').style.display = "";
document.getElementById('prefix').style.display = "";
document.getElementById('prefix_length').style.display = "";
document.getElementById('relay').style.display = "";
document.getElementById('ipv4_masklength').style.display = "";
}
}
function SelWAN(num,F)
{
update_tunnel(F);
F.wan_ipv6_dhcp.value = "off";
F.tunnel_mode.value=F.select_tunnel_mode.options[num].value;
var wan_ipv6_dhcp = F.wan_ipv6_dhcp.value;
if(wan_ipv6_dhcp=="on")
F._wan_ipv6_dhcp.checked=true;
else
F._wan_ipv6_dhcp.checked=false;
Seltunnel(wan_ipv6_dhcp,F);
if(F.select_tunnel_mode.value==2){
var tunnel_prefix=F.tunnel_prefix.value.match(/::$/);
var tunnel_prefix_show;
if(tunnel_prefix=="::"){
tunnel_prefix_show=F.tunnel_prefix.value.split("::");
F.tunnel_prefix_show.value=tunnel_prefix_show[0];
}
else
F.tunnel_prefix_show.value=F.tunnel_prefix.value;
}
update_checked(F._wan_ipv6_dhcp);
}
function ppp_enable_disable(F,I)
{
if( I == "0"){
choose_disable(F.ipv6_ppp_idletime);
choose_enable(F.ipv6_ppp_redialperiod);
}
else{
choose_enable(F.ipv6_ppp_idletime);
choose_disable(F.ipv6_ppp_redialperiod);
}
}
function Seltunnel(num,F)
{
if(wan_proto=="pptp" || wan_proto=="l2tp"){
choose_disable(F._wan_ipv6_dhcp);
choose_enable(F.select_tunnel_mode);
if(F.select_tunnel_mode.value==2){
choose_enable(F.tunnel_prefix_show);
choose_enable(F.tunnel_prefix);
choose_enable(F.tunnel_prefix_len);
choose_enable(F.tunnel_br);
choose_enable(F.ipv4_mask_len);
}
} else {
choose_enable(F.select_tunnel_mode);
if(F.select_tunnel_mode.value==2){
choose_enable(F.tunnel_prefix_show);
choose_enable(F.tunnel_prefix);
choose_enable(F.tunnel_prefix_len);
choose_enable(F.tunnel_br);
choose_enable(F.ipv4_mask_len);
}
}
update_tunnel(F);
if(F._wan_ipv6_dhcp.checked == true)
{
choose_disable(F.select_tunnel_mode);
choose_disable(F.tunnel_prefix_show);
choose_disable(F.tunnel_prefix_len);
choose_disable(F.tunnel_br);
choose_disable(F.ipv4_mask_len);
}
else
{
choose_enable(F.select_tunnel_mode);
}
update_selected(F.select_tunnel_mode);
}
function to_submit()
{
var F = document.forms[0];
if(wan_proto=="pptp" || wan_proto=="l2tp")
F._wan_ipv6_dhcp.checked=falue;
if(F._wan_ipv6_dhcp.checked==true) {
F.wan_ipv6_dhcp.value = "on";
if(wan_proto=="pppoe")
F.wan_ipv6_proto.value="pppoe";
else
F.wan_ipv6_proto.value="dhcp";
F.lan_ipv6_dhcp.value="on";
/* 2011-Mar-17, Set tunnel_mode to disable(0) when IPv6-Automatic was enabled.
* So that the content of IPv6 Setup UI won't confuse user.
*/
F.wan_ipv6_dhcp.value="on";
F.tunnel_mode.value="0";
F.tunnel_status.disabled='true';
}
else{F.wan_ipv6_dhcp.value = "off";
if(F.select_tunnel_mode.value==0) {
F.wan_ipv6_proto.value="disabled";
F.tunnel_status.disabled='true';
} 
else {
var i;
F.wan_ipv6_proto.value="tunnel";
F.tunnel_status.value="connecting";
if(F.select_tunnel_mode.value==2) {
var tunnel_prefix_show=F.tunnel_prefix_show.value.split(":");
var illegal=0;
var ch = /^[0-9a-fA-F\:]+$/
for(i=0;i<tunnel_prefix_show.length;i++){
if(tunnel_prefix_show[i]==0 || tunnel_prefix_show[i]=="")
illegal++;
if(i==tunnel_prefix_show.length-1 && illegal==tunnel_prefix_show.length){
alert(errmsg.err100);
return;
}
}
if(tunnel_prefix_show.length==3 && tunnel_prefix_show[0]=="" && tunnel_prefix_show[1]=="" && tunnel_prefix_show[2]==""){
alert(errmsg.err100);
return;
}
if(((F.tunnel_prefix_show.value.split('::')).length-1)>1)
{
alert(errmsg.err100);
return;
}
if(F.tunnel_prefix_show.value.toLowerCase().substr(0, 2) == "ff".toLowerCase())
{
alert(errmsg.err100);
return;
}
/*if(F.tunnel_prefix_show.value.indexOf('/') != -1)	
{
alert(errmsg.err100);
return;
}*/
if(!ch.test(F.tunnel_prefix_show.value))
{
alert(errmsg.err100);
return;
}
if(!(F.tunnel_prefix_show.value.match(/::/))){
if(tunnel_prefix_show.length==8){
for(i=0;i<8;i++){
if(tunnel_prefix_show[i].length!=4 || tunnel_prefix_show[i].match(/ffff/i)==null)
break;
if(i==7){
alert(errmsg.err100);
return;
}
}
}
if(tunnel_prefix_show.length!=8)
F.tunnel_prefix.value=F.tunnel_prefix_show.value+"::";
else
F.tunnel_prefix.value=F.tunnel_prefix_show.value;
}
else
F.tunnel_prefix.value=F.tunnel_prefix_show.value;
var br = F.tunnel_br.value.split(".");
for(i=0;i<br.length;i++){
if(isNaN(br[i]))
break;
if(i==br.length-1){
if(br.length!="4" || br[0]<1||br[0]>223||br[1]<0||br[1]>255||br[2]<0||br[2]>255||br[0]<1||br[0]>254||br[0]==""||br[1]==""||br[2]==""||br[3]==""){
alert(ddnsm.tzo_notip);
F.tunnel_br.value = F.tunnel_br.defaultValue;
return;
}
}
}
if(32-eval(F.ipv4_mask_len.value)+eval(F.tunnel_prefix_len.value) > 64){
alert(errmsg.err101);
return;
}
/*If Prefix is 2002, Prefix Length should be 16, Border Relay should be 192.88.99.1, and IPv4 Address Mask should be 0.*/
var error=0;
if(tunnel_prefix_show[0]=="2002"){
for(i=1;i<tunnel_prefix_show.length;i++){
if(tunnel_prefix_show[i]!=0)
error++;
}
if(error){
alert(errmsg.err101);
return;
}
if(!error){
if(F.tunnel_prefix_len.value!=16 || F.tunnel_br.value!="192.88.99.1" || F.ipv4_mask_len.value!=0){
alert(errmsg.err101);
return;
}
}
}
}
}
F.lan_ipv6_dhcp.value="off";
F.wan_ipv6_dhcp.value="off";
F.tunnel_mode.value=F.select_tunnel_mode.value;
}
F.submit_button.value = "index_ipv6";
F.gui_action.value = "Apply";
ajaxSubmit(35,"false");
}
</SCRIPT>
</HEAD>
<BODY onload="init()" onbeforeunload = "return checkFormChanged(document.setup_ipv6)">
<FORM name="setup_ipv6" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="wait_time" value="0" />
<input type="hidden" name="need_reboot" value="0" />
<input type="hidden" name="wan_ipv6_proto" />
<input type="hidden" name="lan_ipv6_dhcp" value="on" />
<input type="hidden" name="tunnel_mode" />
<input type="hidden" name="wan_ipv6_dhcp" />
<input type="hidden" name="tunnel_status" />
<% web_include_file("Top.asp"); %>
<script>draw_table(MAINFUN2,lefemenu.intersetup);</script>
<table class="table table-info">
<tbody>
<!--
<tr>
<td><script>Capture(lefemenu.conntype)</script></td>
<td>
<script>
(function(){
var str = [setupcontent.dhcp_ipv6, setupcontent.static_ipv6, setupcontent.tunnel, share.disabled],
val = ["dhcp", "static", "tunnel", "disabled"];
draw_select('wan_ipv6_proto', str, val, 'SelWAN(this.form.wan_ipv6_proto.selectedIndex,this.form)', '<% nvram_selget("wan_ipv6_proto"); %>');
})();
</script>
</td>
</tr>
-->
<tr>
<td>
<!--	<script>draw_radio('_wan_ipv6_dhcp', share.enabled, 'on', "Seltunnel('on',this.form)");</script>
<script>draw_radio('_wan_ipv6_dhcp', share.disabled, 'off', "Seltunnel('off',this.form)");</script>
--!>
<script>draw_checkbox('_wan_ipv6_dhcp', setupcontent.ipv6auto, 'on', "Seltunnel('on',this.form)");</script>
</td>
</tr>
<tr>
<td colspan="2">
<hr class="table-title-underline">
</td>
</tr>
<tr>
<td><script>Capture(setupcontent.duid)</script></td>
<!-- <td><input type="text" maxLength="63" size="15" name="wan_ipv6_duid" value="<% nvram_get("wan_ipv6_duid"); %>" /></td> -->
<td><% nvram_get("wan_ipv6_duid"); %>&nbsp;</td>
</tr>
<!--
<tr>
<td>&nbsp;</td>
<td><script>Capture(setupcontent.msg)</script></td>
</tr>
-->
</tbody>
</table>
<script>draw_table(MAINFUN2,lefemenu.netsetup);</script>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(setupcontent.tunnel)</script></td>
<td>
<script>
(function(){
var wan_proto = '<% nvram_get("wan_proto"); %>';
var sel_pptp_dhcp = '<% nvram_get("sel_pptp_dhcp"); %>';
var str = [share.disabled, setupcontent.auto_config, setupcontent.manual_config],
val = ['0', '1', '2'];
if( wan_proto=="static" || (wan_proto=="pptp" && sel_pptp_dhcp=="0") )
{
str = [share.disabled, setupcontent.manual_config];
val = ['0', '2'];
}
draw_select('select_tunnel_mode', str, val, 'SelWAN(this.form.select_tunnel_mode.selectedIndex,this.form)', '<% nvram_selget("tunnel_mode"); %>');
})();
</script>
</td>
</tr>
<tr style=display:none id=table>
<td colspan="2">
<hr class="table-title-underline">
</td>
</tr>
<tr style=display:none id=prefix>
<td><script>Capture(setupcontent.prefix)</script></td>
<td>
<input type="hidden" name="tunnel_prefix" value="<% nvram_get("tunnel_prefix"); %>" />
<input type="text" maxLength="63" size="15" name="tunnel_prefix_show" />
</td>
</tr>
<tr style=display:none id=prefix_length>
<td><script>Capture(setupcontent.prefix_length)</script></td>
<td>
<input type="text" maxLength="2" size="3" onblur="valid_range(this,1,64,'prefix_length')" name="tunnel_prefix_len" value="<% nvram_get("tunnel_prefix_len"); %>" />
</td>
</tr>
<tr style=display:none id=relay>
<td><script>Capture(setupcontent.relay)</script></td>
<td>
<input type="text" maxLength="63" size="15" name="tunnel_br" value="<% nvram_get("tunnel_br"); %>" onBlur="valid_name(this,'Domain%20name',SPACE_NO)" />
</td>
</tr>
<tr style=display:none id=ipv4_masklength>
<td><script>Capture(setupcontent.ipv4_masklength)</script></td>
<td>
<input type="text" maxLength="2" size="3" onblur="valid_range(this,0,32,'ipv4_addr_mask')" name="ipv4_mask_len" value="<% nvram_get("ipv4_mask_len"); %>" />
</td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
