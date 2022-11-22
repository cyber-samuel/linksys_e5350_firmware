<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Gateway Function</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
save:   true,
cancel: true
});
document.title = adtopmenu.Gateway;
var close_session = "<% get_session_status(); %>";
function SelUPNP(num,F)
{
if(F._upnp_enable.checked == true) {
choose_enable(F._upnp_config);
choose_enable(F._upnp_internet_dis);
update_checked(F._upnp_enable);
}
else {
choose_disable(F._upnp_config);
choose_disable(F._upnp_internet_dis);
update_checked(F._upnp_enable);
}
}
function to_submit(F)
{
if(F._nf_alg_sip.checked == true) 	F.nf_alg_sip.value = "1";
else					F.nf_alg_sip.value = "0";
if(F._upnp_enable.checked == true)	F.upnpEnabled.value = 1;
else					F.upnpEnabled.value = 0;
if(F._upnp_config.checked == true)      F.upnp_config.value = 1;
else                                    F.upnp_config.value = 0;
if(F._upnp_internet_dis.checked == true)      F.upnp_internet_dis.value = 1;
else						F.upnp_internet_dis.value = 0;
F.gui_action.value='Apply';
F.submit_button.value = "Gwfunc";
ajaxSubmit(0,"false");
}
function init() 
{    
SelUPNP('<% nvram_get("upnpEnabled"); %>',document.gwfunc)
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
<BODY vLink="#b5b5e6" aLink="#ffffff" link="#b5b5e6" onload="init()" onbeforeunload = "return checkFormChanged(document.gwfunc)">
<FORM name="gwfunc" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="ctm404_enable" />
<input type="hidden" name="nf_alg_sip" />
<input type="hidden" name="upnpEnabled" />
<input type="hidden" name="upnp_config" />
<input type="hidden" name="upnp_internet_dis" />
<!--input type="hidden" name="tmsss_enabled"-->
<input type="hidden" name="wait_time" value="4" />
<input type="hidden" name="need_reboot" value="0" />
<% web_include_file("Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td>
<script>draw_checkbox('_nf_alg_sip', mgt.sipalg, '1', '' <% nvram_match("nf_alg_sip","1",", 1"); %>);</script>
</td> 
</tr>
<% support_invmatch("ALG_MODULE_SUPPORT", "1", "-->"); %>
</tbody>
</table>
<script>draw_table(MAINFUN2,mgt.upnp);</script>
<table class="table table-info">
<tbody>
<tr>
<td>
<script>draw_checkbox('_upnp_enable', mgt.upnp, '1', 'SelUPNP(1,this.form)' <% nvram_match("upnpEnabled","1",", 1"); %>);</script>		
</td>
</tr>
<tr>
<td>
<script>draw_checkbox('_upnp_config', mgt.upnpconfig, '1', '' <% nvram_match("upnp_config","1",", 1"); %>);</script>
</td>
</tr>
<tr>
<td>
<script>draw_checkbox('_upnp_internet_dis', mgt.upnpinternetdis, '1', '' <% nvram_match("upnp_internet_dis","1",", 1"); %>);</script>
</td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
