<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>admin backup</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink_fail.asp"); %>
<SCRIPT language="JavaScript">
document.title = adtopmenu.manage;
var close_session = "<% get_session_status(); %>";
var is_wireless_mac="<% is_wireless_mac(); %>";
var EN_DIS1 = '<% nvram_get("remote_management"); %>'	
var wan_proto = '<% nvram_get("wan_proto"); %>'
var snmp_confirm = 0
function to_restore(F)
{
var len = F.restore.value.length;
var ext = new Array('.','c','f','g');
if (F.restore.value == '')      {
alert(bakres2.file2res);
return false;
}
var IMAGE = F.restore.value.toLowerCase();
for (i=0; i < 4; i++)   {
if (ext[i] != IMAGE.charAt(len-4+i)){
alert(hupgrade.wrimage);
return false;
}
}
F.submit_button.value = "Restore";
F.submit();
}
function handle_http(F)
{
return ;
if(F._http_enable.checked == false && F._https_enable.checked == true) {
F._remote_mgt_https[0].checked = false;
F._remote_mgt_https[1].checked = true;
}
}
function handle_https(F)
{
return ;
if(F._http_enable.checked == true && F._https_enable.checked == false) {
F._remote_mgt_https[0].checked = true;
F._remote_mgt_https[1].checked = false;
}
}
function handle_http_rmt(F)
{
if(F._remote_mgt_https[1].checked == true)	F.remote_mgt_https.value = 1;
else					F.remote_mgt_https.value = 0;
}
function goto_index()
{
document.location.replace('Router_Login.asp');
}
function goto_wait()
{
hiddenPopout();
document.getElementById('wait_reboot').style.display = 'block';
}
function init() 
{
var close_session = "<% get_session_status(); %>";
if ( close_session == "1" )
{
document.forms[0].action= "restore.cgi";
}
else
{
document.forms[0].action= "restore.cgi?session_id=<% nvram_get("session_key"); %>";
}
alertRestoreFailed(errmsg.err85);
setTimeout('goto_wait()',1000);
if(is_wireless_mac == "1")
setTimeout('goto_index()',100000);
else
setTimeout('goto_index()',90000);
}
</SCRIPT>
</HEAD>
<BODY vLink="#b5b5e6" aLink="#ffffff" link="#b5b5e6" onload="init()">
<FORM name=res method=post action=restore.cgi encType=multipart/form-data>
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" />
<!--input type="hidden" name="tmsss_enabled"-->
<input type="hidden" name="need_reboot" value="0" />
<input type=hidden name=small_screen>
<input type=hidden name="wait_time" value="21">
<% web_include_file("Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td >
<script>Capture(backup.BYC)</script></td>
<td>
<script>draw_button("javascript:window.location.href='<% get_backup_name(""); %>?session_id=<% nvram_get("session_key"); %>'", bakres2.bakbutton, 'backup_b')</script>
</td>
</tr>
<tr>
<td>
<script>Capture(backup.RYC)</script></td>
<td>
<input type="file" name="restore" size="26" />
<script>draw_button("javascript:to_restore(this.form)", adbutton.startrestore, 'restore_b')</script> 
<!--<script>document.write("<input  type=button name=restore_b value='" + adbutton.startrestore + "' onclick=to_restore(this.form)>");</script  -->
</td>
</tr>
</tbody>
</table>
<div id="wait_reboot" style="display: none;">
<div class="modal" role="diglog" _v-f353fd1c="">
<div class="modal-dialog modal-sm">
<div class="modal-content">
<div class="loadingImg" _v-f353fd1c="">
<div class="row">
<div class="col-md-12">
<div class="v-spinner">
<div class="v-clip" style="height: 35px; width: 35px; border-width: 2px; border-style: solid; border-color: rgb(0, 104, 217) rgb(0, 104, 217) transparent; border-radius: 100%; background: transparent !important;">&nbsp;</div>
</div>
</div>
<br>
<br>
<div class="col-md-12">
<p><script>Capture(errmsg.err85)</script></p>
<p><script>Capture(fwupgrade.reboot)</script></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<% support_invmatch("BACKUP_RESTORE_SUPPORT","1","-->"); %>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
