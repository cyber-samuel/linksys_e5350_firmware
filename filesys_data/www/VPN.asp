<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>VPN Passthrough</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
save:   true,
cancel: true
});
document.title = secleftmenu.vpnpass;
var close_session = "<% get_session_status(); %>";
function to_submit(F)
{
F.submit_button.value = "VPN";
if(F._ipsec_pass.checked == true) 
F.ipsec_pass.value = 1;
else {
F.ipsec_pass.value = 0;
}
if(F._pptp_pass.checked == true) 
F.pptp_pass.value = 1;
else {
F.pptp_pass.value = 0;
}
if(F._l2tp_pass.checked == true) 
F.l2tp_pass.value = 1;
else {
F.l2tp_pass.value = 0;
}
F.gui_action.value = "Apply";
ajaxSubmit(0,"false");
}
function init()
{
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
</SCRIPT>
</HEAD>
<BODY onload="init()" onbeforeunload = "return checkFormChanged(document.vpn)">
<FORM name="vpn" action="apply.cgi" method="<% get_http_method(); %>">
<input type="hidden" name="submit_button" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="ipsec_pass" />
<input type="hidden" name="pptp_pass" />
<input type="hidden" name="l2tp_pass" />
<input type="hidden" name="wait_time" value="3" />
<% web_include_file("Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td>
<script>draw_checkbox('_ipsec_pass', vpn.ipsecpass, 'on', '' <% nvram_match("ipsec_pass","1",", 1"); %>);</script>	
</td>
</tr>
<tr>
<td>
<script>draw_checkbox('_pptp_pass', vpn.pptppass, 'on', '' <% nvram_match("pptp_pass","1",", 1"); %>);</script>	
</td>
</tr>
<tr>
<td>
<script>draw_checkbox('_l2tp_pass', vpn.l2tppass, 'on', '' <% nvram_match("l2tp_pass","1",", 1"); %>);</script>	
</td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
