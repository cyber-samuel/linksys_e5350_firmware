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
'wiz.next': 'javascript:goto_next()',
'wiz.netmsg10': 'javascript:goto_skip()'
});
document.title = share.pwdcreate;
var email_register_status = '<% nvram_get("email_register"); %>';
function show_wait()
{
hiddenPopout();
document.getElementById('email_status').style.display = 'block';
}
function hidden_wait()
{
document.getElementById('email_status').style.display = 'none';
}
function init()
{
if(email_register_status == "0")
{
if(window.parent.document.getElementById("wizard_email_ck").value == "0")
{
show_wait();
setTimeout('hidden_wait()',5000);
}
else if(window.parent.document.getElementById("wizard_email_ck").value == "1")
{
window.parent.document.getElementById("wizard_email_ck").value = "0";
}
}
else if(email_register_status == "1")
{
show_wait();
setTimeout('goto_skip()',5000);
}
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
function goto_skip()
{	
var F = document.create_pwd;
if ( close_session == "1" )
document.location.replace("/wizard/success.asp");
else
document.location.replace("/wizard/success.asp?session_id="+session_key);
}
function check_email_addr(F)
{
var re = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
if(!re.test(F.value))
{
alert(errmsg.emailaddr);
return false;
}
return true;
}
function goto_next()
{	
var F = document.emain_register;
if(check_email_addr(F.email_addr) == false)
{
return false;
}
if(F._privacy_policy.checked == true)
{
F.privacy_policy.value = 1;
}
else
F.privacy_policy.value = 0;
showWait();
F.submit_button.value = "setup_wizard"; 
F.submit_type.value = "setting_email";
F.next_page.value = "wizard/set_email.asp";
F.change_action.value = "gozila_cgi";
F.submit();
}
</SCRIPT>
</HEAD>
<BODY onload="init();page_load();alignright('arRight')">
<form method="<% get_http_method(); %>" action="/apply.cgi" name="emain_register">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="next_page" />
<input type="hidden" name="privacy_policy" />
<% web_include_file("wizard/wizard_Top.asp"); %>
<div id=arRight>
<div class="wiz-content-title"><script>Capture(wiz.netemailset)</script></div>
<div class="wiz-content-text"><script>Capture(wiz.netmsg3)</script></div>
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
<span class="inputLabel"><script>Capture(ddns.emailaddr)</script></span>
</div>
</div>
<div class="row">
<div class="col-md-12 col-sm-12 col-xs-12">
<input class="input-lg" maxlength="63" size="32" name="email_addr" value="<% nvram_get("email_addr"); %>" onkeydown="if(event.keyCode==13){return false;}" />
<!-- <br /><script>Capture(wiz.pwdmsg3)</script> -->
</div>
</div>
</div>
<div class="inputBlock">
<div class="row">
<div class="col-md-12 col-sm-12 col-xs-12">
<tr>
<td><script>
(function(){
var checked;
/*check the privacy_policy checkbox*/
if(window.parent.document.getElementById("lice_ch1").value == 1)
checked = 1;
else
checked = 0;
draw_checkbox('_privacy_policy', wiz.netmsg4, '1','',  checked);
})();	
</script> <a href="PrivacyPolicy.asp"><script>Capture(wiz.netmsg9)</script></a><td>
<tr>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="modal-footer">
<script>
if(email_register_status == "0")
{
draw_button("javascript:goto_skip()", wiz.netmsg10, '', 'btn-wiz');
draw_button("javascript:goto_next()", wiz.tryagain, '', 'btn-wiz');
}
else if(email_register_status == "1")
draw_button("javascript:goto_skip()", wiz.next, '', 'btn-wiz');
else
{
draw_button("javascript:goto_next()", wiz.next, '', 'btn-wiz');
draw_button("javascript:goto_skip()", wiz.netmsg10, '', 'btn-wiz');
}
</script>
</div>
</div>
<!--
<% web_include_file("wizard/wizard_Bottom.asp"); %>
-->
<div id="email_status" style="display: none;">
<div class="modal" role="diglog" _v-f353fd1c="">
<div class="modal-dialog modal-sm">
<div class="modal-content">
<div class="loadingImg" _v-f353fd1c="">
<div class="row">
<!--
<div class="col-md-12">
<div class="v-spinner">
<div class="v-clip" style="height: 35px; width: 35px; border-width: 2px; border-style: solid; border-color: rgb(0, 104, 217) rgb(0, 104, 217) transparent; border-radius: 100%; background: transparent !important;">&nbsp;</div>
</div>
</div>
-->
<div class="col-md-12">
<p><script>
if(email_register_status == "1")
Capture(wiz.setemailsuccess)
else
Capture(wiz.setemailfail)
</script></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</FORM></BODY></HTML>
