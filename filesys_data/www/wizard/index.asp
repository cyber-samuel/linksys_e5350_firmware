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
'portsrv.cancel': 'javascript:goto_cancel()'
});
document.title = wiz.setuplice;
function hide()
{
var F = document.wz_index;
if(F.lice.checked == true)
{
document.getElementById('alert').style.display = 'none';
document.getElementById('blank').style.display = 'block';
window.parent.document.getElementById("lice_ch").value = 1;
}
}
function goto_next()
{
var F = document.wz_index;
if(F.lice.checked != true)
{
document.getElementById('alert').style.display = 'block';
document.getElementById('blank').style.display = 'none';	
return;
}
showWait();
F.submit_button.value = "setup_wizard";
F.submit_type.value="detect_wan";
F.next_page.value="wizard/detect_wan.asp";
F.change_action.value = "gozila_cgi";
F.submit();
}
function goto_cancel()
{	
var F = document.wz_index;
if(F.lice.checked != true)
{
document.getElementById('alert').style.display = 'block';
document.getElementById('blank').style.display = 'none';
return;
}
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
</SCRIPT>
</HEAD>
<BODY onload="page_load();alignright('arRight')">
<form method="<% get_http_method(); %>" action="apply.cgi" name="wz_index">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="next_page" />
<% web_include_file("wizard/wizard_Top.asp"); %>
<div id=arRight>
<div style="overflow-x:auto;height:280px;">
<div class="wiz-content-title"><script>Capture(wiz.getstart)</script></div>
<div class="wiz-content-text"><script>Capture(wiz.msg2)</script></div>
<!-- <div class="wiz-content-text"><script>Capture(wiz.msg3)</script></div> -->
<div style=" padding-top:20px"></div>
<div id="blank" ><br></div>
<div id="alert" style="font-weight:bold; color:red;display: none; "><script>Capture(wiz.msgalert)</script></div>
<div style=" padding-bottom:50px">
<script>
(function(){
var checked; 
if(window.parent.document.getElementById("lice_ch").value == 1)
checked = 1;
else
checked = 0;
draw_checkbox('lice',' ' ,'1' ,'hide()' , checked);
})();
</script>
<script>document.write('<a href="' + '/wizard/license.asp' + '" onclick="showWait();">' + wiz.msg4 + '</a>')</script>
</div>
<div class="wiz-content-text">
<img style="width:20px;height:20px" src="data:image/png;base64,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" />
<script>Capture(wiz.msg5)</script>
</div>
</div>
</div>
<% web_include_file("wizard/wizard_Bottom.asp"); %>
</FORM></BODY></HTML>
