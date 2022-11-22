<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>>
<HEAD>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<SCRIPT language="Javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capsec.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/share.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/help.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capapp.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capasg.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capsetup.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capwrt54g.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capstatus.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/layout.js"></SCRIPT>
<SCRIPT language="javascript">
setFormActions({
'hndmsg.wtpBack': 'javascript:goto_back()',
'wiz.next': 'javascript:goto_next()',
'portsrv.cancel': 'javascript:goto_cancel()'
});
document.title = share.pwdcreate;
function set_parentvalue()
{
document.create_pwd.router_pwd.value=window.parent.document.getElementById("wizard_router_passwd").value;
}
function goto_back()
{
showWait();
var F = document.create_pwd;
if ( close_session == "1" )
document.location.replace("/wizard/set_wireless.asp");
else
document.location.replace("/wizard/set_wireless.asp?session_id="+session_key);
}
function goto_cancel()
{	
var F = document.create_pwd;
if (confirm(wiz.exitwarnmsg))
{
showWait();
F.submit_button.value = "setup_wizard";
F.submit_type.value="finish";
F.next_page.value="wizard/unfinished.asp";
F.change_action.value = "gozila_cgi";
F.submit(); 	
}
}
function goto_next()
{	
var F = document.create_pwd;
if(F.router_pwd.value.length > 63)
{
alert("The length of " + wiz.pwdrouter_pwd + " is max than 63"); 
F.router_pwd.focus();
return false;
}
if(!wz_valid_name(F.router_pwd, wiz.pwdrouter_pwd, SPACE_NO))
return false;
else if( F.router_pwd.value == "" ) 
{
alert(errmsg.err6);
return false;	
}
window.parent.document.getElementById("wizard_router_passwd").value = F.router_pwd.value;
showWait();
if ( close_session == "1" )
document.location.replace("/wizard/complete.asp");
else
document.location.replace("/wizard/complete.asp?session_id="+session_key);
}
</SCRIPT>
</HEAD>
<BODY onload="set_parentvalue();page_load();alignright('arRight')">
<form method="<% get_http_method(); %>" action="/apply.cgi" name="create_pwd">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="next_page" />
<% web_include_file("wizard/wizard_Top.asp"); %>
<div id="arRight">
<div class="wiz-content-title"><script>Capture(wiz.pwdrouter_pwd)</script></div>
<div class="wiz-content-text"><script>
(function(){
var model_name = '<% nvram_get("model_name"); %>';      
if(model_name == 'E5350')
{
Capture(wiz.pwdmsg2E5350);
}
else if(model_name == 'E2500')
{       
Capture(wiz.pwdmsg2E2500);
}
else if(model_name == 'E5400')
Capture(wiz.pwdmsg2E5400);
})();
</script></div>
<!-- <div class="wiz-content-text"><script>Capture(wiz.msg3)</script></div> -->
<div class="inputBlock">
<!--
<div class="row">
<div class="col-md-12 col-sm-12 col-xs-12">
<span class="inputLabel"><script>Capture(wiz.pwdrouter_user)</script></span>
</div>
</div>
<div class="row">
<div class="col-md-12 col-sm-12 col-xs-12">
admin
</div>
</div>
-->
<div class="row">
<div class="col-md-12 col-sm-12 col-xs-12">
<span class="inputLabel"><script>Capture(wiz.pwdrouter_pwd)</script></span>
</div>
</div>
<div class="row">
<div class="col-md-12 col-sm-12 col-xs-12">
<input class="input-lg" maxlength="63" size="32" name="router_pwd" onkeydown="if(event.keyCode==13){return false;}" />
<!-- <br /><script>Capture(wiz.pwdmsg3)</script> -->
</div>
</div>
</div>
</div>
<% web_include_file("wizard/wizard_Bottom.asp"); %>
</FORM></BODY></HTML>
