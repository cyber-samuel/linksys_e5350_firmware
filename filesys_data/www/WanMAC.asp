<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>MAC Address Clone</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
save:   true,
cancel: true
});
document.title = topmenu.macaddrclone;
var close_session = "<% get_session_status(); %>";
function to_submit(F)
{	
if(valid_macs_00(F))
{
if(F._mac_clone_enable.checked == true)
F.mac_clone_enable.value = "1" ;
else
F.mac_clone_enable.value = "0";
F.submit_button.value = "WanMAC";
F.gui_action.value = "Apply";
ajaxSubmit(35,"false");
}
}
function CloneMAC(F)
{
/*
F.submit_button.value = "WanMAC";
F.change_action.value = "gozila_cgi";
F.submit_type.value = "clone_mac";
F.gui_action.value = "Apply";
F.submit();
*/
var http_client_mac = '<% nvram_get("http_client_mac"); %>'
F.def_hwaddr_0.value = http_client_mac.substr(0, 2);
F.def_hwaddr_1.value = http_client_mac.substr(3, 2);
F.def_hwaddr_2.value = http_client_mac.substr(6, 2);
F.def_hwaddr_3.value = http_client_mac.substr(9, 2);
F.def_hwaddr_4.value = http_client_mac.substr(12, 2);
F.def_hwaddr_5.value = http_client_mac.substr(15, 2);
}
function SelMac(num,F)
{
mac_enable_disable(F,num);
}
function mac_enable_disable(F,I)
{
var http_from = '<% nvram_get("http_from"); %>';
EN_DIS3 = I;
if ( !F._mac_clone_enable.checked == true ){
choose_disable(F.def_hwaddr);
choose_disable(F.def_hwaddr_0);
choose_disable(F.def_hwaddr_1);
choose_disable(F.def_hwaddr_2);
choose_disable(F.def_hwaddr_3);
choose_disable(F.def_hwaddr_4);
choose_disable(F.def_hwaddr_5);
choose_disable(F.clone_b);
}
else{
choose_enable(F.def_hwaddr);
choose_enable(F.def_hwaddr_0);
choose_enable(F.def_hwaddr_1);
choose_enable(F.def_hwaddr_2);
choose_enable(F.def_hwaddr_3);
choose_enable(F.def_hwaddr_4);
choose_enable(F.def_hwaddr_5);
if(http_from=="lan")
choose_enable(F.clone_b);
else
choose_disable(F.clone_b);
}
}
function init() 
{               
var swmode = '<% nvram_get("switch_mode");%>';
if( swmode == 1)
alert(share.brdgmwn);
var bridge_mode = "<% nvram_get("wbridge_mode");%>";
if(bridge_mode == "1")
alert(wlanbridge.warn);
mac_enable_disable(document.mac,'<% nvram_get("mac_clone_enable"); %>');
<% onload("MACClone", "document.mac._mac_clone_enable.checked = true; mac_enable_disable(document.mac,1);"); %>	
/*Jemmy Fix bug 21475:LAN clone PC's MAC address is not accessable from remote control 2009.12.30*/
if("<% nvram_get("http_from"); %>" == "wan") {
DISABLE_ALL(true,document.mac);
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
function valid_macs_00(F)
{
M1 = errmsg.err17;
if(F._mac_clone_enable.checked == false)	return true;
else if(F.def_hwaddr_0.value == 00 && F.def_hwaddr_1.value == 00 && F.def_hwaddr_2.value == 00 &&  F.def_hwaddr_3.value == 00 && F.def_hwaddr_4.value == 00 && F.def_hwaddr_5.value == 00)
{
F.def_hwaddr_0.value = F.def_hwaddr_0.defaultValue;
F.def_hwaddr_1.value = F.def_hwaddr_1.defaultValue;
F.def_hwaddr_2.value = F.def_hwaddr_2.defaultValue;
F.def_hwaddr_3.value = F.def_hwaddr_3.defaultValue;
F.def_hwaddr_4.value = F.def_hwaddr_4.defaultValue;
F.def_hwaddr_5.value = F.def_hwaddr_5.defaultValue;
alert(M1);
return false;
}
else
{
return true;
}
}
</SCRIPT>
</HEAD>
<BODY onload="init()">
<FORM name="mac" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="mac_clone_enable" />
<input type="hidden" name="wait_time" value="3" />
<% web_include_file("Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td colspan="2">
<!--	<script>draw_radio('mac_clone_enable', share.enabled, '1', 'SelMac(1,this.form)' <% nvram_match("mac_clone_enable","1",", 0"); %>);</script>
<script>draw_radio('mac_clone_enable', share.disabled, '0', 'SelMac(0,this.form)' <% nvram_match("mac_clone_enable","0",", 0"); %>);</script> 
--!>
<script>draw_checkbox('_mac_clone_enable', topmenu.macaddrclone, '1', 'SelMac(1,this.form)' <% nvram_match("mac_clone_enable","1",", 1"); %>);</script>	
</td>
</tr>
<tr>
<td colspan="2">
<hr class="table-title-underline">
</td>
</tr>
<tr>
<td><script>Capture(share.macaddr)</script></td>
<td>
<input type="hidden" name="def_hwaddr"  value="6">
<input type="text" name="def_hwaddr_0" value="<% get_clone_mac("0"); %>" style="width:40px" maxlength="2" onBlur="valid_mac(this,0)" class="num" /> :
<input type="text" name="def_hwaddr_1" value="<% get_clone_mac("1"); %>" style="width:40px" maxlength="2" onBlur="valid_mac(this,1)" class="num" /> :
<input type="text" name="def_hwaddr_2" value="<% get_clone_mac("2"); %>" style="width:40px" maxlength="2" onBlur="valid_mac(this,1)" class="num" /> :
<input type="text" name="def_hwaddr_3" value="<% get_clone_mac("3"); %>" style="width:40px" maxlength="2" onBlur="valid_mac(this,1)" class="num" /> :
<input type="text" name="def_hwaddr_4" value="<% get_clone_mac("4"); %>" style="width:40px" maxlength="2" onBlur="valid_mac(this,1)" class="num" /> :
<input type="text" name="def_hwaddr_5" value="<% get_clone_mac("5"); %>" style="width:40px" maxlength="2" onBlur="valid_mac(this,1)" class="num" />
</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>
<script>draw_button("javascript:CloneMAC(this.form)", macclone.clonepcmac, 'clone_b')</script>
</td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
