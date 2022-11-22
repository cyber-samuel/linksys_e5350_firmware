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
'wiz.cmpsave': 'javascript:to_submit()',
'portsrv.cancel': 'javascript:goto_cancel()'
});
document.title = share.cmpsumyall;
var wizard_proto="<% nvram_get("wizard_proto"); %>";
var close_session = "<% get_session_status(); %>";
var session_key="<% nvram_get("session_key");%>";
var router_pwd = window.parent.document.getElementById("wizard_router_passwd").value;
var wl0_ssid = html2Escape(window.parent.document.getElementById("wizard_wl0_ssid").value);
var wl0_passwd = window.parent.document.getElementById("wizard_wl0_passwd").value;
var wl1_ssid = html2Escape(window.parent.document.getElementById("wizard_wl1_ssid").value);
var wl1_passwd = window.parent.document.getElementById("wizard_wl1_passwd").value;
var account_name = window.parent.document.getElementById("wizard_pppoe_account").value;
var account_pwd = window.parent.document.getElementById("wizard_pppoe_passwd").value;
function init()
{
if (wizard_proto == "PPPOE")
document.getElementById("pppopsumy").style.display="";
else
document.getElementById("pppopsumy").style.display="none";
}
function goto_back()
{
showWait();
var F = document.save_settings;
if ( close_session == "1" )
document.location.replace("/wizard/create_pwd.asp");
else
document.location.replace("/wizard/create_pwd.asp?session_id="+session_key);
}
function goto_cancel()
{	
var F = document.save_settings;
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
/*WenXuan Add start*/
function getClientTimezone()
{
var oDate = new Date();
var nTimezone = -oDate.getTimezoneOffset()/60;
return nTimezone.toFixed(2);
}
function set_timezone()
{
var getTime = getClientTimezone();
var cha = new Array();
cha = getTime.split(".");
var d1 = new Date(2009, 0, 1);
var d2 = new Date(2009, 6, 1);
if (d1.getTimezoneOffset() != d2.getTimezoneOffset())
{
cha[0] = (parseInt(cha[0]) - 1) + "";
}
if((cha[1] == '00') || (cha[1] != '00' && cha[0] == '5') || (cha[1] != '00' && cha[0] == '-3'))
{
var daytime;
if(cha[0].substr(0, 1) == '-' )
{
var a = cha[0].slice(1);
if(a.length == '1')
{
if(cha[1] != '00')
daytime = '-' + '0' + a + '.5'+ ' 1';
else
daytime = '-' + '0' + a + ' 1';
}
else
{
if(cha[1] != '00')
daytime = '-' + a + '.5' + ' 1';
else
daytime = '-' + a + ' 1' ;
}
}
else
{
if(cha[0].length == '1' )
{
if(cha[1] != '00')
daytime = '+' + '0' + cha[0] + '.5'+ ' 1';
else
daytime = '+' + '0' + cha[0] + ' 1' ;
}
else
{
if(cha[1] != '00')
daytime = '+' + cha[0] + '.5' + ' 1';
else
daytime = '+' + cha[0] + ' 1' ;
}
}
var daylight;
if(daytime == '-09 1' || daytime == '-08 1' || daytime == '-03.5 1')
daylight = ' 1';
else if(daytime == '-06 1')
daylight = ' 6';
else if(daytime == '-02 1' || daytime == '-01 1')
daylight = ' 2';
else
daylight = ' 0';        
document.save_settings.time_zone.value = daytime + daylight;
}
else
document.save_settings.time_zone.value = '-08 1 1';
}
/*WenXuan Add end*/
function to_submit()
{	
var F = document.save_settings;
/*internet settings*/
F.wizard_ppp_username.value = window.parent.document.getElementById("wizard_pppoe_account").value;
F.wizard_ppp_passwd.value = window.parent.document.getElementById("wizard_pppoe_passwd").value;
/*wireless settings*/
F.wizard_wl0_ssid.value = window.parent.document.getElementById("wizard_wl0_ssid").value;
F.wizard_wl0_wpa_psk.value = window.parent.document.getElementById("wizard_wl0_passwd").value;
F.wizard_wl1_ssid.value = window.parent.document.getElementById("wizard_wl1_ssid").value;
F.wizard_wl1_wpa_psk.value = window.parent.document.getElementById("wizard_wl1_passwd").value;
/*router password*/
F.wizard_router_pwd.value = window.parent.document.getElementById("wizard_router_passwd").value;
set_timezone();	
showWait();
F.submit_button.value = "setup_wizard"; 
F.submit_type.value = "save_settings";
F.next_page.value = "wizard/wizard_close_reload.asp";
F.change_action.value = "gozila_cgi";
F.submit();
}
</SCRIPT>
</HEAD>
<BODY onload="init();page_load();alignright('arRight')">
<form method="<% get_http_method(); %>" action="/apply.cgi" name="save_settings">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="next_page" />
<input type="hidden" name="time_zone">
<input type="hidden" name="wizard_wl0_ssid" value="" />
<input type="hidden" name="wizard_wl0_wpa_psk" value="" />
<input type="hidden" name="wizard_wl1_ssid" value="" />
<input type="hidden" name="wizard_wl1_wpa_psk" value="" />
<input type="hidden" name="wizard_router_pwd" value="" />
<input type="hidden" name="wizard_ppp_username" value="" />
<input type="hidden" name="wizard_ppp_passwd" value="" />
<input type="hidden" id="gui_action"  name="gui_action" />
<% web_include_file("wizard/wizard_Top.asp"); %>
<div id=arRight>
<div class="wiz-content-title"><script>Capture(share.summary)</script></div>
<div class="wiz-content-text"><script>Capture(wiz.cmpmsg2)</script></div>
<!-- <div class="wiz-content-text"><script>Capture(wiz.msg3)</script></div> -->
<hr class="summary-line" />
<div class="summaryBlock">
<div id="pppopsumy">
<div class="row" style="padding-top:15px">
<div class="col-md-12">
<span class="strong"><script>Capture(lefemenu.intersetup)</script></span>
</div>
</div>
<div class="row">
<div class="col-md-3 col-xs-5 col-sm-3 text-right">
<span class="inputLabel"><script>Capture(wiz.dslaccount_name)</script></span>
</div>
<div class="col-md-9 col-xs-7 col-sm-9">
<span class="strong">
<script>	
var line, value, htmlvalue;
value = account_name;
line = value.length/35;
for (i=0; i<line; i++)
{
htmlvalue= html2Escape(value.substring(0,35));
document.write(htmlvalue+"<BR>");
value = value.substring(35,value.length);
}
</script>
</span>
</div>
</div>
<div class="row">
<div class="col-md-3 col-xs-5 col-sm-3 text-right">
<span class="inputLabel"><script>Capture(share.passwd)</script></span>
</div>
<div class="col-md-9 col-xs-7 col-sm-9">
<span class="strong">
<script>
var line, value, htmlvalue;
value = account_pwd;
line = value.length/35;
for (i=0; i<line; i++)
{
htmlvalue= html2Escape(value.substring(0,35));
document.write(htmlvalue+"<BR>");
value = value.substring(35,value.length);
}
</script>
</span>
</div>
</div>
</div>
<div class="row" style="padding-top:15px">
<div class="col-md-12">
<span class="strong"><script>Capture(wiz.netwilset)</script></span>
</div>
</div>
<div class="row">
<div class="col-md-3 col-xs-5 col-sm-3 text-right">
<span class="inputLabel">2.4 GHz <script>Capture(wiz.networkname)</script></span>
</div>
<div class="col-md-9 col-xs-7 col-sm-9">
<span class="strong"><script>document.write(wl0_ssid)</script></span>
</div>
</div>
<div class="row">
<div class="col-md-3 col-xs-5 col-sm-3 text-right">
<span class="inputLabel">2.4 GHz <script>Capture(wiz.cmpnetpwd)</script></span>
</div>
<div class="col-md-9 col-xs-7 col-sm-9">
<span class="strong">
<script>
var line, value, htmlvalue;
value = wl0_passwd;
line = value.length/35;
for (i=0; i<line; i++)
{
htmlvalue= html2Escape(value.substring(0,35));
document.write(htmlvalue+"<BR>");
value = value.substring(35,value.length);
}
</script>
</span>
</div>
</div>
<div class="row">
<div class="col-md-3 col-xs-5 col-sm-3 text-right">
<span class="inputLabel">5 GHz <script>Capture(wiz.networkname)</script></span>
</div>
<div class="col-md-9 col-xs-7 col-sm-9">
<span class="strong"><script>document.write(wl1_ssid)</script></span>
</div>
</div>
<div class="row">
<div class="col-md-3 col-xs-5 col-sm-3 text-right">
<span class="inputLabel">5 GHz <script>Capture(wiz.cmpnetpwd)</script></span>
</div>
<div class="col-md-9 col-xs-7 col-sm-9">
<span class="strong">
<script>
var line, value, htmlvalue;
value = wl1_passwd;
line = value.length/35;
for (i=0; i<line; i++)
{
htmlvalue= html2Escape(value.substring(0,35));
document.write(htmlvalue+"<BR>");
value = value.substring(35,value.length);
}
</script>
</span>
</div>
</div>
<div class="row" style="padding-top:15px">
<div class="col-md-12">
<span class="strong"><script>Capture(wiz.pwdrouter_pwd)</script></span>
</div>
</div>
<div class="row">
<div class="col-md-3 col-xs-5 col-sm-3 text-right">
<span class="inputLabel"><script>Capture(share.passwd)</script></span>
</div>
<div class="col-md-9 col-xs-7 col-sm-9">
<span class="strong">
<script>
var line, value, htmlvalue;
value = router_pwd;
line = value.length/35;
for (i=0; i<line; i++)
{
htmlvalue= html2Escape(value.substring(0,35));
document.write(htmlvalue+"<BR>");
value = value.substring(35,value.length);
}
</script>
</span>
</div>
</div>
</div>
</div>
<% web_include_file("wizard/wizard_Bottom.asp"); %>
</FORM></BODY></HTML>
