<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>DMZ</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
save:   true,
cancel: true
});
document.title = share.dmz;
var close_session = "<% get_session_status(); %>";
var EN_DIS = '<% nvram_get("dmz_enable"); %>';
var lan_ip = '<% nvram_get("lan_ipaddr"); %>';
var dhcp_win = null;
function valid_range2(I,start,end,M, idx)
{
if (M=="IP")
{
if (I.value == "0" || I.value == "")
return true;
}
return valid_rangeNEW(I,start,end,M);
}
function ViewDHCP()
{
showPopout('DHCP_Table_Select.asp?session_id=<% nvram_get("session_key"); %>');
return;
if ( close_session == "1" )
{
dhcp_win = self.open('DHCP_Table_Select.asp','inLogTable','alwaysRaised,resizable,scrollbars,width=720,height=600');
}
else
{
dhcp_win = self.open('DHCP_Table_Select.asp?session_id=<% nvram_get("session_key"); %>','inLogTable','alwaysRaised,resizable,scrollbars,width=720,height=600');
}
dhcp_win.focus();
}
function exit()
{
closeWin(dhcp_win);
}
function valid_value(F)
{
var i;
var tip;
var netid;
var brcastip;
var mask;
var lan_mask = '<% nvram_get("lan_netmask"); %>';
i = lan_ip.lastIndexOf('.');
tip=lan_ip.substring(i+1);
i = lan_mask.lastIndexOf('.');
mask = lan_mask.substring(i+1);
netid=eval(tip&mask);
brcastip=eval(netid+255-mask);
if(F._dmz_enable.checked == true){
if(F.dmz_src_any[1].checked == true){
if(F.dmz_src_ip_0.value == "0" || F.dmz_src_ip_0.value == "") 
{
alert(errmsg.err14 + '['+ 1 + ' - ' + 223 +'].');
F.dmz_src_ip_0.focus();
return false;	
}
if(F.dmz_src_ip_1.value == "")
{
alert(errmsg.err14 + '['+ 0 + ' - ' + 255 +'].');
F.dmz_src_ip_1.focus();
return false;
}
if(F.dmz_src_ip_2.value == "")
{
alert(errmsg.err14 + '['+ 0 + ' - ' + 255 +'].');
F.dmz_src_ip_2.focus();
return false;
}
if(F.dmz_src_ip_3.value == "0" || F.dmz_src_ip_3.value == "")
{
alert(errmsg.err14 + '['+ 1 + ' - ' + 254 +'].');
F.dmz_src_ip_3.focus();
return false;
}
if(F.dmz_src_ip_4.value == "" || F.dmz_src_ip_4.value == "0") 
{
alert(errmsg.err14 + '['+ 1 + ' - ' + 254 +'].');
F.dmz_src_ip_4.focus();
return false;
}
if(parseInt(F.dmz_src_ip_3.value) > parseInt(F.dmz_src_ip_4.value)) {
alert(errmsg.err51);
F.dmz_src_ip_4.focus();
return false;
}
}
if(F.dmz_dst_ip[0].checked == true){
if(F.dmz_ipaddr.value == "0" || F.dmz_ipaddr.value == "") {
alert(errmsg.err14 + '['+ 1 + ' - ' + 254 +'].');
F.dmz_ipaddr.focus();
return false;
}
if(tip==F.dmz_ipaddr.value || brcastip==F.dmz_ipaddr.value || netid==F.dmz_ipaddr.value)
{
alert(errmsg.err80);
F.dmz_ipaddr.focus();
return false;
}
if(parseInt(F.dmz_ipaddr.value) < parseInt(netid) 
|| parseInt(F.dmz_ipaddr.value) > parseInt(brcastip)) 
{
alert(errmsg.err49);
F.dmz_ipaddr.focus();
return false;
}
}
else {
if(F.dmz_mac.value == "00:00:00:00:00:00" || F.dmz_mac.value == "FF:FF:FF:FF:FF:FF") {
alert(errmsg.err50);
F.dmz_mac.focus();
return false;
}
}
}
return true;
}
function to_submit(F)
{
/*Wenxuan add edge need*/
var userAgent = navigator.userAgent;
var isEdge = userAgent.indexOf("Edge") > -1;
if(isEdge)
{
if(!valid_range2(F.dmz_src_ip_0,1,223,'IP') || !valid_range2(F.dmz_src_ip_1,0,255,'IP') || !valid_range2(F.dmz_src_ip_2,0,255,'IP') || !valid_range2(F.dmz_src_ip_3,1,254,'IP') || !valid_range2(F.dmz_src_ip_4,1,254,'IP') || !valid_range2(F.dmz_ipaddr,1,254,'IP') || valid_macs_17(F.dmz_mac) == false)
return;
}
/*Wenxuan add edge need*/
if(valid_value(F)) {
if(F._dmz_enable.checked == true)
F.dmz_enable.value = "1";
else
F.dmz_enable.value = "0";
F.submit_button.value = "DMZ";
F.gui_action.value = "Apply";
ajaxSubmit(0,"false");
}
}
function dmz_enable_disable(F,I)
{
EN_DIS1 = I;
if (F._dmz_enable.checked == false  ){
choose_disable(F.dmz_src_any[0]);
choose_disable(F.dmz_src_any[1]);
SelSrc(F,1);
choose_disable(F.dmz_dst_ip[0]);
choose_disable(F.dmz_dst_ip[1]);
choose_disable(F.dmz_ipaddr);
choose_disable(F.dmz_mac);
choose_disable(F.dhcp_table);
}
else{
choose_enable(F.dmz_src_any[0]);
choose_enable(F.dmz_src_any[1]);
if(F.dmz_src_any[0].checked == true)
SelSrc(F,1);
else
SelSrc(F,0);
choose_enable(F.dmz_dst_ip[0]);
choose_enable(F.dmz_dst_ip[1]);
if(F.dmz_dst_ip[0].checked == true)
SelDst(F,1);
else
SelDst(F,0);
if(F.dmz_dst_ip[1].checked == true)
choose_enable(F.dhcp_table);
else
choose_disable(F.dhcp_table);
}
}
function SelSrc(F,num)
{
if(num == 1) {
choose_disable(F.dmz_src_ip_0);
choose_disable(F.dmz_src_ip_1);
choose_disable(F.dmz_src_ip_2);
choose_disable(F.dmz_src_ip_3);
choose_disable(F.dmz_src_ip_4);
}
else {
choose_enable(F.dmz_src_ip_0);
choose_enable(F.dmz_src_ip_1);
choose_enable(F.dmz_src_ip_2);
choose_enable(F.dmz_src_ip_3);
choose_enable(F.dmz_src_ip_4);
}
}
function SelDst(F,num)
{
if(num == 1) {
choose_disable(F.dmz_mac);
choose_enable(F.dmz_ipaddr);
choose_disable(F.dhcp_table);
}
else {
choose_enable(F.dmz_mac);
choose_disable(F.dmz_ipaddr);
choose_enable(F.dhcp_table);
}
}
function SelDMZ(F,num)
{
dmz_enable_disable(F,num);
}
function valid_macs_all(I)
{
if(I.value == "")
return true;
else if(I.value.length == 12)
valid_macs_12(I);
else if(I.value.length == 17)
valid_macs_17(I);
else{
alert(errmsg.err5);
I.value = I.defaultValue;
}
}
function init() 
{               
dmz_enable_disable(document.dmz,'<% nvram_get("dmz_enable"); %>');
var swmode = '<% nvram_get("switch_mode");%>';
var protocolWan = '<% nvram_get("wan_proto");%>';
if( swmode == 1)
alert(share.brdgmwn);
else if( protocolWan == "dslite" ){
alert ("These features are not supported when the router is operating in DS-Lite Mode.");
}
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
</SCRIPT>
</HEAD>
<BODY onload="init()" onbeforeunload = "return checkFormChanged(document.dmz)">
<FORM name="dmz" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" value="DMZ" />
<input type="hidden" name="change_action" />
<input type="hidden" name="dmz_enable"/>
<input type="hidden" name="gui_action" value="Apply" />
<input type="hidden" name="wait_time" value="3" />
<% web_include_file("Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td>
<!--		<script>draw_radio('dmz_enable', share.enabled, '1', 'SelDMZ(this.form,1)' <% nvram_match("dmz_enable","1",", 0"); %>);</script>
<script>draw_radio('dmz_enable', share.disabled, '0', 'SelDMZ(this.form,0)' <% nvram_match("dmz_enable","0",", 0"); %>);</script>   -->
<script>draw_checkbox('_dmz_enable', share.dmz, '1', 'SelDMZ(this.form,1)' <% nvram_match("dmz_enable","1",", 1"); %>);</script>
</td>
</tr>
<tr>
<td colspan="2">
<hr class="table-title-underline">
</td>
</tr>
<tr>
<td><script>Capture(share.sourceip)</script></td>
<td>
<script>draw_radio('dmz_src_any', mgt.anyip, '1', 'SelSrc(this.form,1)' <% nvram_match("dmz_src_any","1",", 0"); %>);</script>
</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>
<script>draw_radio('dmz_src_any', '', '0', 'SelSrc(this.form,0)' <% nvram_match("dmz_src_any","0",", 0"); %>);</script>
<input type="text" class="num" maxLength="3" onBlur="valid_range2(this,1,223,'IP')" style="width:40px" value="<% get_single_ip("dmz_src_ip","0"); %>" name="dmz_src_ip_0" id="dmz_src_ip_0"/>&nbsp;.
<input type="text" class="num" maxLength="3" onBlur="valid_range2(this,0,255,'IP')" style="width:40px" value="<% get_single_ip("dmz_src_ip","1"); %>" name="dmz_src_ip_1" id="dmz_src_ip_1"/>&nbsp;.
<input type="text" class="num" maxLength="3" onBlur="valid_range2(this,0,255,'IP')" style="width:40px" value="<% get_single_ip("dmz_src_ip","2"); %>" name="dmz_src_ip_2" id="dmz_src_ip_2"/>&nbsp;.
<input type="text" class="num" maxLength="3" onBlur="valid_range2(this,1,254,'IP')" style="width:40px" value="<% get_single_ip("dmz_src_ip","3"); %>" name="dmz_src_ip_3" id="dmz_src_ip_3"/>&nbsp;<script>Capture(portforward.to)</script>
<input type="text" class="num" maxLength="3" onBlur="valid_range2(this,1,254,'IP')" style="width:40px" value="<% nvram_list("dmz_src_ip", "1"); %>" name="dmz_src_ip_4" id="dmz_src_ip_4"/>
</td>
</tr>
<tr>
<td colspan="2">
<hr class="table-title-underline">
</td>
</tr>
<tr>
<td><script>Capture(share.destination)</script></td>
<td>
<script>draw_radio('dmz_dst_ip', share.ipaddr, '1', 'SelDst(this.form,1)' <% nvram_match("dmz_dst_ip","1",", 0"); %>);</script>
<% prefix_ip_get("lan_ipaddr",1); %>&nbsp;<input type="text" class="num" maxLength="3" onBlur="valid_range2(this,1,254,'IP')" style="width:40px" value="<% nvram_get("dmz_ipaddr"); %>" name="dmz_ipaddr" id="dmz_ipaddr"/>
</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>
<script>draw_radio('dmz_dst_ip', share.macaddr, '0', 'SelDst(this.form,0)' <% nvram_match("dmz_dst_ip","0",", 0"); %>);</script>
<input type="text" class="num" maxLength="17" onBlur="valid_macs_17(this)" size="15" value="<% nvram_get("dmz_mac"); %>" name="dmz_mac" />
</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>
<script>draw_button("javascript:ViewDHCP()", stabutton.dhcpclitbl, 'dhcp_table')</script>
</td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
