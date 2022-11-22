<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Wireless Beamforming</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language=JavaScript>
setFormActions({
save:   true,
cancel: true
});
document.title = wlantopmenu.beamforming;
var close_session = "<% get_session_status(); %>";
function to_submit(F)
{
if(F._wl_beamforming.checked == true)	F.wl_beamforming.value = 1;
else					F.wl_beamforming.value = 0;
F.submit_button.value = "WL_Beamforming";
F.gui_action.value = "Apply";
ajaxSubmit(12,"false");
}
function init()
{	
var wbmode = '<% nvram_get("wbridge_mode");%>'; 
if (wbmode == 1)
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
})
}
</SCRIPT>
</HEAD>
<BODY onunload=exit() onload=init() onbeforeunload = "return checkFormChanged(document.wireless)">
<FORM method=<% get_http_method(); %> name=wireless action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=gui_action>
<input type=hidden name="wait_time" value="3">
<input type=hidden name=wl_beamforming>
<% web_include_file("Top.asp");%>
<table class="table table-info">
<tbody>
<tr>
<td>
<script>draw_checkbox('_wl_beamforming', wlantopmenu.beamforming, '1', '' <% nvram_match("wl_beamforming","1",", 1"); %>);</script>
</td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
