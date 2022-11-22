<!DOCTYPE html>
<html lang="en" class="gt-ie8">
<head>
<meta content=0 http-equiv=expires>
<meta content=no-cache http-equiv=cache-control>
<meta content=no-cache http-equiv=pragma>
<meta charset="utf-8" />
<!-- Set the viewport width to device width for mobile -->
<meta name="viewport" content="width=device-width" />
<!-- InstanceBeginEditable name="Page Title" -->
<title>Device link step5</title>
<!-- InstanceEndEditable -->
<link rel="stylesheet" type="text/css" href="bbs/css/app.css">
<link rel="stylesheet" type="text/css" href="bbs/css/wrx.css">
<link rel="stylesheet" type="text/css" href="css/core/layout.css">
</head>
<script type="text/javascript">
if (!window.console) console = {log: function() {}};
</script>
<% web_include_file("wizard/filelink.asp"); %>
<!-- InstanceBeginEditable name="Include Files" -->
<!-- InstanceEndEditable -->
<script>
var langset = "EN";
var lang = (langset=="")? "EN":langset;
var close_session = "<% get_session_status(); %>";
var session_key="<% nvram_get("session_key");%>";
$(window).resize(function(){
$('.v-line').each(function(){
var mheight = ($('#mainContent').height() > 390) ? $('#mainContent').height():390;
$(this).css('height', mheight);
})
});
function selectLanguage(value) {
document.getElementById("langSelectionOnly").value = value;
$("#waiting_box").reveal({ animation: 'fade', animationspeed: 100 });
document.language_select.submit();
}
function template_load() {
var F = document.devlink5;
if(typeof page_load == 'function') page_load();
MM_preloadImages('bbs/images/loading.gif', 'bbs/images/arrow_right_blue.png', 'bbs/images/arrow_down_blue.png');
$(window).resize();
}
$(function() {
$.cookie("network_number", 0);
});
</script>
<body onLoad="template_load();">
<!-- Header -->
<!--<div id="header" >-->
<div style="background-color:#2971b9;">
<div class="row"></div>
<div style="padding-left:10px;padding-top:15px;padding-bottom:5px">
<h4 style="font-weight:bold;color:#ffffff"><script>Capture(wizardBasic.E8400_setup_wizard)</script></h4>
</div>
</div> <!-- / #header -->
<!--<div id="mainBackground"></div>
<div class="footerwrapper">--> <!-- This is used to push the footer down below content as it scrolls into view, or stick it on the bottom. -->
<!-- InstanceBeginEditable name="Scripts" -->
<style type="text/css">
.list p { margin:0; }
</style>
<script language="javascript" type="text/javascript">
function page_load() 
{	
if ( close_session == "1" )
{
document.forms[0].action= "apply.cgi";
}
else
{
document.forms[0].action= "apply.cgi?session_id=<% nvram_get("session_key"); %>";
}
}
function goto_next()
{
if ( close_session == "1" )
goto_url("/wizard/show_devlink.asp");
else
goto_url("/wizard/show_devlink.asp?session_id="+session_key);
}
function goto_back()
{
if ( close_session == "1" )
goto_url("/wizard/show_link_step4.asp");
else
goto_url("/wizard/show_link_step4.asp?session_id="+session_key);
}
function goto_cancel()
{	
var F=document.devlink5;
if (confirm(wizardResult.exitwarnmsg))
{
F.submit_button.value = "setup_wizard";
F.submit_type.value="finish";
F.next_page.value="wizard/wizard_close_reload.asp";
F.change_action.value = "gozila_cgi";
F.submit(); 	
}
}
</script>
<!-- InstanceEndEditable -->
<!-- InstanceBeginEditable name="Main Content" -->
<FORM autocomplete=off id=frm action=apply.cgi name="devlink5" method=<% get_http_method(); %>>
<input type="hidden" name="submit_button" value="">
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=next_page>
<input type=hidden name="gui_action" />
<div class="main" style="padding-bottom:0px;">
<div class="row">
<div id="mainContent" class="forcebfc">
<table border="1" style="width:100%;width:97%\9;margin-bottom:0px"><tr><td>
<div class="row">
<div class="col-xs-12">
<h6 style="font-weight:bold;"><script>Capture(wizarddevlink.step51);</script></h6>
</div>
<p style="font-size:14px"><script>Capture(wizarddevlink.step52)</script></p>
</div>
<div class="row">
<div class="twelve columns" style="padding-top:0px;text-align:center">
<div class="inline-block">
<table style="width:100%;width:97%\9;border-width:0px;padding-bottom:0px;margin-bottom:0px;">
<tr style="background-color:#ffffff"><td style="padding-top:0px;padding-bottom:0px">
<table style="width:100%;width:110%\9;border-width:0px;margin-bottom:0px;">
<tr>
<td width=160 ><table  style="width:100%;border-width:0px;margin:0 0 5px;">
<!--	<tr style="background-color:#ffffff"><td>&nbsp;</td></tr>-->
<tr style="background-color:#ffffff"><td style="padding-top:0px">
<img src="bbs/images/e8350.connect.attachwan2.router.png" style="text-align:center">
</td></tr>
</table>
</td>
</tr>
<!--
<tr style="background-color:#ffffff"><td style="padding-top:0px\9;">
<img src="../image/alert_informational_2009_32.png" style="width:20px" alt="">&nbsp;&nbsp;&nbsp;&nbsp;
<script>Capture(wizardBasic.msg5)</script>
</td></tr>-->
</table>
</td>
<td style="vertical-align:middle;padding-top:0px;padding-bottom:0px">
<!--<div><img src="images/Router.jpg" style="width:200px" alt=""></div>-->
</td>
</tr>							
</table>					
</div>						
</div>					
</div>
</td></tr>
</table>
</div><!-- mainContent -->
</div>
</div>
<!-- InstanceEndEditable -->
<div class="fixedfooterclear" style="text-align:center">
<table class="fwgui" style="width:100%;padding-top:0px" border=1>
<tr id="wpr-layout-footer">
<td  id="wpr-layout-pageaction">
<div id="wpr-layout-pageaction-container" align="left" style="padding-left:5px">
<script>
document.write("<button type=button class=wpr-layout-pageaction-button style=\"width:100px;background-color:gray\" onclick=\"javascript:goto_cancel()\" id=t3 >");
Capture(msgCommon.cancel);
document.write("</button>");
</script>
</div>
</td>
<td id="wpr-layout-pageaction">
<div id="wpr-layout-pageaction-container" style="padding-right:5px">
<script>	
document.write("<button type=button class=wpr-layout-pageaction-button style=\"width:100px;background-color:gray\" onclick=\"javascript:goto_back()\" id=t1 >");
Capture(msgCommon.back);
document.write("</button>");
document.write("<button type=button class=wpr-layout-pageaction-button style=\"width:100px;\" onclick=\"javascript:goto_next()\" id=t2 >");
Capture(msgCommon.next);
document.write("</button>");
</script>
</div>
</td>
</tr></table>
</div>
</div> <!-- footerwrapper -->
</FORM>
<div id="copyright" class="fixedfooter fwfooter" style="padding-top:0px">
<div class="row">
<div class="twelve columns">
<div class="clear"></div>
<div class="copyright left" style="text-align:right;padding-left:20px\9">
<script>Capture(wizardBasic.copyright);</script>
</div>
</div>
</div>
</div>
</body>
<!-- InstanceEnd --></html>
