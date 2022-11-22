<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>DDNS</TITLE>
<% no_cache(); %>
<% charset(); %>
<SCRIPT language=javascript type=text/javascript src=/<% get_lang(); %>_lang_pack/ddns.js></SCRIPT>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
save:    true,
cancel:	 true
});
document.title = share.ddns;
var close_session = "<% get_session_status(); %>";
function check_email_addr(F)
{
var re = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
if(!re.test(F.value))
{
alert(errmsg.err63);
F.value = F.defaultValue;
F.focus();
return false;
}
return true;
}
function ddns_check(F,T)
{
var re ; 
if(F.ddns_enable.value == 0)
return true;
else if(F.ddns_enable.value == 1){
username = eval("F.ddns_username");
passwd = eval("F.ddns_passwd");
hostname = eval("F.ddns_hostname");
}
else {
username = eval("F.ddns_username_"+F.ddns_enable.value);
passwd = eval("F.ddns_passwd_"+F.ddns_enable.value);
hostname = eval("F.ddns_hostname_"+F.ddns_enable.value);
}
if(F.ddns_enable.value == 2){	// tzo
if(valid_email(F.ddns_username_2) == false || check_email_addr(F.ddns_username_2) == false)
return false;
re = new RegExp("^[a-zA-Z][0-9]{15}","gi");
if ( (!re.test( F.ddns_passwd_2.value )) || F.ddns_passwd_2.value.length<16 ) 
{
alert(errmsg.err93);
F.ddns_passwd_2.focus();
return false; 
}
if( F.ddns_hostname_2.value.indexOf("@")!=-1 ) 
{
alert(errmsg.err31);
F.ddns_hostname_2.focus();
return false ; 
}
}
if(username.value == ""){
alert(errmsg.err0);
username.focus();
return false;
}
if(passwd.value == ""){
alert(errmsg.err6);
passwd.focus();
return false;
}
if(F.ddns_enable.value != 4){
if(hostname.value == ""){
if(F.ddns_enable.value == 1)	
alert(errmsg.err7);
if(F.ddns_enable.value == 2)
alert(errmsg.dname);
hostname.focus();
return false;
}
}
return true;
}
function to_update(F)
{
if(ddns_check(F,"update") == true){
F.change_action.value = "gozila_cgi";
F.submit_button.value = "DDNS";
F.submit_type.value = "update";
F.gui_action.value = "Apply";
F.submit();
}
}
/*
function ddns_update(F)
{
}
*/
function to_submit(F)
{
if(ddns_check(F,"save") == true){
F.submit_button.value = "DDNS";
F.gui_action.value = "Apply";
ajaxSubmit(0,"false");
}
}
function disable_value(F)
{
if( F.ddns_enable.value == 1 )
{
F.ddns_username.disabled = "";
F.ddns_passwd.disabled = "";
F.ddns_hostname.disabled = "";
F.ddns_service.disabled = "";
F.ddns_mx.disabled = "";
F.ddns_backmx.disabled = "";
F.ddns_wildcard.disabled = "";
F.ddns_username_2.disabled = "true";
F.ddns_passwd_2.disabled = "true";
F.ddns_hostname_2.disabled = "true";
}
if( F.ddns_enable.value == 2 )
{
F.ddns_username_2.disabled = "";
F.ddns_passwd_2.disabled = "";
F.ddns_hostname_2.disabled = "";
F.ddns_username.disabled = "true";
F.ddns_passwd.disabled = "true";
F.ddns_hostname.disabled = "true";
F.ddns_service.disabled = "true";
F.ddns_mx.disabled = "true";
F.ddns_backmx.disabled = "true";
F.ddns_wildcard.disabled = "true";
}
if( F.ddns_enable.value == 0 )
{
F.ddns_username_2.disabled = "true";
F.ddns_passwd_2.disabled = "true";
F.ddns_hostname_2.disabled = "true";
F.ddns_username.disabled = "true";
F.ddns_passwd.disabled = "true";
F.ddns_hostname.disabled = "true";
F.ddns_service.disabled = "true";
F.ddns_mx.disabled = "true";
F.ddns_backmx.disabled = "true";
F.ddns_wildcard.disabled = "true";
}
}
function SelDDNS(num,F,flg)
{
disable_value(F);
if ( flg == 0 ) 
{
HIDDEN_PART("tr","usrname1", "button", 1);
}
/*
document.getElementById('usrname1').style.display = "none";
document.getElementById('passwd').style.display = "none";
document.getElementById('hostname').style.display = "none";
document.getElementById('system1').style.display = "none";
document.getElementById('mailexchange').style.display = "none";
document.getElementById('wildcard1').style.display = "none";
document.getElementById('emailaddr').style.display = "none";
document.getElementById('tzokey').style.display = "none";
document.getElementById('domainname').style.display = "none";
document.getElementById('interipaddr').style.display = "none";
document.getElementById('statu').style.display = "none";
document.getElementById('button').style.display = "none";
*/
if( F.ddns_enable.value == 1)
{
document.getElementById('usrname1').style.display = "table-row";
document.getElementById('passwd').style.display = "table-row";
document.getElementById('hostname').style.display = "";
document.getElementById('system1').style.display = "";
document.getElementById('mailexchange').style.display = "";
document.getElementById('backupmx').style.display = "";
document.getElementById('wildcard1').style.display = "";
document.getElementById('interipaddr').style.display = "";
document.getElementById('statu').style.display = "";
document.getElementById('button').style.display = "";
}
if( F.ddns_enable.value == 2)
{
document.getElementById('emailaddr').style.display = "table-row";
document.getElementById('tzokey').style.display = "table-row";
document.getElementById('domainname').style.display = "table-row";
document.getElementById('interipaddr').style.display = "table-row";
document.getElementById('statu').style.display = "table-row";
document.getElementById('button').style = "display:table-row";
}
F.ddns_enable.value=F.ddns_enable.options[num].value;
}
function show_status()
{
var RetMsg="<% show_ddns_status(); %>";
if( RetMsg=="  " || RetMsg.length < 2)
return;
else
Capture(<% show_ddns_status(); %>);
}
function init()
{
var swmode = '<% nvram_get("switch_mode");%>';
var protocolWan = '<% nvram_get("wan_proto");%>';
SelDDNS(document.ddns.ddns_enable.selectedIndex,document.ddns,1);
if( swmode == 1)
alert(share.brdgmwn);
else if( protocolWan == "dslite" ){
alert ("These features are not supported when the router is operating in DS-Lite Mode.");
}
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
<BODY onload="init()">
<DIV align="center">
<FORM name="ddns" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="wait_time" value="6" />
<% web_include_file("Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(ddns.srv)</script></td>
<td>
<script>
(function(){
var flag;
var lang = '<% nvram_get("language"); %>';
var ddns_enable = '<% nvram_selget("ddns_enable"); %>';
var ddns3322 = '0';
var peanuthull = '0';
<% support_invmatch("DDNS3322_SUPPORT", "1", "//"); %> ddns3322 = '1';
<% support_invmatch("PEANUTHULL_SUPPORT", "1", "//"); %> peanuthull = '1';
if(ddns_enable == '0')
flag = '0';
if (ddns3322 == '1' && peanuthull == '1')
{
if(lang == 'EN' || lang == 'SC')
flag = '34';
else
flag = '12';
}
else
flag = '12';
var str = [],
val = [];
if( flag == '12' )
{
str = [ ddns.dyndns, ddns.tzo, share.disabled ];
val = [ '1', '2', '0' ];
}
else if( flag == '34' ) {
str = [ ddns.ddns3322, ddns.peanuthull, share.disabled ];
val = [ '3', '4', '0' ];
}
draw_select('ddns_enable', str, val, 'SelDDNS(this.form.ddns_enable.selectedIndex,this.form,0)', '<% nvram_selget("ddns_enable"); %>');
})();
</script>
</td>
</tr>
<tr style=display:none id=usrname1>
<td><script>Capture(share.usrname1)</script></td>
<td>
<input type="text" size="26" maxlength="32" name="ddns_username" value="<% nvram_get("ddns_username"); %>" onFocus="check_action(this,0)" onBlur="valid_name(this,'User%20Name')" />
</td>	
</tr>
<tr style=display:none id=passwd>
<td><script>Capture(share.passwd)</script></td>
<td>
<input type="password" size="26" maxlength="32" name="ddns_passwd" value="<% nvram_get("ddns_passwd"); %>" onFocus="check_action(this,0)" onBlur="valid_name(this,'Password')" />
</td>
</tr>
<tr style=display:none id=hostname>
<td><script>Capture(share.hostname)</script></td>
<td>
<input type="text" size="26" maxlength="128" name="ddns_hostname" value="<% nvram_get("ddns_hostname"); %>" onFocus="check_action(this,0)" onBlur="valid_name(this,'Host%20Name')" />
</td>
</tr>
<tr style=display:none id=system1>
<td><script>Capture(ddns.system)</script></td>
<td>
<script>
(function(){
var str = [ ddns.dynamic, ddns.static1, ddns.custom ],
val = [ 'dyndns', 'dyndns-static', 'dyndns-custom' ];
draw_select('ddns_service', str, val, '', '<% nvram_selget("ddns_service"); %>');
})();
</script>
</td>
</tr>
<tr style=display:none id=mailexchange>
<td><script>Capture(ddns.mailexchange)</script> (<script>Capture(share.optional)</script>)</td>
<td>
<input type="text" size="26" maxlength="63" name="ddns_mx" value="<% nvram_get("ddns_mx"); %>" onFocus="check_action(this,0)" onBlur="valid_name(this,'Mail%20Exchange')" />
</td>
</tr>
<tr style=display:none id=backupmx>
<td><script>Capture(ddns.backupmx)</script></td>
<td>
<script>
var str = [ share.enabled, share.disabled ],
val = [ 'YES', 'NO' ];
draw_select('ddns_backmx', str, val, '', '<% nvram_get("ddns_backmx"); %>');
</script>
</td>
</tr>
<tr style=display:none id=wildcard1>
<td><script>Capture(ddns.wildcard)</script></td>
<td>
<script>
(function(){
var str = [ share.enabled, share.disabled ],
val = [ 'ON', 'OFF' ];
draw_select('ddns_wildcard', str, val, '', '<% nvram_get("ddns_wildcard"); %>');
})();
</script>
</td>
</tr>
<tr style=display:none id=emailaddr>
<td><script>Capture(ddns.emailaddr)</script></td>
<td>
<input type="text" size="26" maxlength="32" name="ddns_username_2" value="<% nvram_get("ddns_username_2"); %>" onFocus="check_action(this,0)" onBlur="valid_name(this,'E-mail%20Address')" />
</td>
</tr>
<tr style=display:none id=tzokey>
<td><script>Capture(ddns.tzokey)</script></td>
<td>
<input type="password" size="26" maxlength="16" name="ddns_passwd_2" value="<% nvram_get("ddns_passwd_2"); %>" onFocus="check_action(this,0)" onBlur="valid_name(this,'Password')" />
</td>
</tr>
<tr style=display:none id=domainname>
<td><script>Capture(share.domainname)</script></td>
<td>
<input type="text" size="26" maxlength="48" name="ddns_hostname_2" value="<% nvram_get("ddns_hostname_2"); %>" onFocus="check_action(this,0)" onBlur="(this,'Domain%20Name')" />
</td>
</tr>
<tr style=display:none id=interipaddr>
<td><script>Capture(share.interipaddr)</script></td>
<td>
<script>
if('<% get_lang(); %>' == 'ar')
{
var wanip = '<% show_ddns_ip(); %>';
var tip = wanip.split('.');
var show = tip[3] + '.' + tip[2] + '.' + tip[1] + '.' + tip[0];
document.write(show);
}
else
{
document.write('<% show_ddns_ip(); %>');
}
</script>
</td>
</tr>
<tr style=display:none id=statu>
<td><script>Capture(bmenu.statu)</script></td>
<td><script>show_status();</script>&nbsp;</td>
</tr>
<tr style=display:none id=button>
<td>&nbsp;</td>
<td>
<script>draw_button("javascript:to_update(this.form)", sbutton.update, 'update')</script>
</td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
