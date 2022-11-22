<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Basic Wireless Settings</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
save:   true,
cancel:	true
});
re1 = /<br>/gi;
str = wlantopmenu.basicset.replace(re1," ");
document.title = str;
var close_session = "<% get_session_status(); %>";
var EN_DIS = '<% nvram_else_match("wl_net_mode","disabled","0","1"); %>';
var init_gmode;
var wl0_nbw = '<% nvram_get("wl0_nbw"); %>';
var wl1_nbw = '<% nvram_get("wl1_nbw"); %>';
var ac_support="<% get_ac_support(); %>"
function ses_enable_disable(F,I)
{
EN_DIS = I;
if( I == "0"){
choose_disable(F.B1);
choose_disable(F.B2);
}
else{
choose_enable(F.B1);
choose_enable(F.B2);
}
}
var ses = '<% get_ses_status(); %>';
function ses_status()
{
return ses;
}
function Reset_SES(F)
{
F.submit_button.value = "Wireless_Basic";
F.submit_type.value = "Reset_SES";
F.change_action.value = "gozila_cgi";
F.submit();
}
function Set_SES_Short_Push(F)
{
var wl_net_mode = '<% nvram_get("wl_net_mode"); %>';
var ses_enable = '<% nvram_get("ses_enable"); %>';
if(wl_net_mode == "disabled" || ses_enable == "0")
return ;
if (confirm(SW_SES_BTN.MSG2)) {
F.submit_button.value = "Wireless_Basic";
F.submit_type.value = "Set_SES_Short_Push";
F.change_action.value = "gozila_cgi";
F.next_page.value = "SES_Status.asp";
F.submit();
}
}
function Set_SES_Long_Push(F)
{
if (confirm(SW_SES_BTN.MSG3)) {
F.submit_button.value = "Wireless_Basic";
F.submit_type.value = "Set_SES_Long_Push";
F.change_action.value = "gozila_cgi";
F.next_page.value = "Wireless_Basic.asp";
F.submit();
}
}
function SelMode(F)
{
var smode = "<% nvram_get("wl0_security_mode"); %>", smode1 = "<% nvram_get("wl1_security_mode"); %>";
if ("<% nvram_get("wl_macmode"); %>" == "deny") {
alert(wlanwscpopup.invalid);
} else if (("<% nvram_get("wl0_security_mode"); %>" == "wep")||
("<% nvram_get("wl1_security_mode"); %>" == "wep")){
alert(wlanwscpopup.invalid2);
}
if (F.wsc_smode[0].checked == true) return ;
/*Jemmy fix alerting two same warn message when page switch ftom Manual to WSC 2010.6.21*/
if (( smode1 == "wpa_enterprise" || smode1 == "wpa2_enterprise" || smode1 == "radius" || smode == "wpa_wpa2_enterprise")&& 
( smode == "wpa_enterprise" || smode == "wpa2_enterprise" || smode == "radius" || smode == "wpa_wpa2_enterprise"))
{
alert(errmsg.err70);
}
else
F.wsc_security_mode.value = "1";
F.submit_button.value = "Wireless_Basic";
F.submit_type.value="Wireless_Config";
F.change_action.value = "gozila_cgi";
F.next_page.value = "Wireless_Basic.asp";
F.wsc_security_mode.value = "1";
choose_disable(F.wsc_smode[0]);
choose_disable(F.wsc_smode[1]);
F.commit.value="0";
F.submit();	
}
function DisableBroadcast_24G(F)
{
var wps_mode = "<% nvram_get("wps_mode"); %>";
var wl1_security_mode = "<% nvram_get("wl1_security_mode"); %>";
if (wps_mode == "enabled" && F._closed_24g.checked == false)
{
if(F._closed_5g.checked == false || wl1_security_mode == "wpa2_enterprise" || F.net_mode_5g.value == "disabled")
{
if(confirm(wlanwscpopup.disable)==false)
{
F._closed_24g.checked = true;
update_checked(F._closed_24g);
}
}
}
}
function DisableBroadcast_5G(F)
{
var wps_mode = "<% nvram_get("wps_mode"); %>";
var wl0_security_mode = "<% nvram_get("wl0_security_mode"); %>";
if (wps_mode == "enabled" && F._closed_5g.checked == false)
{
if(F._closed_24g.checked == false || wl0_security_mode == "wpa2_enterprise" || F.net_mode_24g.value == "disabled")
{
if(confirm(wlanwscpopup.disable)==false)
{
F._closed_5g.checked = true;
update_checked(F._closed_5g);
}
}
}
}
function createChannel1(F)
{
var wl1_country_code = '<% nvram_get("wl1_country_code"); %>';
var start = 0;
var len = 0;
var i = 0;
var lang_pack='<% get_lang(); %>';
if(wl1_country_code == "EU" || wl1_country_code == "UK" || wl1_country_code == "ME")
{
NAME1 = new Array("0", "36", "40", "44", "48");
if(lang_pack == "en" || lang_pack == "frc")	
STRING1 = new Array("Auto", "36 - 5.180GHz", "40 - 5.200GHz","44 - 5.220GHz", "48 - 5.240GHz");
else
STRING1 = new Array("Auto", "36 - 5,180GHz", "40 - 5,200GHz","44 - 5,220GHz", "48 - 5,240GHz");
start = 0;
len = NAME1.length;
}
else if (wl1_country_code == "US" || wl1_country_code == "AH" || wl1_country_code == "AU")
{
NAME1 = new Array("0", "36", "40", "44", "48", "149", "153", "157", "161", "165");
if(lang_pack == "en" || lang_pack == "frc")	
STRING1 = new Array("Auto", "36 - 5.180GHz", "40 - 5.200GHz","44 - 5.220GHz", "48 - 5.240GHz", "149 - 5.745GHz", "153 - 5.765GHz", "157 - 5.785GHz", "161 - 5.805GHz", "165 - 5.825GHz");
else
STRING1 = new Array("Auto", "36 - 5,180GHz", "40 - 5,200GHz","44 - 5,220GHz", "48 - 5,240GHz", "149 - 5,745GHz", "153 - 5,765GHz", "157 - 5,785GHz", "161 - 5,805GHz", "165 - 5,825GHz");
start = 0;
len = NAME1.length;
}
else
{
NAME1 = new Array("0", "36", "40", "44", "48", "149", "153", "157", "161", "165");
if(lang_pack == "en" || lang_pack == "frc")
STRING1 = new Array("Auto", "36 - 5.180GHz", "40 - 5.200GHz","44 - 5.220GHz", "48 - 5.240GHz", "149 - 5.745GHz", "153 - 5.765GHz", "157 - 5.785GHz", "161 - 5.805GHz", "165 - 5.825GHz");
else
STRING1 = new Array("Auto", "36 - 5,180GHz", "40 - 5,200GHz","44 - 5,220GHz", "48 - 5,240GHz", "149 - 5,745GHz", "153 - 5,765GHz", "157 - 5,785GHz", "161 - 5,805GHz", "161 - 5,825GHz");
start = 0;
len = NAME1.length;
}
F._wl1_channel.length = len;	
for(i=0;i<len;i++) 
{
F._wl1_channel[i] = new Option(STRING1[i+start]);
F._wl1_channel[i].value = NAME1[i+start];
}
update_selected(F._wl1_channel);
}
function createChannel0(F)
{
var max_channel = '<% get_wl_max_channel(); %>';
var start = 0;
var len = 0;
start = 0;
len = parseInt(max_channel)+1;
F._wl0_channel.length = len;
for(i=0;i<len;i++)
{
if (i == 0)
{
F._wl0_channel[0] = new Option(share.auto);
F._wl0_channel[0].value = 0;
}else
{	
var ch = start + i;
var CH = eval("wlansetup.ch"+i);
F._wl0_channel[i] = new Option(ch+" - "+CH);
F._wl0_channel[i].value = ch;
}
}
}
function UnableCheck(passForm)
{
if(passForm.net_mode_24g.value != 'disabled') //Not disabled
{
passForm.ssid_24g.disabled = false;
passForm._wl0_nbw.disabled = false;
update_selected(passForm._wl0_nbw);
passForm._wl0_channel.disabled = false;
update_selected(passForm._wl0_channel);
passForm._closed_24g.disabled = false;
update_checked(passForm._closed_24g);
}
if(passForm.net_mode_5g.value != 'disabled') //Not disabled
{
passForm.ssid_5g.disabled = false;
passForm._wl1_nbw.disabled = false;
update_selected(passForm._wl1_nbw);
passForm._wl1_channel.disabled = false;
update_selected(passForm._wl1_channel);
passForm._closed_5g.disabled = false;
update_checked(passForm._closed_5g);
}
if (passForm.net_mode_24g.value == 'mixed' || passForm.net_mode_24g.value == 'n-only')	{	//Mixed & N-only
passForm._wl0_nbw.disabled = false;
}
else {	// B-only & G-only & Disabled
passForm._wl0_nbw.disabled = true;
}
update_selected(passForm._wl0_nbw);
if (passForm.net_mode_5g.value == 'mixed' || passForm.net_mode_5g.value == 'n-only')     {       //Mixed & N-only
passForm._wl1_nbw.disabled = false;
}
else {  // A-only & Disabled
passForm._wl1_nbw.disabled = true;
}
update_selected(passForm._wl1_nbw);
/*	
if (passForm._wl0_nbw.selectedIndex =='0')	{
passForm._wl0_channel.disabled = false;
}
else if (passForm._wl0_nbw.selectedIndex =='1')	{
passForm._wl0_channel.disabled = false;
}
*/
/*
else	{
var ctrlsb = '<%nvram_get("wl0_nctrlsb");%>';
if (ctrlsb == 'none')	{
passForm._wl0_widechannel.disabled = false;
passForm._wl0_channel.disabled = true;
}
else	{
passForm._wl0_widechannel.disabled = false;
passForm._wl0_channel.disabled = false;
}
}
*/
/*
if (passForm._wl1_nbw.selectedIndex =='0')	{
passForm._wl1_channel.disabled = false;
}
else if (passForm._wl1_nbw.selectedIndex =='1')	{
passForm._wl1_channel.disabled = false;
}
*/
/*
else	{
var ctrlsb_1 = '<%nvram_get("wl1_nctrlsb");%>';
if (ctrlsb_1 == 'none')	{
passForm._wl1_widechannel.disabled = false;
passForm._wl1_channel.disabled = true;
}
else{
passForm._wl1_widechannel.disabled = false;
passForm._wl1_channel.disabled = false;
}
}
*/	
if(passForm.net_mode_24g.value == 'disabled') //Disabled
{
passForm.ssid_24g.disabled = true;
passForm._wl0_nbw.disabled = true;
update_selected(passForm._wl0_nbw);
passForm._wl0_channel.disabled = true;
update_selected(passForm._wl0_channel);
passForm._closed_24g.disabled = true;
update_checked(passForm._closed_24g);
}
if(passForm.net_mode_5g.value == 'disabled') //Disabled
{
passForm.ssid_5g.disabled = true;
passForm._wl1_nbw.disabled = true;
update_selected(passForm._wl1_nbw);
passForm._wl1_channel.disabled = true;
update_selected(passForm._wl1_channel);
passForm._closed_5g.disabled = true;
update_checked(passForm._closed_5g);
}
}
function ModeChange(passForm)
{
var security = "<% nvram_get("wl0_security_mode"); %>";
var security_0 = "<% nvram_get("security_mode_0"); %>";
var old_net_mode = "<% nvram_get("net_mode_24g"); %>";
var wl1_security_mode = "<% nvram_get("wl1_security_mode"); %>";
var wps_mode = "<% nvram_get("wps_mode"); %>";	
/*Jemmy add warn message for swicth to mixed mode when security select wep/wpa_personal/wpa_enterprise 2009.8.12*/
if ((passForm.net_mode_24g.value == "mixed") && (security == "wep" || security == "wpa_personal" || security == "wpa_enterprise"))
{
if (confirm(errmsg.mixedmodesecurity) == false)
{
passForm.net_mode_24g.value = "<% nvram_get("net_mode_24g"); %>";
}
}
/*Jemmy add warn message when wireless switch from other modes to n-only if security mode is not disabled/wpa2-personal 2009.12.10*/
if ((passForm.net_mode_24g.value == "n-only") && (old_net_mode != "n-only"))
{
if (security_0 != "disabled" && security_0 != "psk2" && security_0 != "wpa2")
{
if (confirm(errmsg.nonly) == false)
{
passForm.net_mode_24g.value = old_net_mode;
}		
}		
}
if(passForm.net_mode_24g.value != 'disabled') //Not disabled
{
passForm.ssid_24g.disabled = false;
passForm._wl0_nbw.disabled = false;
update_selected(passForm._wl0_nbw);
passForm._wl0_channel.disabled = false;
update_selected(passForm._wl0_channel);
passForm._closed_24g.disabled = false;
update_checked(passForm._closed_24g);
}
if (passForm.net_mode_24g.value == 'mixed' || passForm.net_mode_24g.value == 'n-only')	{	//Mixed & N-only
passForm._wl0_nbw.disabled = false;
}
else {	// B-only & G-only & Disabled
passForm._wl0_nbw.disabled = true;
passForm._wl0_nbw.value = '20'; 	
}
update_selected(passForm._wl0_nbw);
BandWidthChange(passForm);
if(passForm.net_mode_24g.value == 'disabled') //Disabled
{
passForm.ssid_24g.disabled = true;
passForm._wl0_nbw.disabled = true;
update_selected(passForm._wl0_nbw);
passForm._wl0_channel.disabled = true;
update_selected(passForm._wl0_channel);
passForm._closed_24g.disabled = true;
update_checked(passForm._closed_24g);
if((passForm._closed_5g.checked == false || wl1_security_mode == "wpa2_enterprise" || passForm.net_mode_5g.value == 'disabled') && wps_mode == "enabled" && passForm._closed_24g.checked != false)
{
if(confirm(wlanwscpopup.disable)==false)
{       
passForm.net_mode_24g.value = '<% nvram_get("net_mode_24g"); %>';
if(passForm.net_mode_24g.value != 'disabled')
ModeChange(passForm);
else{
passForm.ssid_24g.disabled = true;
passForm._wl0_nbw.disabled = true;
update_selected(passForm._wl0_nbw);
passForm._wl0_channel.disabled = true;
update_selected(passForm._wl0_channel);
passForm._closed_24g.disabled = true;
update_checked(passForm._closed_24g);
}
}
}
}
}
function ModeChange1(passForm)
{
var security = "<% nvram_get("wl1_security_mode"); %>";
var security_1 = "<% nvram_get("security_mode_1"); %>";
var old_net_mode = "<% nvram_get("net_mode_5g"); %>";
var wl1_country_code = '<% nvram_get("wl1_country_code"); %>';
var wps_mode = "<% nvram_get("wps_mode"); %>";
var wl0_security_mode = "<% nvram_get("wl0_security_mode"); %>";
/*Jemmy add warn message for swicth to mixed mode when security select wep/wpa_personal/wpa_enterprise 2009.8.12*/
if ((passForm.net_mode_5g.value == "mixed") && (security == "wep" || security == "wpa_personal" || security == "wpa_enterprise"))
{
if (confirm(errmsg.mixed5g) == false)
{
passForm.net_mode_5g.value = "<% nvram_get("net_mode_5g"); %>";
}
}
/*Jemmy add warn message when wireless switch from other modes to n-only if security mode is not disabled/wpa2-personal 2009.12.10*/
if ((passForm.net_mode_5g.value == "n-only") && (old_net_mode != "n-only"))
{
if (security_1 != "disabled" && security_1 != "psk2" && security_1 != "wpa2")
{
if (confirm(errmsg.nonly) == false)
{
passForm.net_mode_5g.value = old_net_mode;
}		
}		
}
if(passForm.net_mode_5g.value != 'disabled') //Not disabled
{
passForm.ssid_5g.disabled = false;
passForm._wl1_nbw.disabled = false;
update_selected(passForm._wl1_nbw);
passForm._wl1_channel.disabled = false;
update_selected(passForm._wl1_channel);
passForm._closed_5g.disabled = false;
update_checked(passForm._closed_5g);
}
if (passForm.net_mode_5g.value == 'mixed' || passForm.net_mode_5g.value == 'n-only')     {       //Mixed & N-only
passForm._wl1_nbw.disabled = false;
}
else {  // A-only & Disabled
passForm._wl1_nbw.disabled = true;
passForm._wl1_nbw.value = '20';  
}
update_selected(passForm._wl1_nbw);
BandWidthChange1(passForm);
if(passForm.net_mode_5g.value == 'disabled') //Disabled
{
passForm.ssid_5g.disabled = true;
passForm._wl1_nbw.disabled = true;
update_selected(passForm._wl1_nbw);
passForm._wl1_channel.disabled = true;
update_selected(passForm._wl1_channel);
passForm._closed_5g.disabled = true;
update_checked(passForm._closed_5g);
if((passForm._closed_24g.checked == false || wl0_security_mode == "wpa2_enterprise" || passForm.net_mode_24g.value == 'disabled') && wps_mode == "enabled" && passForm._closed_5g.checked != false)
{
if(confirm(wlanwscpopup.disable)==false)
{
passForm.net_mode_5g.value = '<% nvram_get("net_mode_5g"); %>';
if(passForm.net_mode_5g.value != 'disabled')
ModeChange1(passForm);
else
{
passForm.ssid_5g.disabled = true;
passForm._wl1_nbw.disabled = true;
update_selected(passForm._wl1_nbw);
passForm._wl1_channel.disabled = true;
update_selected(passForm._wl1_channel);
passForm._closed_5g.disabled = true;
update_checked(passForm._closed_5g);
}
}
}
}
}
function BandWidthChange(passForm)
{
passForm._wl0_channel.disabled = false;
update_selected(passForm._wl0_channel);
/*createChannel0(passForm._wl0_widechannel.selectedIndex, passForm);*/
/*
if (passForm._wl0_nbw.selectedIndex =='0')	{
passForm._wl0_channel.disabled = false;
}
else if (passForm._wl0_nbw.selectedIndex =='1')	{
passForm._wl0_channel.disabled = false;
}
else	{
passForm._wl0_channel.disabled = true;
}
*/
}
function wl1Change1(passForm)
{
var wl1_country_code = '<% nvram_get("wl1_country_code"); %>';
if(wl1_country_code == "AH" || wl1_country_code == "US" || wl1_country_code == "AU" || wl1_country_code == "CA")
{
if(passForm._wl1_channel.value == "165")
{
document.getElementById("_wl1_nbw").options[2] = null;
document.getElementById("_wl1_nbw").options[0] = null;
}
else if(passForm._wl1_nbw.length < 2)
{
document.getElementById("_wl1_nbw").add(new Option(wlansetup.onlyauto,"0"),0);
document.getElementById("_wl1_nbw").add(new Option(wlansetup.wide40,"40"));
}
}
}
function BandWidthChange1(passForm)
{
/*createChannel1(passForm._wl1_widechannel.selectedIndex, passForm);*/
passForm._wl1_channel.disabled = false;
var wl1_country_code = '<% nvram_get("wl1_country_code"); %>';
/*
if (passForm._wl1_nbw.selectedIndex =='0')	{
passForm._wl1_channel.disabled = false;
}
else if (passForm._wl1_nbw.selectedIndex =='1')	{
passForm._wl1_channel.disabled = false;
}
else	{
passForm._wl1_channel.disabled = true;
}
*/
if(wl1_country_code == "US" || wl1_country_code == "AH" || wl1_country_code == "AU" || wl1_country_code == "CA")
{
if(passForm._wl1_nbw.value == '0' || passForm._wl1_nbw.value == '40')
{
document.getElementById("_wl1_channel").options[9] = null;
}
else if(passForm._wl1_channel.length < 10)
{
document.getElementById("_wl1_channel").add(new Option("165 - 5.825GHz","165"));
}
}
}
function InitValue(passForm)
{
var wl1_country_code = '<% nvram_get("wl1_country_code"); %>';
var bridge_mode = "<% nvram_get("wbridge_mode");%>";
if(bridge_mode == "1")
alert(wlanbridge.warn);
createChannel0(passForm);
BandWidthChange1(passForm);
wl1Change1(passForm);
UnableCheck(passForm);
var ctrlsb = '<%nvram_get("wl0_nctrlsb");%>';
var ch = '<%nvram_get("wl0_channel");%>';
passForm._wl0_channel.selectedIndex = ch;
update_selected(passForm._wl0_channel);
var ctrlsb_1 = '<%nvram_get("wl1_nctrlsb");%>';
var ch_1 = '<%nvram_get("wl1_channel");%>';
update_selected(passForm._wl1_channel);
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
function to_submit(F)
{
var gn_enable = '<% nvram_get("gn_enable"); %>';
if(F.ssid_5g.value == ""){
alert(errmsg2.err2);
F.ssid_5g.focus();
return;
}
if((gn_enable == '1') &&  (F.ssid_5g.value == F.guest_ssid.value)){
alert(gn.err3);
F.ssid_5g.focus();
return;
}
if(F.ssid_24g.value == ""){
alert(errmsg2.err2);
F.ssid_24g.focus();
return;
}
if((gn_enable == '1') &&  (F.ssid_24g.value == F.guest_ssid.value)){
alert(gn.err4);
F.ssid_24g.focus();
return;
}
F.channel_5g.value = F._wl1_channel.value;
F.nbw_5g.value	= F._wl1_nbw.value;  
F.channel_24g.value = F._wl0_channel.value;
F.nbw_24g.value	= F._wl0_nbw.value;   
/*	   
if (F._wl0_channel.selectedIndex == '0')
{	
if (F._wl0_widechannel.selectedIndex == '0')
F.wl0_nctrlsb.value = 'none';
else
F.wl0_nctrlsb.value = 'lower';
}
else
F.wl0_nctrlsb.value = 'upper';
if (F._wl1_channel.selectedIndex == '0')
{	
if (F._wl1_widechannel.selectedIndex == '0')
F.wl1_nctrlsb.value = 'none';
else
F.wl1_nctrlsb.value = 'lower';
}
else
F.wl1_nctrlsb.value = 'upper';
*/
/*channel 1,2,3,4,7 is lower, channel 5,6,8,9,10,11,12,13 is upper*/
if(F._closed_5g.checked == true)	F.closed_5g.value = "0";
else					F.closed_5g.value = "1";
if(F._closed_24g.checked == true)       F.closed_24g.value = "0";
else                                    F.closed_24g.value = "1";
if (F._wl0_channel.selectedIndex == '0')
F.wl0_nctrlsb.value = 'none';
else if (F._wl0_channel.selectedIndex > '4' && F._wl0_channel.selectedIndex != '7')
F.wl0_nctrlsb.value = 'upper';
else
F.wl0_nctrlsb.value = 'lower';
/*channel 36,44,149,157 is lower, channel 40, 48,151,161 is upper*/
if (F._wl1_channel.selectedIndex == '0')
F.wl1_nctrlsb.value = 'none';
else if ( (F._wl1_channel.selectedIndex == '1' ) ||
(F._wl1_channel.selectedIndex == '3' ) ||
(F._wl1_channel.selectedIndex == '5' ) ||
(F._wl1_channel.selectedIndex == '7' ) )
F.wl1_nctrlsb.value = 'lower';
else
F.wl1_nctrlsb.value = 'upper';
F.submit_button.value = "Wireless_Basic";
F.gui_action.value = "Apply";
F.commit.value="1";
ajaxSubmit(12,"false");
}
</SCRIPT>
</HEAD>
<BODY onload="InitValue(document.wireless)" onbeforeunload = "return checkFormChanged(document.wireless)">
<FORM name="wireless" onSubmit="return false;" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" value="Wireless_Basic" />
<input type="hidden" name="gui_action" value="Apply" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="change_action" />
<input type="hidden" name="next_page" />
<input type="hidden" name="commit" />
<input type="hidden" name="wl0_nctrlsb" />
<input type="hidden" name="wl1_nctrlsb" />
<input type="hidden" name="channel_5g" />
<input type="hidden" name="channel_24g" />
<input type="hidden" name="closed_24g" />
<input type="hidden" name="closed_5g" />
<input type="hidden" name="nbw_5g" />
<input type="hidden" name="nbw_24g" />
<input type="hidden" name="wait_time" value="3" />
<input type="hidden" name="guest_ssid" value="<% nvram_get("wl0.1_ssid"); %>" />
<input type="hidden" name="wsc_security_mode" />
<% web_include_file("Top.asp"); %>
<script>draw_table(MAINFUN2,wlansetup.hgmenu);</script>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(wlansetup.networkmode)</script></td>
<td>
<script>
(function(){
var str;
var val;
/*if (ac_support == '1')
{
str = [wlansetup.mixed, wlansetup.acmixed, wlansetup.aonly, wlansetup.nonly, share.disabled],
val = ['mixed', 'ac-mixed', 'a-only', 'n-only', 'disabled'];
}
else
{
str = [wlansetup.mixed, wlansetup.aonly, wlansetup.nonly, share.disabled],
val = ['mixed', 'a-only', 'n-only', 'disabled'];
}*/
str = [wlansetup.mixed, wlansetup.aonly, wlansetup.nonly, share.disabled],
val = ['mixed', 'a-only', 'n-only', 'disabled'];
draw_select('net_mode_5g', str, val, 'ModeChange1(this.form)', '<% nvram_get("net_mode_5g"); %>');
})();
</script>
</td>
</tr>
<tr>
<td><script>Capture(wlansetup.ssid)</script></td>
<td>
<input type="text" maxLength="32" value="<% nvram_get("ssid_5g"); %>" name="ssid_5g" size="17"  onBlur="valid_name(this,'SSID')" />
</td>
</tr>
<tr>
<td><script>Capture(wlansetup.radioband)</script></td>
<td>
<script>
(function(){
var str;
var val;
str = [wlansetup.onlyauto, wlansetup.standard20, wlansetup.wide40],
val = ['0', '20', '40'];
draw_select('_wl1_nbw', str, val, 'BandWidthChange1(this.form)', wl1_nbw);
})();
</script>
</td>
</tr>
<!--
<tr>
<td><script>Capture(wlansetup.widechannel)</script></td>
<td>
<script>
(function(){
var str = ['Auto', '38', '46'],
val = ['0', '38', '46'];
var wl1_country_code = '<% nvram_get("wl1_country_code"); %>';
if(wl1_country_code == "EU" || wl1_country_code == "EU2" || wl1_country_code == "TR") {
}
else {
str.push('151');	str.push('159');
val.push('151');	val.push('159');
}
draw_select('_wl1_widechannel', str, val, 'ChChange1(document.forms[0])');
})();
</script>
</td>
</tr>
-->
<tr>
<td><script>Capture(wlansetup.channel)</script></td>
<td>
<script>
(function(){
var wl1_country_code = '<% nvram_get("wl1_country_code"); %>';
var lang_pack='<% get_lang(); %>';
if(wl1_country_code == "EU" || wl1_country_code == "UK" || wl1_country_code == "ME") {
if(lang_pack == "en" || lang_pack == "frc")
var str = [wlansetup.onlyauto, '36 - 5.180 ' + wlansetup.ghz, '40 - 5.200 ' + wlansetup.ghz,'44 - 5.220 ' + wlansetup.ghz, '48 - 5.240 ' + wlansetup.ghz];
else
var str = [wlansetup.onlyauto, '36 - 5,180 ' + wlansetup.ghz, '40 - 5,200 ' + wlansetup.ghz,'44 - 5,220 ' + wlansetup.ghz, '48 - 5,240 ' + wlansetup.ghz];
var val = ['0', '36', '40', '44', '48'];
}
else if (wl1_country_code == "US" || wl1_country_code == "AH" || wl1_country_code == "AU"){
if(lang_pack == "en" || lang_pack == "frc")
var str = [wlansetup.onlyauto, '36 - 5.180 ' + wlansetup.ghz, '40 - 5.200 ' + wlansetup.ghz,'44 - 5.220 ' + wlansetup.ghz, '48 - 5.240 ' + wlansetup.ghz, '149 - 5.745 ' + wlansetup.ghz, '153 - 5.765 ' + wlansetup.ghz, '157 - 5.785 ' + wlansetup.ghz, '161 - 5.805 ' + wlansetup.ghz, '165 - 5.825 ' + wlansetup.ghz];
else
var str = [wlansetup.onlyauto, '36 - 5,180 ' + wlansetup.ghz, '40 - 5,200 ' + wlansetup.ghz,'44 - 5,220 ' + wlansetup.ghz, '48 - 5,240 ' + wlansetup.ghz, '149 - 5,745 ' + wlansetup.ghz, '153 - 5,765 ' + wlansetup.ghz, '157 - 5,785 ' + wlansetup.ghz, '161 - 5,805 ' + wlansetup.ghz, '165 - 5,825 ' + wlansetup.ghz];
var val = ['0', '36', '40', '44', '48', '149', '153', '157', '161', '165'];
}
else{
if(lang_pack == "en" || lang_pack == "frc")
var str = [wlansetup.onlyauto, '36 - 5,180 ' + wlansetup.ghz, '40 - 5,200 ' + wlansetup.ghz,'44 - 5,220 ' + wlansetup.ghz, '48 - 5,240 ' + wlansetup.ghz, '149 - 5,745 ' + wlansetup.ghz, '153 - 5,765 ' + wlansetup.ghz, '157 - 5,785 ' + wlansetup.ghz, '161 - 5,805 ' + wlansetup.ghz, '165 - 5,825 ' + wlansetup.ghz];
else
var str = [wlansetup.onlyauto, '36 - 5,180 ' + wlansetup.ghz, '40 - 5,200 ' + wlansetup.ghz,'44 - 5,220 ' + wlansetup.ghz, '48 - 5,240 ' + wlansetup.ghz, '149 - 5,745 ' + wlansetup.ghz, '153 - 5,765 ' + wlansetup.ghz, '157 - 5,785 ' + wlansetup.ghz, '161 - 5,805 ' + wlansetup.ghz, '165 - 5,825 ' + wlansetup.ghz];
var val = ['0', '36', '40', '44', '48', '149', '153', '157', '161', '165'];
}
draw_select('_wl1_channel', str, val, 'wl1Change1(this.form)', '<% nvram_get("wl1_channel"); %>');
})();
</script>
</td>
</tr>
<tr>
<td>
<!--		<script>draw_radio('closed_5g', share.enabled, '0', '' <% nvram_match("closed_5g","0",", 0"); %>);</script>
<script>draw_radio('closed_5g', share.disabled, '1', 'DisableBroadcast_5G(this.form)' <% nvram_match("closed_5g","1",", 0"); %>);</script>   -->
<script>draw_checkbox('_closed_5g', wlansetup.ssidbroadcast, '0', 'DisableBroadcast_5G(this.form)' <% nvram_match("closed_5g","0",", 1"); %>);</script>
</td>
</tr>
</tbody>
</table>
<!-- wireless 5G setting over -->
<!-- 2.4G wireless setting -->
<script>draw_table(MAINFUN2,wlansetup.lgmenu);</script>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(wlansetup.networkmode)</script></td>
<td>
<script>
(function(){
var str = [wlansetup.mixed, wlansetup.bgmixed, wlansetup.bonly, wlansetup.gonly, wlansetup.nonly, share.disabled],
val = ['mixed', 'bg-mixed', 'b-only', 'g-only', 'n-only', 'disabled'];
draw_select('net_mode_24g', str, val, 'ModeChange(this.form)', '<% nvram_get("net_mode_24g"); %>');
})();
</script>
</td>
</tr>
<tr>
<td><script>Capture(wlansetup.ssid)</script></td>
<td>
<input type="text" maxLength="32" value="<% nvram_get("ssid_24g"); %>" name="ssid_24g" size="17"  onBlur="valid_name(this,'SSID')" />
</td>
</tr>
<tr>
<td><script>Capture(wlansetup.radioband)</script></td>
<td>
<script>
(function(){
var str = [wlansetup.onlyauto, wlansetup.standard20],
val = ['0', '20'];
draw_select('_wl0_nbw', str, val, 'BandWidthChange(this.form)', wl0_nbw);
})();
</script>
</td>
</tr>
<!--
<tr>
<td><script>Capture(wlansetup.widechannel)</script></td>
<td>
<script>
(function(){
var str = ['0', '3', '4', '5', '6', '7', '8', '9'],
val = ['0', '38', '46'];
var wl0_country_code = '<% nvram_get("wl0_country_code"); %>';
if(wl0_country_code == "EU")
{
str.push('10');	str.push('11');
val.push('10');	val.push('11');
}
draw_select('_wl0_widechannel', str, val, 'ChChange(document.forms[0])');
})();
</script>
</td>
</tr>
-->
<tr>
<td><script>Capture(wlansetup.channel)</script></td>
<td>
<script>draw_select('_wl0_channel')</script>
</td>
</tr>
<tr>
<td><!--
<script>draw_radio('closed_24g', share.enabled, '0', '' <% nvram_match("closed_24g","0",", 0"); %>);</script>
<script>draw_radio('closed_24g', share.disabled, '1', 'DisableBroadcast_24G(this.form)' <% nvram_match("closed_24g","1",", 0"); %>);</script>  -->
<script>draw_checkbox('_closed_24g', wlansetup.ssidbroadcast, '0', 'DisableBroadcast_24G(this.form)' <% nvram_match("closed_24g","0",", 1"); %>);</script>	
</td>
</tr>
<% support_invmatch("WL_STA_SUPPORT", "1", "<!--"); %>
<tr>
<td>SSID of associating AP</td>
<td>
<input type="text" maxLength="32" value="<% nvram_get("wl_ap_ssid"); %>" name="wl_ap_ssid" size="20"  onBlur="valid_name(this,'SSID')" />
</td>
</tr>
<tr>
<td>Default IP of associating AP</td>
<td>
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'IP')" style="width:40px" value="<% get_single_ip("wl_ap_ip","0"); %>" name="wl_ap_ip_0" />&nbsp;.
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'IP')" style="width:40px" value="<% get_single_ip("wl_ap_ip","1"); %>" name="wl_ap_ip_1" />&nbsp;.
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,255,'IP')" style="width:40px" value="<% get_single_ip("wl_ap_ip","2"); %>" name="wl_ap_ip_2" />&nbsp;.
<input type="text" class="num" maxLength="3" onBlur="valid_range(this,0,254,'IP')" style="width:40px" value="<% get_single_ip("wl_ap_ip","3"); %>" name="wl_ap_ip_3" />&nbsp;
</td>
</tr>
<% support_invmatch("WL_STA_SUPPORT", "1", "-->"); %>
<% support_invmatch("WL_WDS_SUPPORT", "1", "<!--"); %>
<tr>
<td>Mode</td>
<td>
<script>
(function(){
var str = ['Access Point', 'Wireless Bridge'],
val = ['ap', 'wds'];
draw_select('net_mode_24g', str, val, '', '<% nvram_get("wl_mode"); %>');
})();
</script>
</td>
</tr>
<tr>
<td>Bridge Restrict</td>
<td>
<script>
(function(){
var str = [share.enabled, share.disabled],
val = ['0', '1'];
draw_select('wl_lazywds', str, val, '', '<% nvram_get("wl_lazywds"); %>');
})();
</script>
</td>
</tr>
<tr>
<td>Remote Bridges</td>
<td>
<input type="hidden" name="wl_wds" value="4" />
<input type="text" maxLength="17" size="17" name="wl_wds0"  value="<% nvram_list("wl_wds", 0); %>" onblur="valid_macs_17(this)" /><br>&nbsp;
<input type="text" maxLength="17" size="17" name="wl_wds1"  value="<% nvram_list("wl_wds", 1); %>" onblur="valid_macs_17(this)" /><br>&nbsp;
<input type="text" maxLength="17" size="17" name="wl_wds2"  value="<% nvram_list("wl_wds", 2); %>" onblur="valid_macs_17(this)" /><br>&nbsp;
<input type="text" maxLength="17" size="17" name="wl_wds3"  value="<% nvram_list("wl_wds", 3); %>" onblur="valid_macs_17(this)" />
</td>
</tr>
<% support_invmatch("WL_WDS_SUPPORT", "1", "-->"); %>
<% support_invmatch("SES_BUTTON_SUPPORT", "1", "<!--"); %>
<tr>
<td colspan="2">
<input type="image" name="B2" src="image/SES-button-color.gif" onclick="Set_SES_Short_Push(this.form)" width="50" height="50" />
<br />
<b><script>Capture(bmenu.statu)</script>: </b><script>document.write(SW_SES_BTN.<% get_ses_status(); %>)</script>
</td>
</tr>
<tr>
<td colspan="2">
<script>draw_button("javascript:Set_SES_Long_Push(this.form)", SW_SES_BTN.RESET, 'B1')</script>
</td>
</tr>
<% support_invmatch("SES_BUTTON_SUPPORT", "1", "-->"); %>
<!--
<tr>
<td><script>Capture(wlanwsc.pin)</script></td>
<td><% nvram_get("wsc_device_pin"); %></td>
</tr>
-->
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
