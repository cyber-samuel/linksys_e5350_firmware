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
document.title = share.internetconn;
function set_parentvalue()
{
document.set_pppoe.account_name.value=window.parent.document.getElementById("wizard_pppoe_account").value;
document.set_pppoe.account_pwd.value=window.parent.document.getElementById("wizard_pppoe_passwd").value;
}
function goto_back()
{
showWait();
var F = document.set_pppoe;
if ( close_session == "1" )
document.location.replace("/wizard/index.asp");
else
document.location.replace("/wizard/index.asp?session_id=" + session_key);
}
function goto_cancel()
{	
var F = document.set_pppoe;
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
var F = document.set_pppoe;
if(F.account_name.value.length > 63)
{
alert(wiz.wirelessAccount); 
F.account_name.focus();
return false;
}
if(!wz_valid_name(F.account_name, wiz.dslaccount_name))
return false; 	
if(F.account_name.value == ""){
alert(errmsg.err0);
F.account_name.focus();
return false;
}
if(F.account_pwd.value.length > 63)
{
alert(wiz.wirelessPasswd1); 
F.account_pwd.focus();
return false;
}
if(!wz_valid_name(F.account_pwd, share.passwd))
return; 	
if(F.account_pwd.value == ""){
alert(errmsg.err6);
F.account_pwd.focus();
return false;
}
window.parent.document.getElementById("wizard_pppoe_account").value = F.account_name.value;
window.parent.document.getElementById("wizard_pppoe_passwd").value = F.account_pwd.value;
showWait();
if ( close_session == "1" )
document.location.replace("/wizard/set_wireless.asp");
else
document.location.replace("/wizard/set_wireless.asp?session_id="+session_key);
}
</SCRIPT>
</HEAD>
<BODY onload="set_parentvalue();displayWizard();page_load();alignright('arRight')">
<form method="<% get_http_method(); %>" action="/apply.cgi" name="set_pppoe">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="next_page" />
<% web_include_file("wizard/wizard_Top.asp"); %>
<div id=arRight>
<div class="wiz-content-title"><script>Capture(lefemenu.intersetup)</script></div>
<div class="wiz-content-text"><script>Capture(wiz.dslmsg1)</script></div>
<!-- <div class="wiz-content-text"><script>Capture(wiz.msg3)</script></div> -->
<div class="inputBlock">
<div class="row">
<div class="col-md-12 col-sm-12 col-xs-12">
<span class="inputLabel"><script>Capture(wiz.dslaccount_name)</script></span>
</div>
</div>
<div class="row">
<div class="col-md-12 col-sm-12 col-xs-12">
<input class="input-lg" type="text" maxlength="63" size="26" name="account_name" />
</div>
</div>
<div class="row">
<div class="col-md-12 col-sm-12 col-xs-12">
<span class="inputLabel"><script>Capture(share.passwd)</script></span>
</div>
</div>
<div class="row">
<div class="col-md-12 col-sm-12 col-xs-12">
<input class="input-lg" type="text" maxlength="63" size="26" name="account_pwd" />
</div>
</div>
</div>
<div class="wiz-content-text" style="padding-top: 25px;"><script>Capture(wiz.dslmsg2)</script></div>
</div>
<% web_include_file("wizard/wizard_Bottom.asp"); %>
</FORM></BODY></HTML>
