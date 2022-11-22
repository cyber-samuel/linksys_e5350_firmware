<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Port Triggering</TITLE>
<% no_cache(); %>
<% charset(); %>  
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
save:   true,
cancel: true
});
document.title = trigger2.ptrigger;
var close_session = "<% get_session_status(); %>";
var list_max_size = 10;
var DataList = [
{
name:   '<% port_trigger_table("name","0"); %>',
i_from: '<% port_trigger_table("i_from","0"); %>',
i_to:   '<% port_trigger_table("i_to","0"); %>',
o_from: '<% port_trigger_table("o_from","0"); %>',
o_to:   '<% port_trigger_table("o_to","0"); %>',
en:     '<% port_trigger_table("enable","0"); %>'
},
{
name:   '<% port_trigger_table("name","1"); %>',
i_from: '<% port_trigger_table("i_from","1"); %>',
i_to:   '<% port_trigger_table("i_to","1"); %>',
o_from: '<% port_trigger_table("o_from","1"); %>',
o_to:   '<% port_trigger_table("o_to","1"); %>',
en:     '<% port_trigger_table("enable","1"); %>'
},
{
name:   '<% port_trigger_table("name","2"); %>',
i_from: '<% port_trigger_table("i_from","2"); %>',
i_to:   '<% port_trigger_table("i_to","2"); %>',
o_from: '<% port_trigger_table("o_from","2"); %>',
o_to:   '<% port_trigger_table("o_to","2"); %>',
en:     '<% port_trigger_table("enable","2"); %>'
},
{
name:   '<% port_trigger_table("name","3"); %>',
i_from: '<% port_trigger_table("i_from","3"); %>',
i_to:   '<% port_trigger_table("i_to","3"); %>',
o_from: '<% port_trigger_table("o_from","3"); %>',
o_to:   '<% port_trigger_table("o_to","3"); %>',
en:     '<% port_trigger_table("enable","3"); %>'
},
{
name:   '<% port_trigger_table("name","4"); %>',
i_from: '<% port_trigger_table("i_from","4"); %>',
i_to:   '<% port_trigger_table("i_to","4"); %>',
o_from: '<% port_trigger_table("o_from","4"); %>',
o_to:   '<% port_trigger_table("o_to","4"); %>',
en:     '<% port_trigger_table("enable","4"); %>'
},
{
name:   '<% port_trigger_table("name","5"); %>',
i_from: '<% port_trigger_table("i_from","5"); %>',
i_to:   '<% port_trigger_table("i_to","5"); %>',
o_from: '<% port_trigger_table("o_from","5"); %>',
o_to:   '<% port_trigger_table("o_to","5"); %>',
en:     '<% port_trigger_table("enable","5"); %>'
},
{
name:   '<% port_trigger_table("name","6"); %>',
i_from: '<% port_trigger_table("i_from","6"); %>',
i_to:   '<% port_trigger_table("i_to","6"); %>',
o_from: '<% port_trigger_table("o_from","6"); %>',
o_to:   '<% port_trigger_table("o_to","6"); %>',
en:     '<% port_trigger_table("enable","6"); %>'
},
{
name:   '<% port_trigger_table("name","7"); %>',
i_from: '<% port_trigger_table("i_from","7"); %>',
i_to:   '<% port_trigger_table("i_to","7"); %>',
o_from: '<% port_trigger_table("o_from","7"); %>',
o_to:   '<% port_trigger_table("o_to","7"); %>',
en:     '<% port_trigger_table("enable","7"); %>'
},
{
name:   '<% port_trigger_table("name","8"); %>',
i_from: '<% port_trigger_table("i_from","8"); %>',
i_to:   '<% port_trigger_table("i_to","8"); %>',
o_from: '<% port_trigger_table("o_from","8"); %>',
o_to:   '<% port_trigger_table("o_to","8"); %>',
en:     '<% port_trigger_table("enable","8"); %>'
},
{
name:   '<% port_trigger_table("name","9"); %>',
i_from: '<% port_trigger_table("i_from","9"); %>',
i_to:   '<% port_trigger_table("i_to","9"); %>',
o_from: '<% port_trigger_table("o_from","9"); %>',
o_to:   '<% port_trigger_table("o_to","9"); %>',
en:     '<% port_trigger_table("enable","9"); %>'
},
];
/* remove empty data */
var tmpDataList = [];
for( var i = 0 ; i < list_max_size ; i++ )
{
if( DataList[i].en == 'checked' )
DataList[i].en = 'on';
if( DataList[i].name != '' )
tmpDataList.push(DataList[i]);
}
DataList = tmpDataList;
function to_submit(F)
{
for (var i = 0; i < list_max_size ; i++)
{
for(var j = i+1 ; j < list_max_size ; j++)
{
if(((eval("F.i_from"+i+".value") > 0) ||
(eval("F.i_to"+i+".value") > 0)) &&
((eval("F.i_from"+j+".value") > 0) ||
(eval("F.i_to"+j+".value") > 0)))
{
if(!check_port(parseInt(eval("F.i_from"+i+".value")),
parseInt(eval("F.i_to"+i+".value")),
parseInt(eval("F.i_from"+j+".value")),
parseInt(eval("F.i_to"+j+".value"))))
{
alert(errmsg.err74);
return;
}
}
if(((eval("F.o_from"+i+".value") > 0) ||
(eval("F.o_to"+i+".value") > 0)) &&
((eval("F.o_from"+j+".value") > 0) ||
(eval("F.o_to"+j+".value") > 0)))
{
if(!check_port(parseInt(eval("F.o_from"+i+".value")),
parseInt(eval("F.o_to"+i+".value")),
parseInt(eval("F.o_from"+j+".value")),
parseInt(eval("F.o_to"+j+".value"))))
{
alert(errmsg.err74);
return;
}
}
if((parseInt(eval("F.i_from"+i+".value")) > parseInt(eval("F.i_to"+i+".value"))) && eval("F.enable"+i+".checked"))
{ 
alert(errmsg.err51);
eval("F.i_from"+i).focus();
return;
}	
if((parseInt(eval("F.o_from"+i+".value")) > parseInt(eval("F.o_to"+i+".value"))) && eval("F.enable"+i+".checked"))
{ 
alert(errmsg.err51);
eval("F.o_from"+i).focus();
return;
}	
}
}
F.submit_button.value = "Triggering";
F.gui_action.value = "Apply";
ajaxSubmit(0,"false");
}
function init()
{
var swmode = '<% nvram_get("switch_mode");%>';
var protocolWan = '<% nvram_get("wan_proto");%>';
if( swmode == 1)
alert(share.brdgmwn);
else if( protocolWan == "dslite" ){
alert ("These features are not supported when the router is operating in DS-Lite Mode.");
}
var bridge_mode = "<% nvram_get("wbridge_mode");%>";
if(bridge_mode == "1")
alert(wlanbridge.warn);
DarwList();
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
function DarwList()
{
document.forms[0].add_new.disabled = DataList.length >= list_max_size;
edit_idx = -1;
var tbody = document.getElementById("list_tbody");
for( var i = tbody.children.length ; i > 0; i-- )
tbody.removeChild(tbody.children[i-1]);
for( var i = 0 ; i < list_max_size ; i++ )
AddRow(i);
}
function AddRow(idx)
{
var tbody = document.getElementById("list_tbody");
var tr = document.createElement("tr");
var td1 = document.createElement("td");
var td2 = document.createElement("td");
var td3 = document.createElement("td");
var td4 = document.createElement("td");
var td5 = document.createElement("td");
var show = idx < DataList.length;
tr.className = "blue-bg";
tr.setAttribute('onclick', 'EditRow(' + idx + ')');
if( !show ) tr.style.display = 'none';
var name = show ? DataList[idx].name : '';
td1.innerHTML = name;
td1.innerHTML += '<input type="hidden" name="name' + idx + '" value="' + name + '" />';
var i_from = show ? DataList[idx].i_from : '0';
var i_to   = show ? DataList[idx].i_to   : '0';
td2.innerHTML = i_from + '~' + i_to;
td2.innerHTML += '<input type="hidden" name="i_from' + idx + '" value="' + i_from + '" />';
td2.innerHTML += '<input type="hidden" name="i_to' + idx + '" value="' + i_to + '" />';
var o_from = show ? DataList[idx].o_from : '0';
var o_to   = show ? DataList[idx].o_to   : '0';
td3.innerHTML = o_from + '~' + o_to;
td3.innerHTML += '<input type="hidden" name="o_from' + idx + '" value="' + o_from + '" />';
td3.innerHTML += '<input type="hidden" name="o_to' + idx + '" value="' + o_to + '" />';
var en = show ? DataList[idx].en : '';
if( en == 'on' )
{
td4.innerHTML = '<div class="btn-group"><span class="label label-success">' + share.enabled + '</span></div>';
td4.innerHTML += '<input type="checkbox" name="enable' + idx + '" value="on" style="display:none" checked="checked" />';
}
else
{
td4.innerHTML = '<div class="btn-group"><span class="label label-default">' + share.disabled + '</span></div>';
td4.innerHTML += '<input type="checkbox" name="enable' + idx + '" value="on" style="display:none" />';
}
td5.innerHTML = '<button class="btn btn-danger" type="button" onclick="DelRow(event,' + idx + ')">' + sbutton.remove + '</button> ';
tr.appendChild(td1);
tr.appendChild(td2);
tr.appendChild(td3);
tr.appendChild(td4);
tr.appendChild(td5);
tbody.appendChild(tr);
}
var edit_idx = -1;
function EditRow(idx)
{
edit_idx = idx;
open_add();
}
function DelRow(e, idx)
{
e.stopPropagation();
edit_idx = -1;
var list = [];
for( var i = 0 ; i < DataList.length ; i++ )
if( idx != i )
list.push(DataList[i]);
DataList = list;
DarwList();
}
function ModifyRow(data)
{
if( edit_idx == -1 )
DataList.push(data);
else
DataList[edit_idx] = data;
edit_idx = -1;
DarwList();
}
function open_add()
{
var close_session = "<% get_session_status(); %>";
if ( close_session == "1" )
showPopout('TriggeringAdd.asp', '600px');
else
showPopout('TriggeringAdd.asp?session_id=<% nvram_get("session_key"); %>', '600px');
}
</SCRIPT>
</HEAD>
<BODY onload="init()" onbeforeunload = "return checkFormChanged(document.trigger)">
<FORM name="trigger" action="apply.cgi" method="<% get_http_method(); %>">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="port_trigger" value="10" />
<input type="hidden" name="wait_time" value="3" />
<% web_include_file("Top.asp"); %>
<div class="table-box-warpper table-responsive">
<table class="table table-info-bg">
<thead>
<tr>
<th><script>Capture(portforward.appname)</script></th>
<th><script>Capture(trigger2.trirange)</script></th>
<th><script>Capture(trigger2.forrange)</script></th>
<th><script>Capture(share.enabled)</script></th>
<td><script>Capture(share.action)</script></td>
</tr>
</thead>
<tbody id="list_tbody">
<!--
<script>
(function(){
var name = [
'<% port_trigger_table("name","0"); %>',
'<% port_trigger_table("name","1"); %>',
'<% port_trigger_table("name","2"); %>',
'<% port_trigger_table("name","3"); %>',
'<% port_trigger_table("name","4"); %>',
'<% port_trigger_table("name","5"); %>',
'<% port_trigger_table("name","6"); %>',
'<% port_trigger_table("name","7"); %>',
'<% port_trigger_table("name","8"); %>',
'<% port_trigger_table("name","9"); %>'
],
i_from = [
'<% port_trigger_table("i_from","0"); %>',
'<% port_trigger_table("i_from","1"); %>',
'<% port_trigger_table("i_from","2"); %>',
'<% port_trigger_table("i_from","3"); %>',
'<% port_trigger_table("i_from","4"); %>',
'<% port_trigger_table("i_from","5"); %>',
'<% port_trigger_table("i_from","6"); %>',
'<% port_trigger_table("i_from","7"); %>',
'<% port_trigger_table("i_from","8"); %>',
'<% port_trigger_table("i_from","9"); %>'
],
i_to = [
'<% port_trigger_table("i_to","0"); %>',
'<% port_trigger_table("i_to","1"); %>',
'<% port_trigger_table("i_to","2"); %>',
'<% port_trigger_table("i_to","3"); %>',
'<% port_trigger_table("i_to","4"); %>',
'<% port_trigger_table("i_to","5"); %>',
'<% port_trigger_table("i_to","6"); %>',
'<% port_trigger_table("i_to","7"); %>',
'<% port_trigger_table("i_to","8"); %>',
'<% port_trigger_table("i_to","9"); %>'
],
o_from = [
'<% port_trigger_table("o_from","0"); %>',
'<% port_trigger_table("o_from","1"); %>',
'<% port_trigger_table("o_from","2"); %>',
'<% port_trigger_table("o_from","3"); %>',
'<% port_trigger_table("o_from","4"); %>',
'<% port_trigger_table("o_from","5"); %>',
'<% port_trigger_table("o_from","6"); %>',
'<% port_trigger_table("o_from","7"); %>',
'<% port_trigger_table("o_from","8"); %>',
'<% port_trigger_table("o_from","9"); %>'
],
o_to = [
'<% port_trigger_table("o_to","0"); %>',
'<% port_trigger_table("o_to","1"); %>',
'<% port_trigger_table("o_to","2"); %>',
'<% port_trigger_table("o_to","3"); %>',
'<% port_trigger_table("o_to","4"); %>',
'<% port_trigger_table("o_to","5"); %>',
'<% port_trigger_table("o_to","6"); %>',
'<% port_trigger_table("o_to","7"); %>',
'<% port_trigger_table("o_to","8"); %>',
'<% port_trigger_table("o_to","9"); %>'
],
enable = [
'<% port_trigger_table("enable","0"); %>',
'<% port_trigger_table("enable","1"); %>',
'<% port_trigger_table("enable","2"); %>',
'<% port_trigger_table("enable","3"); %>',
'<% port_trigger_table("enable","4"); %>',
'<% port_trigger_table("enable","5"); %>',
'<% port_trigger_table("enable","6"); %>',
'<% port_trigger_table("enable","7"); %>',
'<% port_trigger_table("enable","8"); %>',
'<% port_trigger_table("enable","9"); %>'
];
for( var i = 0 ; i < name.length ; i++ )
{
document.write('<tr>');
document.write('<td>');
document.write('<input type="text" class="num" maxLength="20" size="19" name="name' + i + '" onBlur="valid_name(this,\'Name\')" value="' + name[i] + '" />');
document.write('</td>');
document.write('<td>');
document.write('<input type="text" class="num" maxLength="5" style="width:50px" name="i_from' + i + '" value="' + i_from[i] + '" onBlur="valid_range(this,0,65535,\'Port\')" />');
document.write('&nbsp;' + portforward.to + '&nbsp;');
document.write('<input type="text" class="num" maxLength="5" style="width:50px" name="i_to' + i + '" value="' + i_to[i] + '" onBlur="valid_range(this,0,65535,\'Port\')" />');
document.write('</td>');
document.write('<td>');
document.write('<input type="text" class="num" maxLength="5" style="width:50px" name="o_from' + i + '" value="' + o_from[i] + '" onBlur="valid_range(this,0,65535,\'Port\')" />');
document.write('&nbsp;' + portforward.to + '&nbsp;');
document.write('<input type="text" class="num" maxLength="5" style="width:50px" name="o_to' + i + '" value="' + o_to[i] + '" onBlur="valid_range(this,0,65535,\'Port\')" />');
document.write('</td>');
document.write('<td>');
draw_checkbox('enable' + i, '', 'on', '', enable[i] == 'checked');
document.write('</td>');
document.write('</tr>');
}
})();
</script>
-->
<!--
<tr>
<td>
<input type="text" class="num" maxLength="20" size="19" name="name0" onBlur="valid_name(this,'Name')" value="<% port_trigger_table("name","0"); %>" />
</td>
<td>
<input type="text" class="num" maxLength="5" style="width:50px" name="i_from0" value="<% port_trigger_table("i_from","0"); %>" onBlur="valid_range(this,0,65535,'Port')" />
<script>Capture(portforward.to)</script>
<input type="text" class="num" maxLength="5" style="width:50px" name="i_to0" value="<% port_trigger_table("i_to","0"); %>" onBlur="valid_range(this,0,65535,'Port')" />
</td>
<td>
<input type="text" class="num" maxLength="5" style="width:50px" name="o_from0" value="<% port_trigger_table("o_from","0"); %>" onBlur="valid_range(this,0,65535,'Port')" />
<script>Capture(portforward.to)</script>
<input type="text" class="num" maxLength="5" style="width:50px" name="o_to0" value="<% port_trigger_table("o_to","0"); %>" onBlur="valid_range(this,0,65535,'Port')" />
</td>
<td>
<script>draw_checkbox('enable0', '', 'on', '', '<% port_trigger_table("enable","0"); %>' == 'checked');</script>
</td>
</tr>
-->
</tbody>
<tfoot>
<tr>
<td colspan="6">
<script>draw_button("javascript:open_add()", trigger2.addnew, 'add_new')</script>
</td>
</tr>
</tfoot>
</table>
</div>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
