<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Language</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<link rel="stylesheet" href="dhtmlwindow<% ui_position("match", "_rtl"); %>.css" type="text/css" />
<link rel="stylesheet" href="modal.css" type="text/css" />
<script type="text/javascript" src="language.js" charset="UTF-8"></script>
<SCRIPT language="JavaScript">
setFormActions({
save:   true,
cancel: true
});
/***********************************************
* DHTML Window Widget- ? Dynamic Drive (www.dynamicdrive.com)
* This notice must stay intact for legal use.
* Visit http://www.dynamicdrive.com/ for full source code
***********************************************/
document.title = adtopmenu.lang;
var close_session = "<% get_session_status(); %>";
var EN_DIS2 = '<% nvram_get("mtu_enable"); %>';	
var wan_proto = '<% nvram_get("wan_proto"); %>';
var DHCPRef = null;
function to_submit(F)
{
F.submit_button.value = "index";
F.submit_type.value = "language";
ajaxSubmit(5,"true");
}
function init()
{
var F = document.setup;
var str;
var sip;
var num;
var eip;	
var first_bootup_flag = '<%nvram_get("login_checked");%>';
var lang = "<%nvram_get("detect_lang");%>";
var wan_proto = "<% nvram_get("wan_proto"); %>";
var i, j;
/*if(lang == "nl")
{
var dhcp_button = document.getElementsByName("dhcp_res");
var funfield = getstyle(".FUNFIELD");
dhcp_button[0].style.width = 110;
getstyle(".FUNNAME2").width = 100;	// from 131px to 100px
funfield.width = 316;				// from 300px to 331px
funfield.paddingLeft = 15;			// from 0px to 15px
}
else if(lang == "ru")
{
var dhcp_button = document.getElementsByName("dhcp_res");
var funfield = getstyle(".FUNFIELD");
dhcp_button[0].style.width = 140;
getstyle(".FUNNAME2").width = 95;	// from 131px to 95px
funfield.width = 311;				// from 300px to 336px
funfield.paddingLeft = 25;			// from 0px to 25px
}*/
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "/*"); %>
<% support_invmatch("HNAP_SPEC_V12_SUPPORT", "1", "*/"); %>
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
function SelLang(num,F)
{
F.submit_button.value = "index";
F.change_action.value = "gozila_cgi";
F.submit_type.value = "language";
F.detect_lang.value=F.detect_lang.options[num].value;
}
function exit()
{
if (DHCPRef)
DHCPRef.close();
}
</SCRIPT>
</HEAD>
<BODY onload=init() onunload=exit() >
<FORM name=language method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<% web_include_file("Top.asp");%>
<!-- Begin Multi lang 2008-4-11 wuzhihua -->
<table class="table table-info">			
<tbody>
<tr>
<td><script>Capture(adtopmenu.selan)</script></td>
<td>	
<script>
(function(){
var str = [lang1.en, lang1.ar, lang1.dk, lang1.de, lang1.es, lang1.fr, lang1.frc, lang1.it, lang1.nl, lang1.pl, lang1.pt, lang1.ru, lang1.se, lang1.tr],
val = ['en', 'ar', 'dk', 'de', 'es', 'fr', 'frc', 'it', 'nl', 'pl', 'pt', 'ru', 'se', 'tr'];
draw_select('detect_lang', str, val, 'SelLang(this.form.detect_lang.selectedIndex,this.form)', '<% nvram_selget("detect_lang"); %>');
})();
</script>
</td>		
</tr>
</tbody>	  
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
