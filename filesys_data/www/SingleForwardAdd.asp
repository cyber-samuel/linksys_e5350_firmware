<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Add a New Port Range Forwarding</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("pop_filelink.asp"); %>
<SCRIPT language="Javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capsec.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/share.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/help.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capapp.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capasg.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capsetup.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capstatus.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capwrt54g.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capadmin.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/timezone.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/layout.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/storage.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/ddns.js"></SCRIPT>
<script language="JavaScript">
setFormActions({
'hportser2.submit':    'javascript:to_apply()',
close:   'javascript:to_close()'
});
document.title = portforward.addnewsing;
function Port_Range_Forward_Info(id,Start_Port, End_Port, Protocol,To_Ip,Enable){
this.id = id;
this.Start_Port = Start_Port;
this.End_Port = End_Port;
this.Protocol = Protocol;
this.To_Ip = To_Ip;
this.Enable = Enable;
}
var Port_Range_Forward_Infos = new Array();
var Port_Range_Forward_Infos_length = 0;
<% Get_Port_Range_Forward_Info("all_list","0"); %>
var lan_ip = '<% nvram_get("lan_ipaddr"); %>';
function valid_range2(I,start,end,M, idx)
{
if (M=="Port")
{
var bCheckBoxEnable = document.single_add.enable.checked;
if (!bCheckBoxEnable)
if (I.value == "")
return true;
}
return valid_rangeNEW(I,start,end,M);
}
function valid_range_ex2(I,start,end,M, idx)
{
if (M=="IP")
{
var bCheckBoxEnable = document.single_add.enable.checked;
if (!bCheckBoxEnable)
if (I.value == "")
return true;
}
return valid_range_ex(I,start,end,M);
}
function valid_range_ex(I,start,end,M)
{
var i;
var tip;
i = lan_ip.lastIndexOf('.');
tip = lan_ip.substring(i+1);
if( tip == I.value )
{
alert(errmsg.err80);
window.onblur=document.getElementById(I.id).blur();	
I.value = I.defaultValue;
return false;
}
return valid_rangeNEW(I,start,end,M);
}
function to_apply()
{
var F = document.single_add;
/*Wenxuan add edge need*/
var userAgent = navigator.userAgent;
var isEdge = userAgent.indexOf("Edge") > -1;
if(isEdge)
{
if(!valid_range2(F.from,1,65535,'Port') || !valid_range2(F.to,1,65535,'Port') || !valid_range_ex2(F.ip,1,254,'IP'))
return;
}
/*Wenxuan add edge need*/
var tip = lan_ip.split('.').pop();
if( F.ip.value == tip || F.ip.value == '255')
{
alert(errmsg.err72);
F.ip.focus();
return;
}
if(F.name.value == "")
{
alert(errmsg.err64);
F.name.focus();
return;
}
if(F.from.value == "")
{
alert(errmsg.err14 + '['+ 1 + ' - ' + 65535 +'].');
F.from.focus();
return;
}	
if(F.to.value == "")
{
alert(errmsg.err14 + '['+ 1 + ' - ' + 65535 +'].');
F.to.focus();
return;
}
if(F.ip.value == "")
{
alert(errmsg.err14 + '['+ 1 + ' - ' + 254 +'].');
F.ip.focus();
return;
}
if(
parseInt(F.from.value) < 1 || parseInt(F.from.value) > 65535
|| parseInt(F.to.value) < 1 || parseInt(F.to.value) > 65535
)
{
alert(errmsg.err14 + '[1 - 65535].');
return false;
}
var new_data = {
name:	F.name.value,
epo:	F.from.value,
ipo:	F.to.value,
pro:	F.pro.options[F.pro.selectedIndex].value,
ip:		F.ip.value,
en:		F.enable.checked ? 'on' : ''
};
for( var i = 0 ; i < parent.DataList.length ; i++ )
{
if( i == parent.edit_idx ) continue;
/* `Application Name` can not duplicate */
if( parent.DataList[i].name == new_data.name )
{
alert(errmsg.repname);
return;
}
/* `External Port` can not be equal in matched `Protocol` */
if( parent.DataList[i].pro == new_data.pro || parent.DataList[i].pro == 'both' || new_data.pro == 'both' )
{
if( parseInt(parent.DataList[i].epo) == new_data.epo )
{
alert(errmsg.err74);
return;
}
}
}
/* check port whether conflict with `Port Range Forwarding` configure */
for( var i = 0 ; i < Port_Range_Forward_Infos_length ; i++ )
{
if( Port_Range_Forward_Infos[i].Start_Port == "" || Port_Range_Forward_Infos[i].End_Port == "" )
continue;
if(
parseInt(new_data.epo) <= parseInt(Port_Range_Forward_Infos[i].Start_Port) &&
parseInt(new_data.epo) >= parseInt(Port_Range_Forward_Infos[i].End_Port) &&
new_data.en == "on" && Port_Range_Forward_Infos[i].Enable == "on" &&
( new_data.pro == "both" || Port_Range_Forward_Infos[i].Protocol == "both" || new_data.pro == Port_Range_Forward_Infos[i].Protocol ) &&
new_data.ip != Port_Range_Forward_Infos[i].To_Ip
)
{
alert("The " + new_data.epo + " External Port is conflict!");
return;
}
}
parent.ModifyRow(new_data);
closePopout();
}
function to_close()
{
parent.edit_idx = -1;
}
function isMatchDefault(data)
{
for( var i = 0 ; i < parent.NAME.length ; i++ )
{
if( data.name != parent.NAME[i] )
continue;
if( data.epo != parent.PORT[i] )
continue;
if( data.ipo != parent.PORT[i] )
continue;
if( data.pro != parent.PROTO[i].toLocaleLowerCase() )
continue;
return true;
}
return false;
}
function init()
{
var F = document.single_add;
if( parent.edit_idx != -1 )
{
var matched = isMatchDefault(parent.DataList[parent.edit_idx]);
if( matched )
{
set_selected_idx( F.app, parent.DataList[parent.edit_idx].name );
selApp();
}
else
set_selected_idx( F.app, '-1' );
F.name.value = parent.DataList[parent.edit_idx].name;
F.from.value = parent.DataList[parent.edit_idx].epo;
F.to.value = parent.DataList[parent.edit_idx].ipo;
set_selected_idx( F.pro, parent.DataList[parent.edit_idx].pro );
F.ip.value = parent.DataList[parent.edit_idx].ip;
F.enable.checked = parent.DataList[parent.edit_idx].en == 'on';
update_checked(F.enable);
}
}
function selApp()
{
var F = document.single_add,
i = F.app.selectedIndex,
v = F.app.options[i].value;
if( v == '-1' )
{
F.name.value = '';
F.from.value = 0;
F.to.value = 0;
set_selected_idx( F.pro, 'both' );
F.name.disabled = false;
F.from.disabled = false;
F.to.disabled = false;
F.pro.disabled = false;
}
else
{
F.name.value = v;
F.from.value = parent.PORT[i];
F.to.value = parent.PORT[i];
set_selected_idx( F.pro, parent.PROTO[i].toLocaleLowerCase() );
F.name.disabled = true;
F.from.disabled = true;
F.to.disabled = true;
F.pro.disabled = true;
}
update_selected(F.pro);
}
</script>
<BODY onload="init()" bgColor="#808080">
<CENTER>
<form name="single_add" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" value="Apply" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="wait_time" value="3" />
<!--input type="hidden" name="next_page" value="DHCP_Static.asp" -->
<script>var PopTitle = portforward.addnewsing;</script>
<% web_include_file("pop_Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(portforward.app)</script></td>
<td>
<script>
(function(){
var str = parent.NAME.slice(),
val = parent.NAME.slice();
str.push(share.mtumanual);
val.push('-1');
draw_select('app', str, val, 'selApp()', '-1');
})();
</script>
</td>
</tr>
<tr>
<td><script>Capture(portforward.appname)</script></td>
<td>
<input type="text" class="num" maxLength="20" size="19" name="name" onBlur="valid_name(this,'Name')" />
</td>
</tr>
<tr>
<td><script>Capture(share.extport)</script></td>
<td>
<input type="text" class="num" maxLength="5" style="width:50px" name="from" id= "from" onBlur="valid_range2(this,1,65535,'Port')" />
</td>
</tr>
<tr>
<td><script>Capture(share.intport)</script></td>
<td>
<input type="text" class="num" maxLength="5" style="width:50px" name="to" id="to" onBlur="valid_range2(this,1,65535,'Port')" />
</td>
</tr>
<tr>
<td><script>Capture(share.protocol)</script></td>
<td>
<script>
(function(){
var str = [share.tcp, share.udp, share.both],
val = ['tcp', 'udp', 'both'],
sel = val[2];
draw_select('pro', str, val, '', sel);
})();
</script>
</td>
</tr>
<tr>
<td><script>Capture(share.toipaddr)</script></td>
<td>
<% prefix_ip_get("lan_ipaddr",1); %>
<input type="text" class="num" maxLength="3" style="width:40px" name="ip" id="ip" onBlur="valid_range_ex2(this,1,254,'IP')" />
</td>
</tr>
<tr>
<td>
<script>draw_checkbox('enable', share.enabled, 'on');</script>
</td>
</tr>
</tbody>
</table>
<% web_include_file("pop_Bottom.asp"); %>
</FORM></CENTER></BODY></HTML>
