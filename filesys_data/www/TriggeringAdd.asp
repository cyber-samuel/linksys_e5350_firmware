<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Add a New Port Range Triggering</TITLE>
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
document.title = trigger2.addnew;
function valid_range2(I,start,end,M, idx)
{
if (M=="Port")
{
var bCheckBoxEnable = document.triggering_add.enable.checked;
if ( I.value == "" || I.value == "0")
return true;
}
return valid_rangeNEW(I,start,end,M);
}
function to_apply()
{
var F = document.triggering_add;
/*Wenxuan add edge need*/
var userAgent = navigator.userAgent;
var isEdge = userAgent.indexOf("Edge") > -1;
if(isEdge)
{
if(!valid_range2(F.i_from,1,65535,'Port') || !valid_range2(F.i_to,1,65535,'Port') || !valid_range2(F.o_from,1,65535,'Port') || !valid_range2(F.o_to,1,65535,'Port'))
return;
}
/*Wenxuan add edge need*/	
if(F.name.value == "")
{
alert(errmsg.err64);
F.name.focus();
return;
}
if((parseInt(F.i_from.value) > parseInt(F.i_to.value)))
{
alert(errmsg.err51);
F.i_from.focus();
return;
}
if((parseInt(F.o_from.value) > parseInt(F.o_to.value)))
{
alert(errmsg.err51);
F.o_from.focus();
return;
}
if( parseInt(F.i_from.value) < 1 || parseInt(F.i_from.value) > 65535 || F.i_from.value == "")
{
alert(errmsg.err14 + '[1 - 65535].');
F.i_from.focus();
return false;
}
if( parseInt(F.i_to.value) < 1 || parseInt(F.i_to.value) > 65535 || F.i_to.value == "")
{
alert(errmsg.err14 + '[1 - 65535].');
F.i_to.focus();
return false;
}
if( parseInt(F.o_from.value) < 1 || parseInt(F.o_from.value) > 65535 || F.o_from.value == "")
{
alert(errmsg.err14 + '[1 - 65535].');
F.o_from.focus();
return false;
}
if( parseInt(F.o_to.value) < 1 || parseInt(F.o_to.value) > 65535 || F.o_to.value == "")
{
alert(errmsg.err14 + '[1 - 65535].');
F.o_to.focus();
return false;
}
var new_data = {
name:	F.name.value,
i_from:	F.i_from.value,
i_to:	F.i_to.value,
o_from:	F.o_from.value,
o_to:	F.o_to.value,
en:		F.enable.checked ? 'on' : ''
};
for( var i = 0 ; i < parent.DataList.length ; i++ )
{
if( i == parent.edit_idx ) continue;
if( parent.DataList[i].name == new_data.name )
{
alert(errmsg.repname);
F.name.focus();
return;
}
if( !check_port(parseInt(parent.DataList[i].i_from), parseInt(parent.DataList[i].i_to), parseInt(new_data.i_from), parseInt(new_data.i_to)) )
{
alert(errmsg.err74);
F.i_from.focus();
return;
}
if( !check_port(parseInt(parent.DataList[i].o_from), parseInt(parent.DataList[i].o_to), parseInt(new_data.o_from), parseInt(new_data.o_to)) )
{
alert(errmsg.err74);
F.o_from.focus();
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
var F = document.triggering_add;
if( parent.edit_idx != -1 )
{
F.name.value = parent.DataList[parent.edit_idx].name;
F.i_from.value = parent.DataList[parent.edit_idx].i_from;
F.i_to.value = parent.DataList[parent.edit_idx].i_to;
F.o_from.value = parent.DataList[parent.edit_idx].o_from;
F.o_to.value = parent.DataList[parent.edit_idx].o_to;
F.enable.checked = parent.DataList[parent.edit_idx].en == 'on';
update_checked(F.enable);
}
}
</script>
<BODY onload="init()" bgColor="#808080">
<CENTER>
<form name="triggering_add" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" value="Apply" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="wait_time" value="3" />
<!--input type="hidden" name="next_page" value="DHCP_Static.asp" -->
<script>var PopTitle = trigger2.addnew;</script>
<% web_include_file("pop_Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(portforward.appname)</script></td>
<td>
<input type="text" class="num" maxLength="20" size="19" name="name" id="name"onBlur="valid_name(this,'Name')" />
</td>
</tr>
<tr>
<td><script>Capture(trigger2.trirange)</script></td>
<td>
<input type="text" class="num" maxLength="5" style="width:50px" name="i_from" id="i_from" onBlur="valid_range2(this,1,65535,'Port')" />
<script>Capture(portforward.to)</script>
<input type="text" class="num" maxLength="5" style="width:50px" name="i_to" id="i_to"onBlur="valid_range2(this,1,65535,'Port')" />
</td>
</tr>
<tr>
<td><script>Capture(trigger2.forrange)</script></td>
<td>
<input type="text" class="num" maxLength="5" style="width:50px" name="o_from" id="o_from" onBlur="valid_range2(this,1,65535,'Port')" />
<script>Capture(portforward.to)</script>
<input type="text" class="num" maxLength="5" style="width:50px" name="o_to" id="o_to" onBlur="valid_range2(this,1,65535,'Port')" />
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
