<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>>
<HEAD>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capsetup.js"></SCRIPT>
<script type="text/javascript">
document.title = wiz.detectwan;
var flag = "<% nvram_get("wizard_proto"); %>";
var close_session = "<% get_session_status(); %>";
var session_key = "<% nvram_get("session_key"); %>";
function init()
{
var url;
if(flag == "PPPOE")
url = "/wizard/set_pppoe.asp"
else if(flag == "DHCP")
url = "/wizard/set_wireless.asp";
else
url = "/wizard/noplug_cable.asp";
if ( close_session != "1" )
url += "?session_id=" + session_key;
document.location.replace(url);
}
</script>
</HEAD>
<BODY onload="init();alignright('arRight')">
<% web_include_file("wizard/wizard_Top.asp"); %>
<div id=arRight>
<div class="wiz-content-text"><script>Capture(wiz.waitdetect)</script></div>
</div>
<% web_include_file("wizard/wizard_Bottom.asp"); %>
</BODY></HTML>
