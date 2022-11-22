<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<TITLE>Firmware Upgrade</TITLE>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/other.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/share.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capsetup.js"></SCRIPT>
<style>
.Bar,
.Bar div span{ width: 300px }
</style>
<SCRIPT language="javascript">
document.title = adtopmenu.upgarde;
var close_session = "<% get_session_status(); %>";
var session_key = "<% nvram_get("session_key"); %>";
var delay_time = 1450;
var num=0;
var width=0;
var automatic='<% nvram_get("upgrade_automatic");%>';
var last_fw="<% show_online_update_fw(); %>";
var up_fw_result='<% nvram_get("online_update_result"); %>';
var upgrade_status='<% nvram_get("upgrade_status");%>';
function progress(){
var per;
document.getElementById("left").bgColor="#999999";
if(num == 2){
clearTimeout(timerID);
alert(errmsg.err13);
return false;
}
per = Math.round((width*100)/296);
document.getElementById("left").style.width = per + "%";
document.getElementById("percent").innerHTML = per + "%";
if(per >= 93) {
delay_time = 8000;
}
if (per == 99){
width = 293;
}
else {
width += 8.88;
}
timerID = setTimeout('progress()', delay_time);
}
function stop(){
if(ie4)
document.all['style0'].style.visibility = 'hidden';
}
function upgrade(F){
var len = F.file.value.length;
var ext = new Array('.','b','i','n');
if (F.file.value == '')	{
alert(fwupgrade.upgradefile);
return false;
}
var IMAGE = F.file.value.toLowerCase();
for (i=0; i < 4; i++)	{
if (ext[i] != IMAGE.charAt(len-4+i)){
alert(hupgrade.wrimage);
return false;
}
}
if(ns4)
delay_time = 1450;
choose_disable(F.checkfw_button);	
choose_disable(F.upgrade_button);	
choose_disable(F.Upgrade_b);	
F.submit_button.value = "Upgrade";
F.submit();
showWait();
progress();
}
window.addEventListener("message", receiveMessage, false);
function receiveMessage(event)
{
location.href = event.data;
}
function safe_upgrade(F){
var lan_ip = "<% nvram_get("lan_ipaddr"); %>";
if(lan_ip != "192.168.1.1")
{
alert(fwupgrade.safeupmsg1);
return false;
}
if(confirm(fwupgrade.safeupmsg2) == false)
{
return false;
}
F.submit_button.value = "Upgrade";
F.gui_action.value = "Apply";
F.safe_mode_upgrade.value = "on";
F.submit();
return true;
}
function goto_checkfirmware()
{
var F=document.firmware;
if ( close_session == "1" )
F.action="apply.cgi";
else
F.action= "apply.cgi?session_id="+session_key;
F.submit_button.value = "upgrade_online"; 
F.submit_type.value="check_fw";
F.next_page.value="Upgrade.asp";
F.change_action.value = "gozila_cgi";
ajaxSubmit(2,"check");
}
function goto_upgradefirmware()
{
var F=document.firmware;
F.gui_action.value = "Apply";
choose_disable(F.checkfw_button);	
choose_disable(F.upgrade_button);	
choose_disable(F.Upgrade_b);	
if ( close_session == "1" )
{
F.action= "auto_upgrade.cgi";
}
else
{
F.action= "auto_upgrade.cgi?session_id="+session_key;
}
F.submit();
showWait();
progress();
}	
function online_firmware_ver()
{
if( last_fw == "Up to date")
document.write(wizardBasic.nofw);
else
document.write(last_fw);
}
function to_submit(F)
{
if(F.upgrade_automatic.checked == true)
F.upgrade_automatic.value = "1";
else	
F.upgrade_automatic.value = "0";
F.submit_button.value = "Upgrade_automatic";
if ( close_session == "1" )
F.action="apply.cgi";
else
F.action= "apply.cgi?session_id="+session_key;
F.submit_type.value = "";
F.change_action.value = "";
F.next_page.value = "";
F.gui_action.value = "Apply";
F.submit();
}
function init()
{
document.getElementById("percent").innerHTML = "0%";
var http_from = "<% nvram_get("http_from"); %>";
var remote_upgrade = "<% nvram_get("remote_upgrade"); %>";
var lang = "<%nvram_get("detect_lang");%>";
if(http_from == "wan" && (remote_upgrade == "0" || remote_upgrade == "")) {
choose_disable(document.firmware.Upgrade_b);
choose_disable(document.firmware.file);
choose_disable(document.firmware.checkfw_button);	
choose_disable(document.firmware.upgrade_button);	
}
if ( close_session == "1" )
{
document.forms[0].action= "upgrade.cgi";
}
else
{
document.forms[0].action= "upgrade.cgi?session_id="+session_key;
}
if(upgrade_status == "check_fw")
{
document.getElementById("upgrade_fw").style.display="";
document.getElementById("checkfw_button").style.display="";
if ((last_fw == "Up to date"))
document.getElementById("upgrade_button").style.display="none";
else
document.getElementById("upgrade_button").style.display="";
}
else if(upgrade_status == "upgrade_fw")
{
if (up_fw_result == "1")        
document.getElementById("checkfw_button").style.display="none";
else
document.getElementById("checkfw_button").style.display="";
document.getElementById("upgrade_fw").style.display="none";
}
else
document.getElementById("checkfw_button").style.display="";
update_checked(document.firmware.upgrade_automatic);
if(automatic == "1")
document.firmware.upgrade_automatic.checked = true;
else
document.firmware.upgrade_automatic.checked = false;
}
</script>
</HEAD>
<BODY onload="init()" onbeforeunload="return checkFormChanged(document.firmware)">^M
<iframe id="upload_frame" name="upload_frame" sandbox="allow-same-origin allow-scripts allow-popups allow-forms allow-top-navigation" src="" width="0" height="0" style="width:0;height:0;position:absolute;top:-9999px;left:-9999px;visibility:hidden"></iframe>
<FORM name="firmware" method="post" action="upgrade.cgi" encType="multipart/form-data" target="upload_frame">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="commit" value="1"/>
<input type="hidden" name="submit_type" />
<input type="hidden" name="next_page" />
<input type="hidden" name="upgrade_automatic">
<div style="display: none" id="PageHelpBody"><script>Capture(fwupgrade.helpmsg)</script></div>
<% web_include_file("Top.asp"); %>
<table class="table table-info">
<tbody>
<tr id="automitic_up" style="display:none">
<td>
<script>draw_checkbox('upgrade_automatic', 'Automatic', '0', '' <% nvram_match("upgrade_automatic","1",", 1"); %>);</script>
</td>
</tr>
<tr>
<td>
<script>Capture(wizardBasic.curfw)</script>:
<% nvram_get("fw_version"); %>	
</td>
<td>
<button type=button class="btn " onclick="javascript:goto_checkfirmware()" id=checkfw_button name=checkfw_button><script>Capture(wizardBasic.checkfw);</script></button>
</td>
</tr>
<tr id="upgrade_fw" style="display:none">
<td id=last_ver>
<script>online_firmware_ver();</script>
</td>
<td>
<button type=button class="btn " onclick="javascript:goto_upgradefirmware()" id=upgrade_button name=upgrade_button ><script>Capture(adbutton.upgrade);</script></button>
</td>
</tr>
<tr>
<td colspan="2">
<hr class="table-title-underline">
</td>
</tr>
<tr>
<td><script>Capture(fwupgrade.upgradefile)</script></td>
<td>
<input type="file" name="file" size="26" />
</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>
<script>draw_button("javascript:upgrade(this.form)", adbutton.startupgrade, 'Upgrade_b')</script>
</td>
</tr>
<tr>
<td colspan="2">
<hr class="table-title-underline">
</td>
</tr>
<tr>
<td colspan="2" class="error"><script>Capture(fwupgrade.warning)</script>&nbsp;<script>Capture(fwupgrade.warning2)</script></td>
</tr>
<tr>
<td colspan="2">
<div class="Bar"><div id="left" style="width: 0%;"><span id="percent">0%</span></div></div>
</td>
</tr>
<tr>
<td colspan="2" class="error" style="font-weight:700"><script>Capture(fwupgrade.notinterrupted)</script></td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
