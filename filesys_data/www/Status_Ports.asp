<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Port Status</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
refresh: 'javascript:window.location.reload()',
});
document.title = "Port Status";
var close_session = "<% get_session_status(); %>";
var port_speed=[
<%get_port_speed();%>
];
function draw_wan_port_speed()
{
var result = "";
result += "<table style='border: 1px solid rgb(41,113,185)' border='1' width='60%'>\n";
result += "<tr>\n";
result += "<td style='border: 1px solid rgb(41,113,185)' align='center' width='25%' height = 20></td>\n";
result += "<td style='border: 1px solid rgb(41,113,185)' align='center' width='25%' height = 20><b>"+ newui.mb +"</b></td>\n";
result += "</tr>\n";
result += "<tr>\n";
result += "<td style='border: 1px solid rgb(41,113,185)' align='center' width='25%' height = 20><b>" + share.internet + "</b></td>\n";
if(port_speed[4] == "1000")
{
result += "<td style='border: 1px solid rgb(41,113,185)' align='center' width='25%' height = 20></td>\n";
}
else if(port_speed[4] == "0")
{
result += "<td style='border: 1px solid rgb(41,113,185)' align='center' width='25%' height = 20></td>\n";
}
else
{
result += "<td style='border: 1px solid rgb(41,113,185)' align='center' width='25%' height = 20><img border='0' src='image/green.gif' width='12' height='8'></td>\n";
}
result += "</tr>\n";
result += "</table>\n";
return result;	
}
function draw_lan_port_speed()
{
var result = "";
var i = 0;
result += "<table style='border: 1px solid rgb(41,113,185)' border='1' width='60%'>\n";
result += "<tr>\n";
result += "<td style='border: solid 1px #2971b9' align='center' width='25%' height = 20></td>\n";
result += "<td style='border: solid 1px #2971b9' align='center' width='25%' height = 20><b>"+ newui.mb +"</b></td>\n";
result += "</tr>\n";
result += "<tr>\n";
for(i = 1; i< 5 ; i++)
{
result += "<td style='border: solid 1px #2971b9' align='center' width='25%' height = 20><b>" + errmsg.err46 + " " + i + "</b></td>\n";
if(port_speed[ i - 1] == "1000")
{
result += "<td style='border: solid  1px #2971b9' align='center' width='25%' height = 20></td>\n";
}
else if(port_speed[i - 1] == "0")
{
result += "<td style='border: solid 1px #2971b9' align='center' width='25%' height = 20></td>\n";
}
else
{
result += "<td style='border: solid 1px #2971b9' align='center' width='25%' height = 20><img border='0' src='image/green.gif' width='12' height='8'></td>\n";
}
result += "</tr>\n";
}
result += "</table>\n";
return result;	
}
function to_submit(F)
{	
F.submit_button.value = "Status_Ports";
F.gui_action.value = "Apply";
ajaxSubmit(0,"false");
}
function init()
{
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
function refresh()
{
if ( close_session == "1" )
{
document.location.replace("Status_Ports.asp");
}
else
{
document.location.replace("Status_Ports.asp?session_id=" + session_key);
}
}
</SCRIPT>
</HEAD>
<BODY onload="init()" onbeforeunload = "return checkFormChanged(document.ports)">
<FORM name="ports" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="gui_action" />
<% web_include_file("Top.asp"); %>
<!--
<div style="margin-left: 20px">
<div class="row">
<div class="col-md-3 col-sm-3 radio-title">&nbsp;</div>
<div class="col-md-3 col-sm-3">
<script>draw_radio('turn_leds', newui.on, '1' <% nvram_match("turn_leds","1",", 0"); %>);</script>
</div>
<div class="col-md-3 col-sm-3">
<script>draw_radio('turn_leds', newui.off, '0' <% nvram_match("turn_leds","0",", 0"); %>);</script>
</div>
</div>
</div>
-->
<script>draw_table(MAINFUN2,newui.inetplink);</script>
<div class="table-box-warpper table-responsive">
<script>document.write(draw_wan_port_speed())</script>
</div>
<br />
<script>draw_table(MAINFUN2,newui.localplink);</script>
<div class="table-box-warpper table-responsive">
<script>document.write(draw_lan_port_speed())</script>
</div>
<% web_include_file("Bottom.asp"); %>
</FORM>
</BODY></HTML>
