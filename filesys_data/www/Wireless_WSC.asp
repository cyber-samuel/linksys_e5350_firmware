<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Basic Wireless Settings</TITLE>
<% no_cache(); %>
<% charset(); %> 
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
save:    true,
cancel:  true
});
re1 = /<br>/gi;
str = wlantopmenu.wsc.replace(re1," ");
document.title = str;
var close_session = "<% get_session_status(); %>";
var iTimerID = null;
var closeTimer = false ; 
var nwkey="<% nvram_get("wsc_nwkey"); %>";
var wscresult="<% nvram_get("wsc_result"); %>";
var width=0;
function ChangeWpsMode(F)
{
var wl_mac_filter = '<% nvram_get("wl_mac_filter"); %>';
var closed_5g = '<% nvram_get("closed_5g"); %>';
var closed_24g = '<% nvram_get("closed_24g"); %>';
var wl1_security_mode =	'<% nvram_get("wl1_security_mode"); %>' ;
var wl0_security_mode = '<% nvram_get("wl0_security_mode"); %>';
if( wl_mac_filter == 1 )
{
alert(wlanwscpopup.invalid);
F._wsc_mode.checked = false ;
}
if( wl1_security_mode == "wep" || wl0_security_mode == "wep")
{
alert(wlanwscpopup.invalid2);
F._wsc_mode.checked = false ;
}
if(wl1_security_mode == "wpa2_enterprise" && wl0_security_mode == "wpa2_enterprise")
{
alert(errmsg.err70);
F._wsc_mode.checked = false ;
}
return;
}
function nextpage()
{
F = document.wireless ;
all_obj(F,false,true);
F.submit_button.value = "Wireless_Basic";
F.submit_type.value ="wsc_method1";
F.change_action.value = "gozila_cgi";
F.next_page.value = "Wireless_WSC.asp";
F.wsc_result.value = "3";
ajaxSubmit(0,"false");	
}
function PushButton(F,I)
{
if(!document.wireless._wsc_mode.checked) return;
F.img_gif.style.visibility = "hidden" ;
nextpage();
}
function EnterPIN(F)
{
var pin_tmp = document.wireless.wsc_enrpin.value;
if(!document.wireless._wsc_mode.checked) return;
ch = pin_tmp.charAt(4);	
if((ch == '-' || ch == ' ')&& pin_tmp.length == 9 )
{
pin_tmp= pin_tmp.substring(0,4)+pin_tmp.substring(5);
document.wireless.wsc_enrpin.value = pin_tmp;
}
closeTimer = true ; 
if ( !isascii(document.wireless.wsc_enrpin,document.wireless.wsc_enrpin.value)) 
{
closeTimer = false ; 
return false ; 
}
if ( !check_space(document.wireless.wsc_enrpin,"PIN value")) 
{
closeTimer = false ; 
return false ; 
}
if (F.wsc_enrpin.value. length != 4) {
if ( !validChecksum(F.wsc_enrpin.value) || F.wsc_enrpin.value.length<8 || F.wsc_enrpin.value.length>8)
{
closeTimer = false ; 
alert(errmsg.err69);
return false ; 
}
}
all_obj(F,true,true);
F.submit_button.value = "Wireless_Basic";
F.submit_type.value ="wsc_method2";
F.change_action.value = "gozila_cgi";
F.wsc_enr_pin.disabled = "";
F.wsc_enr_pin.value = F.wsc_enrpin.value;
F.next_page.value = "Wireless_WSC.asp";
F.commit.value = "1";
ajaxSubmit(0,"false");
}
function AcceptConfig(F)
{
all_obj(F,false,true);
F.submit_button.value = "Wireless_Basic";
F.submit_type.value ="wsc_method3";
F.change_action.value = "gozila_cgi";
F.commit.value = "0";
F.submit();
}
function all_obj(F,I,DIS)
{
var flg ; 
if ( DIS==true && I==true )
flg = "hidden";
else
flg = "visible";
F.img_gif.disabled = DIS ; 
F.cmdreg.disabled = DIS ; 
F.wsc_enrpin.disabled = DIS; 
}
function reset_security(F)
{
all_obj(F,true,true);
F.submit_button.value = "Wireless_Basic";
F.submit_type.value ="wsc_reset";
F.change_action.value = "gozila_cgi";
F.commit.value="0";
F.submit();
}
function to_submit(F)
{
if(F._wsc_mode.checked == true)
F.wsc_mode.value = "0";
else	
F.wsc_mode.value = "1";
F.submit_button.value = "Wireless_WSC";
F.submit_type.value = "";
F.change_action.value = "";
F.next_page.value = "";
F.gui_action.value = "Apply";
F.wsc_enr_pin.disabled = "true";
F.wsc_result.disabled = "true";
F.wsc_security_mode.value = "1";
ajaxSubmit(20,"check");
}
function init()
{
var aprole, cmethod, wps_status ;
aprole = "<% nvram_get("wsc_ap_role"); %>";
cmethod = "<% nvram_get("wsc_config_method"); %>";
wps_status = "<% nvram_get("wps_mode"); %>";
document.wireless.pbutton.value = "0";
var bridge_mode = "<% nvram_get("wbridge_mode");%>";
if(bridge_mode == "1")
alert(wlanbridge.warn);
F = document.forms[0];
var closed_5g = '<% nvram_get("closed_5g"); %>';
var closed_24g = '<% nvram_get("closed_24g"); %>';
var wl1_security_mode = '<% nvram_get("wl1_security_mode"); %>' ;
var wl0_security_mode = '<% nvram_get("wl0_security_mode"); %>';
var net_mode_24g = '<% nvram_get("net_mode_24g"); %>';	
var net_mode_5g = '<% nvram_get("net_mode_5g"); %>';
if( (closed_5g == 1 && closed_24g == 1) || (net_mode_24g == 'disabled' && net_mode_5g == 'disabled') || (closed_5g == 1 && net_mode_24g == 'disabled') || (closed_24g == 1 && net_mode_5g == 'disabled') || (wl1_security_mode == "wpa2_enterprise" && (net_mode_24g == 'disabled' || closed_24g == 1)) || (wl0_security_mode == "wpa2_enterprise" && (net_mode_5g == 'disabled' || closed_5g == 1)) )
{
choose_disable(F._wsc_mode);
}
else
choose_enable(F._wsc_mode);
if ( wscresult == "4" ) 
{
if ( cmethod == "pbc" && aprole == "withReg")
{
all_obj(document.wireless,false,true);
}
else
all_obj(document.wireless,true,true);
document.wireless.img_gif.style.visibility = "hidden" ;
}
else
{
all_obj(document.wireless,true,false);
document.wireless.img_gif.style.visibility = "visible" ;
}
update_checked(document.wireless._wsc_mode);
if(wps_status == "enabled")
{
document.wireless._wsc_mode.checked = true;
}else{
document.wireless._wsc_mode.checked = false;
choose_disable(document.wireless.img_gif);
choose_disable(document.wireless.cmdreg);
choose_disable(document.wireless.wsc_enrpin);
}
WPS_STATUS_SHOW(wscresult);
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
function wn_reload()
{
window.clearTimeout(iTimerID);
window.location.replace("Wireless_WSC.asp");
}
function generatePIN(F) 
{
F.submit_button.value = "Wireless_WSC";
F.change_action.value = "gozila_cgi";
F.submit_type.value = "gen_ap_pin"; 
F.submit();
}
function SelMode(F)
{
if ( F.wsc_smode[1].checked == true ) return ; 
closeTimer = true ; 
F.submit_button.value = "Wireless_Basic";
F.submit_type.value = "Wireless_Config";
F.change_action.value = "gozila_cgi";
F.next_page.value = "Wireless_WSC.asp";
F.wsc_security_mode.value = "0" ; 
F.commit.value = "0" ; 
choose_disable(F.wsc_smode[1]);
choose_disable(F.wsc_smode[0]);
F.submit();	
}
function validChecksum(PIN)
{
var accum = 0;
accum += 3 * (parseInt(PIN / 10000000) % 10);
accum += 1 * (parseInt(PIN / 1000000) % 10);
accum += 3 * (parseInt(PIN / 100000) % 10);
accum += 1 * (parseInt(PIN / 10000) % 10);
accum += 3 * (parseInt(PIN / 1000) % 10);
accum += 1 * (parseInt(PIN / 100) % 10);
accum += 3 * (parseInt(PIN / 10) % 10);
accum += 1 * (parseInt(PIN / 1) % 10);
return (0 == (accum % 10));
}
function WPS_STATUS_SHOW(ws)
{
if ( ws == "3" || ws == "4" )
{
showPopout('wps_search_device.asp?session_id=<% nvram_get("session_key"); %>');	
return;
}
else
{
document.getElementById("layer1").style.display = "none";
document.getElementById("layer2").style.display = "none";
}
}
document.onkeydown = onInputKeydown;
function onInputKeydown(event)
{
if(typeof event == "undefined")
{
return handleKeyDown(window.event);
}
else 
{
return handleKeyDown(event);
}
}
function handleKeyDown(event)
{
if(event.keyCode == 13)
{
return EnterPIN(document.wireless);
}
return true;
}
</SCRIPT>
</HEAD>
<BODY onload="init()">
<FORM name="wireless"  method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="commit" />
<input type="hidden" name="pbutton" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="wsc_security_mode" />
<input type="hidden" name="wsc_enr_pin" />
<input type="hidden" name="change_action" />
<input type="hidden" name="next_page" />
<input type="hidden" name="wsc_result" />
<input type="hidden" name="wsc_guiresult" />
<input type="hidden" name="wsc_barwidth" />
<input type="hidden" name="wsc_mode">
<div class="DISABLE_FORM" id="layer1"></div>
<div id="layer2" class="STATUSFORM">
<iframe id="loadstatus" width="100%" height="100%" scrolling="no" frameborder="0"></iframe>
</div>
<% web_include_file("Top.asp"); %>
<div  >
<table  width="550px" height="150px" border="1"rules="none"cellspacing="15" bordercolor="#808080" cellpadding="100%">
<tbody>
<tr>
<td>&nbsp;&nbsp;</td>
<td valign="top"><img src="image/attention.png" style="margin-top:10px"/></td>
<td>&nbsp;&nbsp;</td>
<td width="90%">
<script>Capture(wlanwsc.warning)</script><br>
<script>Capture(wlanwsc.warning1)</script><br>
<script>Capture(wlanwsc.warning2)</script><br>
<script>Capture(wlanwsc.warning3)</script><br>
<script>Capture(wlanwsc.warning4)</script><br>
<script>Capture(wlanwsc.warning5)</script><br>				
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
<table >
<tbody>
<tr>
<td><!--
<script>draw_radio('wsc_mode', share.enabled, '0', 'ChangeWpsMode(this.form)' <% nvram_match("wps_mode","enabled",", 0"); %>);</script>
<script>draw_radio('wsc_mode', share.disabled, '1', 'ChangeWpsMode(this.form)' <% nvram_invmatch("wps_mode","enabled",", 0"); %>);</script>-->
<script>draw_checkbox('_wsc_mode', wlantopmenu.wps, '0', 'ChangeWpsMode(this.form)' <% nvram_match("wps_mode","enabled",", 1"); %>);</script>
</td>
</tr>
</tbody>
</table>
<br>
<br>
<div><script>Capture(share.push)</script></div>
<br>
<div style="margin-left:20px;" >
<table class="table table-info" >
<tbody>
<tr>
<td style="width:50%"> <script>Capture(wlanwsc.pushbutton)</script></td>
<td style= "text-align: center" >
<script>
var aprole , cmethod , wscresult ; 
wscresult = "<% nvram_get("wsc_result"); %>";
aprole = "<% nvram_get("wsc_ap_role"); %>";
cmethod = "<% nvram_get("wsc_config_method"); %>";
wps_status = "<% nvram_get("wps_mode"); %>";
if ((wps_status == "enabled") && ((aprole=="withReg" && cmethod =="pbc") || wscresult!="4"))
document.write('<img name="img_gif" border="0" src="image/WFA_WPS_Mark_Solo.gif" onMouseOver="this.src=\'image/WFA_WPS_Mark_Solo1.gif\'" onMouseOut="this.src=\'image/WFA_WPS_Mark_Solo.gif\'" style="cursor:pointer;" onclick="PushButton(document.wireless,this)" />');
else
document.write('<img name="img_gif" border="0" src="image/WFA_WPS_Mark_Solo.gif" style="filter:Alpha(Style=2)" />');
</script>
</td>
<td>
<script>
var wscresult = "<% nvram_get("wsc_result"); %>";
if ( wscresult == "1" ) Capture(other.success);
else if ( wscresult =="2") Capture(other.fail);
else if ( wscresult =="3") Capture(other.search+"...");
else if ( wscresult =="4") Capture(other.connect+"...");
</script>
</td>
</tr>
<tr>
</tr>
</tbody>
</table>
</div>	
<div><script>Capture(share.devicepin)</script></div>
<br>
<div style="margin-left:20px;">
<table class="table table-info" >
<tr>
<td style="width:50%">
<script>Capture(wlanwsc.enterPIN)</script>
<script>Capture(wlanwsc.enterPIN2)</script>
</td>
<td style= "text-align: center">
<input type="text" name="wsc_enrpin" size="11" />
<script>draw_button("javascript:EnterPIN(this.form)", wlanwsc.register, 'cmdreg')</script>
</td>
</tr>
</table>
</div>
<div><script>Capture(share.routerpin)</script></div>
<br>
<div style="margin-left:20px;">
<table class="table table-info" >
<tbody>
<tr>
</tr>
<tr>
<td style="width:50%">
<% support_match("CONFIG_WSCCMD", "y", "<!--"); %>
<script>Capture(wlanwsc.msg_PIN)</script>
<b><% nvram_get("wsc_device_pin"); %> </b>
<% support_match("CONFIG_WSCCMD", "y", "-->"); %>
<% support_match("CONFIG_WPS", "y", "<!--"); %>
<script>Capture(wlanwsc.msg_PIN)</script>
<b><% nvram_get("wsc_device_pin"); %></b>
<script>Capture(wlanwsc.msg_PIN2)</script>
<% support_match("CONFIG_WPS", "y", "-->"); %>
<% support_invmatch("WSC_WIFI_SUPPORT", "1", "<!--"); %>
<script>draw_button("javascript:AcceptConfig(this.form)", wlanwsc.gconfig, 'cmdconfig')</script>
<% support_invmatch("WSC_WIFI_SUPPORT", "1", "-->"); %>
</td>
<td style= "text-align: center"><% nvram_get("wsc_device_pin"); %></td>
</tr>
</tbody>
</table>
<!--
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(wlanwsc.wifistatus)</script></td>
<td>
<script>
(function(){
<% support_match("CONFIG_WSCCMD", "y", "/*"); %>
var wsc_state = "<% nvram_get("wsc_config_state"); %>";
<% support_match("CONFIG_WSCCMD", "y", "*/"); %>
<% support_match("CONFIG_WPS", "y", "/*"); %>
var wsc_state = "<% nvram_get("wl_wps_config_state"); %>";
<% support_match("CONFIG_WPS", "y", "*/"); %>
if ( wsc_state == "1") Capture(wlanwsc.config);
else Capture(wlanwsc.unconfig);
})();
</script>
</td>
</tr>
</tbody>
</table>
-->
<!-- 5GHZ Wireless Settings -->
</tbody>
</table>
</div>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
