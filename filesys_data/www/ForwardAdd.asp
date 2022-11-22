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
document.title = portforward.addnew;
function Port_Single_Forward_Info(id,Ex_Port, In_Port, Protocol,To_Ip,Enable){
this.id = id;
this.Ex_Port = Ex_Port;
this.In_Port = In_Port;
this.Protocol = Protocol;
this.To_Ip = To_Ip;
this.Enable = Enable;
}	
var Port_Single_Forward_Infos = new Array();
var Port_Single_Forward_Infos_length = 0;
<% Get_Port_Single_Forward_Info("all_list","0"); %>
var lan_ip = '<% nvram_get("lan_ipaddr"); %>';
function valid_range2(I,start,end,M, idx)
{
if (M=="Port")
{
var bCheckBoxEnable = document.forward_add.enable.checked;
if (I.value == "0" || I.value == "")
return true;
}
return valid_rangeNEW(I,start,end,M);
}
function valid_range_ex2(I,start,end,M, idx)
{
if (M=="IP")
{
var bCheckBoxEnable = document.forward_add.enable.checked;
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
var F = document.forward_add;
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
if( tip == F.ip.value )
{
alert(errmsg.err80);
F.ip.focus();
return;
}
if(F.name.value == "")
{
alert(errmsg.err64);
F.name.focus();
return;	
}
if(F.ip.value == "")
{
alert(errmsg.err14 + '['+ 1 + ' - ' + 254 +'].');
F.ip.focus();
return;
}
if((parseInt(F.from.value) > parseInt(F.to.value)))
{
alert(errmsg.err51);
F.from.focus();
return;
}
if(parseInt(F.from.value) < 1 || parseInt(F.from.value) > 65535 || F.from.value == "")
{
alert(errmsg.err14 + '[1 - 65535].');
F.from.focus();
return false;
}
if(parseInt(F.to.value) < 1 || parseInt(F.to.value) > 65535 || F.to.value == "")
{
alert(errmsg.err14 + '[1 - 65535].');
F.to.focus();
return false;
}
var new_data = {
name:	F.name.value,
spo:	F.from.value,
epo:	F.to.value,
pro:	F.pro.options[F.pro.selectedIndex].value,
ip:		F.ip.value,
en:		F.enable.checked ? 'on' : ''
};
for( var i = 0 ; i < parent.DataList.length ; i++ )
{
if( i == parent.edit_idx ) continue;
if( parent.DataList[i].name == new_data.name )
{
alert(errmsg.repname);
return;
}
if( !check_port(parseInt(parent.DataList[i].spo), parseInt(parent.DataList[i].epo), parseInt(new_data.spo), parseInt(new_data.epo)) )
{
if( parent.DataList[i].pro == new_data.pro || parent.DataList[i].pro == 'both' || new_data.pro == 'both' )
{
alert(errmsg.err74);
return;
}
}
}
/* check port whether conflict with `Port Single Forward` configure */
for( var i = 0 ; i < Port_Single_Forward_Infos_length ; i++ )
{
if( Port_Single_Forward_Infos[i].Ex_Port == "" || Port_Single_Forward_Infos[i].In_Port == "" )
continue;
if(
parseInt(new_data.spo) <= parseInt(Port_Single_Forward_Infos[i].Ex_Port) &&
parseInt(new_data.epo) >= parseInt(Port_Single_Forward_Infos[i].Ex_Port) &&
new_data.en == "on" && Port_Single_Forward_Infos[i].Enable == "on" &&
( new_data.pro == "both" || Port_Single_Forward_Infos[i].Protocol == "both" || new_data.pro == Port_Single_Forward_Infos[i].Protocol ) &&
new_data.ip != Port_Single_Forward_Infos[i].To_Ip
)
{
alert("The " + new_data.spo + "-" + new_data.epo + " External Port is conflict!");
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
function init()
{
var F = document.forward_add;
if( parent.edit_idx != -1 )
{
F.name.value = parent.DataList[parent.edit_idx].name;
F.from.value = parent.DataList[parent.edit_idx].spo;
F.to.value = parent.DataList[parent.edit_idx].epo;
set_selected_idx( F.pro, parent.DataList[parent.edit_idx].pro );
F.ip.value = parent.DataList[parent.edit_idx].ip;
F.enable.checked = parent.DataList[parent.edit_idx].en == 'on';
update_checked(F.enable);
}
}
</script>
<BODY onload="init()" bgColor="#808080">
<CENTER>
<form name="forward_add" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" value="Apply" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="wait_time" value="3" />
<!--input type="hidden" name="next_page" value="DHCP_Static.asp" -->
<script>var PopTitle = portforward.addnew;</script>
<% web_include_file("pop_Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(portforward.appname)</script></td>
<td>
<input type="text" class="num" maxLength="20" size="19" name="name" id="name" onBlur="valid_name(this,'Name')" />
</td>
</tr>
<tr>
<td><script>Capture(portforward.start2end)</script></td>
<td>
<input type="text" class="num" maxLength="5" style="width:50px" name="from" id="from" onBlur="valid_range2(this,1,65535,'Port')" />
<script>Capture(portforward.to)</script>
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
<input type="text" class="num" maxLength="3" style="width:40px" name="ip" id="ip"onBlur="valid_range_ex2(this,1,254,'IP')" />
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
