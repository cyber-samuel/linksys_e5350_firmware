<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Wireless MAC Filter</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<style>
.table-responsive .table td{
border-width: 0;
}
</style>
<SCRIPT language="JavaScript">
setFormActions({
save:   true,
cancel: true
});
document.title = wlantopmenu.macfilter;
var close_session = "<% get_session_status(); %>";
var win_options = 'alwaysRaised,resizable,scrollbars,width=660,height=460' ;
var active_win = null;
var wl_filter_win = null;
var EN_DIS =  '<% nvram_get("wl_macmode"); %>';
function check_duplicated_MAC(F)
{
for(var i=0;i<32;i++)
{
if(F.name != "m"+i)
{
if(F.value == eval("document.wireless.m" + i + ".value") && F.value != "00:00:00:00:00:00" && eval("document.wireless.m" + i + ".value") != "00:00:00:00:00:00") 
{
alert(errmsg.err52);
F.value = "00:00:00:00:00:00";
return false;
}
}
}
return true;
}
function closeWin(win_var)
{
if ( ((win_var != null) && (win_var.close)) || ((win_var != null) && (win_var.closed==false)) )
win_var.close();
}
function ViewClient()
{	
if( close_session == "1" )
showPopout('WL_ClientList.asp');
else
showPopout('WL_ClientList.asp?session_id=<% nvram_get("session_key"); %>');
return;
if ( close_session == "1" )
{
active_win = self.open('WL_ClientList.asp','ClientTable','alwaysRaised,resizable,scrollbars,width=780,height=370');
}
else
{
active_win = self.open('WL_ClientList.asp?session_id=<% nvram_get("session_key"); %>','ClientTable','alwaysRaised,resizable,scrollbars,width=780,height=370');
}
active_win.focus();
}
function to_submit(F)
{
/*Wenxuan add edge need*/
var userAgent = navigator.userAgent;
var isEdge = userAgent.indexOf("Edge") > -1;
if(isEdge)
{
for(var i=0;i<32;i++)
{
if(valid_macs_all(eval('F.m' + i)) == false)
return;	
for(j=i+1;j<32;j++)
{
if(eval('F.m' + i + '.value') == eval('F.m' + j + '.value') && eval('F.m' + i + '.value') != "00:00:00:00:00:00" && eval('F.m' + j + '.value') != "00:00:00:00:00:00")
{
alert(errmsg.err52);
F.value = "00:00:00:00:00:00";
return ;
}
}
}
}
/*Wenxuan add edge need*/
if(F._wl_mac_filter.checked == true) {
if(F.wl_macmode1[0].checked == true)
F.wl_macmode.value = "deny";
else
F.wl_macmode.value = "allow";
}
else
F.wl_macmode.value = "disabled";
if ( F._wl_mac_filter.checked == true ){
F.wl_mac_filter.value = "1";
}else {
F.wl_mac_filter.value = "0";
}
F.submit_button.value = "Wireless_MAC";
F.gui_action.value = "Apply";
ajaxSubmit(12,"false");	
}
function SelMac_init(num,F)
{
var start = '';
var end = '';
var total = F.elements.length;
for(i=0 ; i < total ; i++){
if(F.elements[i].name == "start")       start = i;
if(F.elements[i].name == "end")         end = i;
}
if(start == '' || end == '')    return true;
if(F._wl_mac_filter.checked == true){
for(i = start; i<=end ;i++)
choose_enable(F.elements[i]);}
else {
for(i = start; i<=end ;i++)
choose_disable(F.elements[i]);
}
}
function SelMac(num,F)
{
var start = '';
var end = '';
var total = F.elements.length;
for(i=0 ; i < total ; i++){
if(F.elements[i].name == "start")	start = i;
if(F.elements[i].name == "end")		end = i;
}
if(start == '' || end == '')	return true;
if(F._wl_mac_filter.checked == true){
if ("<% nvram_get("wl_macmode"); %>" == "disabled" )
if(confirm(wlanwscpopup.disable)==false)
{
F._wl_mac_filter.checked = false;
return;
}
for(i = start; i<=end ;i++)
choose_enable(F.elements[i]);}
else {
for(i = start; i<=end ;i++)
choose_disable(F.elements[i]);
}
}
function valid_macs_all(I)
{
if(I.value == "")
{
I.value = I.defaultValue;
return true;
}
else if(I.value.length == 12)
{
if(!valid_macs_12(I))
return false;
}	
else if(I.value.length == 17)
{
if(!valid_macs_17(I))
return false;
}
else{
alert(errmsg.err5);
I.value = I.defaultValue;
return false;
}
}
function exit()
{
closeWin(active_win);
}
function init()
{
var bridge_mode = "<% nvram_get("wbridge_mode");%>";
if(bridge_mode == "1")
alert(wlanbridge.warn);
var wl_active_add_mac = "<% nvram_get("wl_active_add_mac"); %>";
if(wl_active_add_mac == '1') {
document.wireless._wl_mac_filter.checked = true;
update_checked(document.wireless._wl_mac_filter);
SelMac_init('1',document.wireless);
}
else
SelMac_init('<% nvram_get("wl_mac_filter"); %>',document.wireless);
var close_session = "<% get_session_status(); %>";
if ( close_session == "1" )
{
document.forms[0].action= "apply.cgi";
}
else
{
document.forms[0].action= "apply.cgi?session_id=<% nvram_get("session_key"); %>";
}
if(wl_active_add_mac == '0')
{
setInitFormData(function(){
to_submit(document.forms[0])
});
}
}
</SCRIPT>
</HEAD>
<BODY onunload="exit()" onload="init()">
<FORM method="<% get_http_method(); %>" name="wireless" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="wl_macmode" />
<input type="hidden" name="wl_mac_filter" />
<input type="hidden" name="wl_maclist" value="32" />
<input type="hidden" name="wait_time" value="3" />
<% web_include_file("Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td colspan="2">
<script>draw_checkbox('_wl_mac_filter', wlantopmenu.macfilter, '1', "SelMac('1',this.form)" <% nvram_match("wl_mac_filter","1",",1"); %>);</script>
</td>
</tr>
<tr>
<td colspan="2">
<hr class="table-title-underline">
</td>
</tr>
<tr>
<td colspan="2">
<input type="hidden" name="start" />
<script>draw_radio('wl_macmode1', '', 'deny', '' <% nvram_invmatch("wl_macmode","allow",", 0"); %>);</script>
<b><script>Capture(wlanfilter.prevent)</script></b>
<script>Capture(wlanfilter.pclistbl)</script>
</td>
</tr>
<tr>
<td colspan="2">
<script>draw_radio('wl_macmode1', '', 'allow', '' <% nvram_match("wl_macmode","allow",", 0"); %>);</script>
<b><script>Capture(wlanfilter.permitonly)</script></b>
<script>Capture(wlanfilter.pclisttoaccbl)</script>
</td>
</tr>
</tbody>
</table>
<br /><br />
<script>draw_title_button(wlanfilter.macfilterlist, "javascript:ViewClient()", wlanbutton.clilist, 'list_button');</script>
<div class="table-responsive" style="border-width:0">
<table class="table" style="width:auto">
<tbody>
<script>
var i;
var num1;
var num2;
var wl_maclist = "<% nvram_get("wl_maclist"); %>";
var wl_activelist = "<% nvram_get("wl_active_mac"); %>";
var wl_active_add_mac = '<% nvram_get("wl_active_add_mac"); %>';
var mac1;
var mac2;
if(wl_active_add_mac == "1")
var MAC = wl_activelist.split(' ');
else
var MAC = wl_maclist.split(' ');
for(i=1;i<=16;i++) {
num1 = i;
num2 = parseInt(i)+16;
if(!MAC[(num1-1)])
mac1 = "00:00:00:00:00:00";
else
mac1 = MAC[(num1-1)];
if(!MAC[(num2-1)])
mac2 = "00:00:00:00:00:00";
else
mac2 = MAC[(num2-1)];
if(num1 < 10) { num1 = "0"+num1 };
document.write('<tr>');
document.write('<td>MAC ' + num1 + ':&nbsp;&nbsp;<input type="text" class="num" maxLength="17" onBlur="valid_macs_all(this);check_duplicated_MAC(this)" size="15" value="' + mac1 + '" name="m'+(num1-1)+'"/></td>');
document.write('<td>MAC ' + num2 + ':&nbsp;&nbsp;<input type="text" class="num" maxLength="17" onBlur="valid_macs_all(this);check_duplicated_MAC(this)" size="15" value="' + mac2 + '" name="m'+(num2-1)+'"/></td>');
document.write('</tr>');
}
<% wireless_init("reset_active_add_mac"); %>
</script>
</tbody>
</table>
<input type="hidden" name="end" />
</div>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
