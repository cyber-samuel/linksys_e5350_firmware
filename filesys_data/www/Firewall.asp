<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Firewall</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
save:   true,
cancel: true
});
document.title = share.firewall;
var close_session = "<% get_session_status(); %>";
function wan_enable_disable(F)
{
if(F._block_wan.checked == true) 
choose_enable(F._ident_pass);	
else {
choose_disable(F._ident_pass);	
}
}
function to_submit(F)
{
F.submit_button.value = "Firewall";
if(F._ipv6_filter.checked == true) 
F.ipv6_filter.value = "on";
else {
F.ipv6_filter.value = "off";
}
if(F._filter.checked == true) 
F.filter.value = "on";
else {
F.filter.value = "off";
}
if(F._block_wan.checked == true) 
F.block_wan.value = 1;
else {
F.block_wan.value = 0;
}
if(F._block_loopback){
if(F._block_loopback.checked == true) F.block_loopback.value = 1;
else 				 F.block_loopback.value = 0;
}
if(F._block_cookie){
if(F._block_cookie.checked == true) F.block_cookie.value = 1;
else 				 F.block_cookie.value = 0;
}
if(F._block_java){
if(F._block_java.checked == true) F.block_java.value = 1;
else 				 F.block_java.value = 0;
}
if(F._block_proxy){
if(F._block_proxy.checked == true) F.block_proxy.value = 1;
else 				 F.block_proxy.value = 0;
}
if(F._block_activex){
if(F._block_activex.checked == true) F.block_activex.value = 1;
else 				 F.block_activex.value = 0;
}
if(F._ident_pass){
if(F._ident_pass.checked == true) F.ident_pass.value = 0;
else 				 F.ident_pass.value = 1;
}
if(F._block_multicast){
if(F._block_multicast.checked == true){
F.multicast_pass.value = 0;
}else{
F.multicast_pass.value = 1;
}
<% support_invmatch("IPV6_SUPPORT", "1", "/*"); %>
F.ipv6_multicast_pass.value = F.multicast_pass.value;
<% support_invmatch("IPV6_SUPPORT", "1", "*/"); %>
}
F.gui_action.value = "Apply";
ajaxSubmit(0,"false");
}
function init()
{
var swmode = '<% nvram_get("switch_mode");%>';
var protocolWan = '<% nvram_get("wan_proto");%>';
if( swmode == 1)
alert(share.brdgmwn);
else if( protocolWan == "dslite" )
alert ("These features are not supported when the router is operating in DS-Lite Mode.");
var bridge_mode = "<% nvram_get("wbridge_mode");%>";
if(bridge_mode == "1")
alert(wlanbridge.warn);
if(document.firewall._block_wan.checked == true) 
choose_enable(document.firewall._ident_pass);   
else
choose_disable(document.firewall._ident_pass); 
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
</SCRIPT>
</HEAD>
<BODY onload="init()" onbeforeunload = " return checkFormChanged(document.firewall)" >
<FORM name="firewall" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="ipv6_filter" />
<input type="hidden" name="filter" />
<input type="hidden" name="block_wan" />
<input type="hidden" name="block_loopback" />
<input type="hidden" name="multicast_pass" value="0" />
<% support_invmatch("IPV6_SUPPORT", "1", "<!--"); %>
<input type="hidden" name="ipv6_multicast_pass" value="0" />
<% support_invmatch("IPV6_SUPPORT", "1", "-->"); %>
<input type="hidden" name="ident_pass" >
<input type="hidden" name="block_cookie" value="" />
<input type="hidden" name="block_java" value="0" />
<input type="hidden" name="block_proxy" value="0" />
<input type="hidden" name="block_activex" value="0" />
<input type="hidden" name="wait_time" value="3" />
<% web_include_file("Top.asp"); %>
<script>draw_table(MAINFUN2,share.firewall);</script>
<table class="table table-info">
<tbody>
<% support_invmatch("IPV6_SUPPORT", "1", "<!--"); %>
<tr>
<td>
<script>draw_checkbox('_ipv6_filter', firewall.ipv6spifirewallpro, 'on', '' <% nvram_match("ipv6_filter","on",", 1"); %>);</script>
</td>
</tr>
<% support_invmatch("IPV6_SUPPORT", "1", "-->"); %>
<tr>
<td>
<script>draw_checkbox('_filter', firewall.spifirewallpro, 'on', '' <% nvram_match("filter","on",", 1"); %>);</script>				
</td>
</tr>
</tbody>
</table>
<script>draw_table(MAINFUN2,firewall2.internetfilter);</script>
<table class="table table-info">
<tbody>
<tr>
<td colspan="2">
<script>draw_checkbox('_block_wan', firewall.blockinterreq, '1', 'wan_enable_disable(this.form)' <% nvram_match("block_wan","1",", 1"); %>);</script>
</td>
</tr>
<% support_invmatch("MULTICAST_SUPPORT", "1", "<!--"); %>
<tr>
<td colspan="2">
<script>draw_checkbox('_block_multicast', firewall2.multi, '0', '' <% nvram_match("multicast_pass","0",", 1"); %>);</script>
</td>
</tr>
<% support_invmatch("MULTICAST_SUPPORT", "1", "-->"); %>
<tr>
<td colspan="2">
<script>draw_checkbox('_block_loopback', firewall2.natredir, '0', '' <% nvram_match("block_loopback","1",", 1"); %>);</script>
</td>
</tr>
<tr>
<td colspan="2">
<script>draw_checkbox('_ident_pass', firewall2.ident, '1', '' <% nvram_match("ident_pass","0",", 1"); %>);</script>
</td>
</tr>
</tbody>
</table>
<script>draw_table(MAINFUN2,firewall2.webfilter);</script>
<table class="table table-info">
<tbody>
<tr>
<td colspan="2">
<script>draw_checkbox('_block_proxy', firewall.filterproxy, '1', '' <% nvram_match("block_proxy","1",", 1"); %>);</script>&nbsp;&nbsp;&nbsp;
<script>draw_checkbox('_block_java', firewall.javaapplets, '1', '' <% nvram_match("block_java","1",", 1"); %>);</script>&nbsp;&nbsp;&nbsp;
<script>draw_checkbox('_block_activex', firewall.activex, '1', '' <% nvram_match("block_activex","1",", 1"); %>);</script>&nbsp;&nbsp;&nbsp;
<script>draw_checkbox('_block_cookie', firewall.cookies, '1', '' <% nvram_match("block_cookie","1",", 1"); %>);</script>
</td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
