<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Guest Access</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
save:    true,
cancel:	 true
});
document.title = newui.gacs;
var close_session = "<% get_session_status(); %>";
var win_options = 'alwaysRaised,resizable,scrollbars,width=660,height=460' ;
var active_win = null;
var wl_filter_win = null;
var EN_DIS =  '<% nvram_get("gn_enable"); %>';
var Bcast_Status =  '<% nvram_get("wl0.1_closed"); %>';
function closeWin(win_var)
{
if ( ((win_var != null) && (win_var.close)) || ((win_var != null) && (win_var.closed==false)) )
win_var.close();
}
function to_submit(F)
{
var switch_mode = "<% nvram_get("switch_mode");%>";
if(switch_mode == "1" && F.gn_enable.value == 1)
{
var match = "<% nvram_n_else_match("switch_ipaddr","192.168.33.","11","1","0");%>";
if(match == "1")
{
if(confirm(gn.err7))
{
F._gn_enable.checked = false;
F.gn_enable.value = 0;
F.gn_wanip_conflict.value = 1;
update_checked(F._gn_enable);
}
else
{
return;
}
}
}
if(F._bEnable.checked == true)
F.bEnable.value = "0";
else
F.bDisable.value = "1";
if(F._gn_enable.checked == true)	F.gn_enable.value = 1;
else					F.gn_enable.value = 0;
F.submit_button.value = "Guest_Access";
F.gui_action.value = "Apply";
ajaxSubmit(15,"false");
}
function SelGuestStatus(num,F)
{
if(F._gn_enable.checked == true)
{
F.gn_enable.value=1;
}
else
{
F.gn_enable.value=0;
}
}
function SelBroadcast(num,F)
{
if(F._bEnable.checked == false)
{
document.getElementById("gnbcast").value = 1;
update_checked(F._bEnable);
}
else
{
document.getElementById("gnbcast").value = 0;
update_checked(F._bEnable);
}
}
function SelTotalGuest(num,F)
{
document.wireless.gn_max_account.value =document.wireless.GuestTotal.value;
}
function exit()
{
closeWin(active_win);
}
function EditPassword(){
if(close_session == "1")
showPopout('GuestpasswordInput.asp');
else
showPopout('GuestpasswordInput.asp?session_id=<% nvram_get("session_key"); %>');
return;
if ( close_session == "1" )
{
ipmac_win = self.open('GuestpasswordInput.asp','GuestpasswordInput','alwaysRaised,resizable,scrollbars,width=700,height=400,top=50,left=50');
}
else
{
ipmac_win = self.open('GuestpasswordInput.asp?session_id=<% nvram_get("session_key"); %>','GuestpasswordInput','alwaysRaised,resizable,scrollbars,width=700,height=400,top=50,left=50');
}
ipmac_win.focus();
}
function Change_gn_password(password)
{
document.getElementById("gn_password").innerHTML = password;
document.wireless.gn_account_password.value = password;
}
function init()
{
document.wireless.GuestTotal.value='<% nvram_get("gn_max_account"); %>';
document.getElementById("gn_password").innerHTML = '<% nvram_get("gn_account_password"); %>';
document.wireless.gn_account_password.value = '<% nvram_get("gn_account_password"); %>';
document.wireless.gn_max_account.value =document.wireless.GuestTotal.value;
var bridge_mode = "<% nvram_get("wbridge_mode");%>";
if(bridge_mode == "1")
alert(wlanbridge.warn);
var switch_mode = "<% nvram_get("switch_mode");%>";
if(Bcast_Status == 0)		document.wireless._bEnable.checked = true;
else				document.wireless._bEnable.checked = false;
SelBroadcast(Bcast_Status,document.wireless);
if(switch_mode == "1")
{
var match = "<% nvram_n_else_match("switch_ipaddr","192.168.33.","11","1","0");%>";
if(match == "1" && '<%nvram_get("gn_wanip_conflict");%>' == '1')
{
choose_disable(document.wireless._gn_enable);
choose_disable(document.wireless.GuestTotal);
choose_disable(document.wireless._bEnable);
}
}
if('<% nvram_get("wk_mode"); %>' == "router")
{
choose_disable(document.wireless._gn_enable);
choose_disable(document.wireless.GuestTotal);
choose_disable(document.wireless._bEnable);
}
update_checked(document.wireless._bEnable);
update_selected(document.wireless.GuestTotal);
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
<BODY onunload="exit()" onload="init()" onbeforeunload = "return checkFormChanged(document.wireless)">
<FORM method="<% get_http_method(); %>" name="wireless" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="gn_max_account" />
<input type="hidden" name="gn_enable" />
<input type="hidden" name="bEnable" />
<input type="hidden" name="bDisable" />
<input type="hidden" name="gn_wanip_conflict" value="<%nvram_get("gn_wanip_conflict");%>" />
<input type="hidden" name="gn_account_password" />
<input type="hidden" name="wl0.1_closed" id="gnbcast" />
<% web_include_file("Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td colspan="2">
<b><script>Capture(newui.gninfo1)</script></b>
</td>
</tr>
<tr>
<td colspan="2">
<hr class="table-title-underline">
</td>
</tr>
<tr>
<td>
<script>draw_checkbox('_gn_enable', newui.alwga, '1', 'SelGuestStatus(1,this.form)' <% nvram_match("gn_enable","1",", 1"); %>);</script>
</td>
</tr>
<tr>
<td><script>Capture(newui.gnname)</script></td>
<td><% nvram_get("wl0.1_ssid"); %></td>
</tr>
<tr>
<td><script>Capture(newui.gusetpwd)</script></td>
<td>
<span id="gn_password"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<script>
draw_button("javascript:EditPassword()", newui.chg, 'change_button');
if('<% nvram_get("wk_mode"); %>' == "router")
choose_disable(document.wireless.change_button);
</script>
</td>
</tr>
<tr>
<td><script>Capture(newui.totalga)</script></td>
<td>
<script>
(function(){
var str = [],
val = [];
for( var i = 1 ; i <= 10 ; i++ )
{
str.push('' + i);
val.push('' + i);
}
draw_select('GuestTotal', str, val, 'SelTotalGuest(this.form.GuestTotal.selectedIndex,this.form)');
})();
</script>
</td>
</tr>
<tr>
<td>
<!--<script>draw_radio('bEnable', share.enabled, '0', 'SelBroadcast(0,this.form)');</script>
<script>draw_radio('bDisable', share.disabled, '1', 'SelBroadcast(1,this.form)');</script> -->
<script>draw_checkbox('_bEnable', wlansetup.ssidbroadcast, '0', 'SelBroadcast(0,this.form)');</script>
</td>
</tr>
<tr>
<td colspan="2">
<hr class="table-title-underline">
</td>
</tr>
<tr>
<td colspan="2">
<b><script>Capture(newui.gninfo2)</script></b>
</td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
