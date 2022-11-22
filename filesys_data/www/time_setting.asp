<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Time Zone</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<link rel="stylesheet" href="dhtmlwindow<% ui_position("match", "_rtl"); %>.css" type="text/css" />
<link rel="stylesheet" href="modal.css" type="text/css" />
<script type="text/javascript" src="language.js" charset="UTF-8"></script>
<SCRIPT language=JavaScript>
setFormActions({
save:   true,
cancel: true
});
document.title = share.timezone;
var close_session = "<% get_session_status(); %>";
var EN_DIS2 = '<% nvram_get("mtu_enable"); %>';	
var wan_proto = '<% nvram_get("wan_proto"); %>';
var DHCPRef = null;
function to_submit(F)
{
if (F._daylight_time.checked == false)
F.daylight_time.value = 0;
else
F.daylight_time.value = 1;
F.submit_button.value = "Time_Zone";
F.gui_action.value = "Apply";
ajaxSubmit(0,"false");
}
function SelTime(num,f)
{
var str = f.time_zone.options[num].value;
var Arr = new Array();
Arr = str.split(' ');
aaa = Arr[2];
daylight_enable_disable(f,aaa);
}
function daylight_enable_disable(F,aaa)
{
if(aaa == 0){
F._daylight_time.checked = false;
choose_disable(F._daylight_time);
F.daylight_time.value = 0;
update_checked(F._daylight_time);
}
else{
choose_enable(F._daylight_time);                
F._daylight_time.checked = true;
F.daylight_time.value = 1;
update_checked(F._daylight_time);
}
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
str = F.time_zone.options[F.time_zone.selectedIndex].value;
Arr = new Array();
var RANGESET ; 
update_checked(document.setup._daylight_time);
Arr = str.split(' ');
aaa = Arr[2];
if(aaa == 0){
document.setup._daylight_time.checked = false;
choose_disable(document.setup._daylight_time);
document.setup.daylight_time.value = 0;
}
if ( '<% nvram_selget("time_zone"); %>' == '+12 2 4' ) {
document.setup.time_zone.selectedIndex = '37';
}
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
function exit()
{
if (DHCPRef)
DHCPRef.close();
}
</SCRIPT>
</HEAD>
<BODY onload=init() onunload=exit() >
<FORM name=setup method=<% get_http_method(); %> action=apply.cgi>
<input type=hidden name=submit_button>
<input type=hidden name=change_action>
<input type=hidden name=submit_type>
<input type=hidden name=gui_action>
<input type=hidden name=daylight_time value=0>
<% web_include_file("Top.asp");%>
<table class="table table-info">
<tbody>
<TR><TD><script>Capture(share.timezone)</script><TD>
<td>
<script>
(function(){
var str = [timezone.Kwajalein, timezone.Midway, timezone.Hawaii, timezone.Alaska, timezone.Pacific, timezone.Arizona, timezone.Mountain, timezone.Mexico, timezone.Central, timezone.Indiana, timezone.Eastern, timezone.Bolivia, timezone.Atlantic, timezone.Newfoundland, timezone.Guyana, timezone.Brazil, timezone.Mid, timezone.Azores, timezone.Gambia, timezone.England, timezone.Tunisia, timezone.France, timezone.South, timezone.Greece, timezone.Iraq, timezone.Armenia, timezone.Pakistan, timezone.india, timezone.Bangladesh, timezone.Thailand, timezone.China, timezone.Singapore, timezone.Japan, timezone.Guam, timezone.Australia, timezone.Solomon, timezone.Fiji, timezone.New_Zealand ],
val = ['-12 1 0', '-11 1 0', '-10 1 0', '-09 1 1', '-08 1 1', '-07 1 0', '-07 2 1', '-06 1 6', '-06 2 1', '-05 1 0', '-05 2 1', '-04 1 0', '-04 2 1' ,'-03.5 1 1', '-03 1 0', '-03 2 1', '-02 1 2', '-01 1 2', '+00 1 0', '+00 2 2', '+01 1 0', '+01 2 2', '+02 1 0', '+02 2 2', '+03 1 0', '+04 1 0', '+05 1 0', '+05.5 1 0', '+06 1 0', '+07 1 0', '+08 1 0', '+08 2 0', '+09 1 0', '+10 1 0', '+10 2 4', '+11 1 0', '+12 1 0', '+12 2 3'];
draw_select('time_zone', str, val, 'SelTime(this.form.time_zone.selectedIndex,this.form)', '<% nvram_selget("time_zone"); %>');
})();
</script>
</td>
</TR>		
</tbody>
</table>
<TR>
<TD>&nbsp;&nbsp;&nbsp;&nbsp;<script>draw_checkbox('_daylight_time', setupcontent.autoadjtime, '1', '' <% nvram_match("daylight_time","1"," ,1"); %>);</script></TD></TR>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
