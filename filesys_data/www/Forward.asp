<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Port Range Forward</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
save:   true,
cancel: true
});
document.title = apptopmenu.portrange;
var close_session = "<% get_session_status(); %>";
var lan_ip = '<% nvram_get("lan_ipaddr"); %>';
var ip_prefix = '<% prefix_ip_get("lan_ipaddr",1); %>'.replace(/ /g,'');
var list_max_size = 15;
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
function Port_Range_Forward_Info(id,Start_Port, End_Port, Protocol,To_Ip,Enable){
this.id = id;
this.Start_Port=Start_Port;
this.End_Port=End_Port;
this.Protocol=Protocol;
this.To_Ip=To_Ip;
this.Enable=Enable;
}
var Port_Range_Forward_Infos = new Array();
var Port_Range_Forward_Infos_length = 0;
<% Get_Port_Range_Forward_Info("all_list","0"); %>
var Port_Range_Forward_Names = [
'<% port_forward_table("name","0"); %>',
'<% port_forward_table("name","1"); %>',
'<% port_forward_table("name","2"); %>',
'<% port_forward_table("name","3"); %>',
'<% port_forward_table("name","4"); %>',
'<% port_forward_table("name","5"); %>',
'<% port_forward_table("name","6"); %>',
'<% port_forward_table("name","7"); %>',
'<% port_forward_table("name","8"); %>',
'<% port_forward_table("name","9"); %>',
'<% port_forward_table("name","10"); %>',
'<% port_forward_table("name","11"); %>',
'<% port_forward_table("name","12"); %>',
'<% port_forward_table("name","13"); %>',
'<% port_forward_table("name","14"); %>'
];
var DataList = [];
for( var i = 0 ; i < Port_Range_Forward_Infos_length ; i++ )
{
DataList.push({
name:	Port_Range_Forward_Names[i],
spo:	Port_Range_Forward_Infos[i].Start_Port,
epo:	Port_Range_Forward_Infos[i].End_Port,
pro:	Port_Range_Forward_Infos[i].Protocol,
ip:		Port_Range_Forward_Infos[i].To_Ip,
en:		Port_Range_Forward_Infos[i].Enable
});
}
function chk_multi_port_single(F,count,starti,xfrom,xto,xip,xpro,xenable)
{
var i=0,j=0;
var flg = true ;
var errmsgs;
for(i=0; i<count; i++)
{
if ( eval(xfrom+parseInt(starti+i)+".value") == 0  || eval(xto+parseInt(starti+i)+".value") == 0 )
{
if(eval(xenable+parseInt(starti+i)+".checked") == true)
{
alert(errmsg.err14 + '[1 - 65535].');
flg=false;
break;
}
else
continue;
}
for(j=0;j<Port_Single_Forward_Infos_length;j++)
{
if(Port_Single_Forward_Infos[j].Ex_Port=="" || Port_Single_Forward_Infos[j].In_Port=="")
continue;
if( parseInt(eval(xfrom+parseInt(starti+i)+".value"))<=parseInt(Port_Single_Forward_Infos[j].Ex_Port) &&
parseInt(eval(xto+parseInt(starti+i)+".value"))>=parseInt(Port_Single_Forward_Infos[j].Ex_Port) &&
eval(xenable+parseInt(starti+i)+".value")=="on" && Port_Single_Forward_Infos[j].Enable=="on" &&
(eval(xpro+parseInt(starti+i)+".value")=="both"||Port_Single_Forward_Infos[j].Protocol=="both"||
eval(xpro+parseInt(starti+i)+".value")==Port_Single_Forward_Infos[j].Protocol)&&
eval(xip+parseInt(starti+i)+".value")!=Port_Single_Forward_Infos[j].To_Ip)
{
errmsgs = "The " + eval(xfrom+parseInt(starti+i)+".value") +"-"+eval(xto+parseInt(starti+i)+".value") + " External Port is conflict!";
alert(errmsgs);
flg=false;
break;
}
}
if(flg==false) break;
}
return flg;
}
function chk_multi_port_and_ip(F,count,starti,xfrom,xto,xip,xpro,xenable)
{
var i=0,j=0,m=0;
var tport;
for(i=0; i<count; i++)
{
if(eval(xip+parseInt(starti+i)+".value")!=0)
{
if ( eval(xfrom+parseInt(starti+i)+".value") == 0  || eval(xto+parseInt(starti+i)+".value") == 0 )
{
alert(errmsg.err14 + '['+ 1 + ' - ' + 65535 +'].');
return false;
}	
}
}
return true;
}
function to_submit(F)
{
var i,j;
var ip = "";
var ip_prefix = "";
var tip;
i = lan_ip.lastIndexOf('.');
tip = lan_ip.substring(i+1);
var forward_port1 = new Array();
var forward_port2 = new Array();
var forward_port3 = new Array();
var forward_port4 = new Array();
var forward_port5 = new Array();
var forward_port = '<% nvram_get("forward_single"); %>';	
var e = collect_alldata_Fordward();
if (e == false) return;
for (var i = 0; i < list_max_size ;i++)
{
if(tip==eval("F.ip"+i+".value"))
{
alert(errmsg.err80);
return;
}
for(var j = i+1; j < list_max_size ; j++)
{
if(((eval("F.from"+i+".value") > 0) ||
(eval("F.to"+i+".value") > 0)) &&
((eval("F.from"+j+".value") > 0) ||
(eval("F.to"+j+".value") > 0)))
{
if(!check_port(parseInt(eval("F.from"+i+".value")),
parseInt(eval("F.to"+i+".value")),
parseInt(eval("F.from"+j+".value")),
parseInt(eval("F.to"+j+".value"))))
{
if((eval("F.pro"+i+".value") == eval("F.pro"+j+".value")) ||
(eval("F.pro"+i+".value") == "both") ||
(eval("F.pro"+j+".value") == "both"))
{
alert(errmsg.err74);
return;
}
}
}
}
if((parseInt(eval("F.from"+i+".value")) > parseInt(eval("F.to"+i+".value"))) && eval("F.enable"+i+".checked"))
{
alert(errmsg.err51);
eval("F.from"+i).focus();
return;
}
}
if ( chk_multi_port_and_ip(F,15,0,"F.from","F.to","F.ip","F.pro","F.enable")==false) return;
if(chk_multi_port_single(F,15,0,"F.from","F.to","F.ip","F.pro","F.enable")==false) return;
/*Wenxuan add start*/
if(forward_port != "")
{
forward_port4 = forward_port.split(" ");
for(var i=0; i<forward_port4.length; i++)
{
forward_port1 = forward_port4[i].split(":");
forward_port2 = forward_port1[3].split("&#62;");
forward_port5 = forward_port1[2];
for(var j=0;j<DataList.length;j++)
{
if(parseInt(eval("F.from"+j+".value")) <= parseInt(forward_port2[0]) && parseInt(eval("F.to"+j+".value")) >= parseInt(forward_port2[0]))
{
if(forward_port == 'both' || eval("F.pro"+j+".value") == forward_port5 || eval("F.pro"+j+".value") == 'both')
{
alert(errmsg.err74);
return;
}
}
}
}
}
/*Wenxuan add end*/
F.submit_button.value = "Forward";
F.gui_action.value = "Apply";
ajaxSubmit(0,"false");
}
function collect_alldata_Fordward() //ita add 06/10/20 check addr
{
var i=0;
var txtportform,txtto,txtport,txtip,b;
var time=15;
data = new Array();
all_data = new String();
for(i ; i < time ; i++)
{
txtportform =eval("document.portRange.from"+i).value;
txtto = eval("document.portRange.to"+i).value;
txtport = eval("document.portRange.pro"+i).value;
txtip = eval("document.portRange.ip"+i).value;
data[i] = txtportform +"," + txtto +"," + txtport+","+txtip;
all_data = all_data+data[i];
if(i!=15) all_data=all_data+" ";
}
b=check_addr(all_data);
if( b == false) return false;
}
function valid_range2(I,start,end,M, idx)
{
if (M=="Port")
{
var bCheckBoxEnable = eval("document.portRange.enable"+idx).checked;
if (!bCheckBoxEnable)
if (I.value == "0" || I.value == "")
return true;
}
return valid_range(I,start,end,M);
}
function valid_range_ex2(I,start,end,M, idx)
{
if (M=="IP")
{
var bCheckBoxEnable = eval("document.portRange.enable"+idx).checked;
if (!bCheckBoxEnable)
if (I.value == "0" || I.value == "")
return true;
}
return valid_range_ex(I,start,end,M);
}
function valid_range_ex(I,start,end,M)
{
var i;
var tip;
i = lan_ip.lastIndexOf('.');
tip=lan_ip.substring(i+1);
if(tip==I.value)
{
alert(errmsg.err80);
I.value = I.defaultValue;
return false;
}
return valid_range(I,start,end,M);
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
var td6 = document.createElement("td");
var show = idx < DataList.length;
tr.className = "blue-bg";
tr.setAttribute('onclick', 'EditRow(' + idx + ')');
if( !show ) tr.style.display = 'none';
var name = show ? DataList[idx].name : '';
td1.innerHTML = name;
td1.innerHTML += '<input type="hidden" name="name' + idx + '" value="' + name + '" />';
var spo = show ? DataList[idx].spo : '0';
var epo = show ? DataList[idx].epo : '0';
td2.innerHTML = spo + '~' + epo;
td2.innerHTML += '<input type="hidden" name="from' + idx + '" value="' + spo + '" />';
td2.innerHTML += '<input type="hidden" name="to' + idx + '" value="' + epo + '" />';
var pro = show ? DataList[idx].pro : 'both';
if( pro == 'tcp' )
td3.innerHTML = share.tcp;
else if( pro == 'udp' )
td3.innerHTML = share.udp;
else
td3.innerHTML = share.both;
td3.innerHTML += '<input type="hidden" name="pro' + idx + '" value="' + pro + '" />';
var ip = show ? DataList[idx].ip : '0';
if( show ) td4.innerHTML = ip_prefix.replace(/ /g,'') + ip;
td4.innerHTML += '<input type="hidden" name="ip' + idx + '" value="' + ip + '" />';
var en = show ? DataList[idx].en : '';
if( en == 'on' )
{
td5.innerHTML = '<div class="btn-group"><span class="label label-success">' + share.enabled + '</span></div>';
td5.innerHTML += '<input type="checkbox" name="enable' + idx + '" value="on" style="display:none" checked="checked" />';
}
else
{
td5.innerHTML = '<div class="btn-group"><span class="label label-default">' + share.disabled + '</span></div>';
td5.innerHTML += '<input type="checkbox" name="enable' + idx + '" value="on" style="display:none" />';
}
td6.innerHTML = '<button class="btn btn-danger" type="button" onclick="DelRow(event,' + idx + ')">' + sbutton.remove + '</button> ';
tr.appendChild(td1);
tr.appendChild(td2);
tr.appendChild(td3);
tr.appendChild(td4);
tr.appendChild(td5);
tr.appendChild(td6);
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
showPopout('ForwardAdd.asp', '600px');
else
showPopout('ForwardAdd.asp?session_id=<% nvram_get("session_key"); %>', '600px');
}
</SCRIPT></HEAD>
<BODY onload="init()" onbeforeunload = "return checkFormChanged(document.portRange)">
<FORM name="portRange" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button">
<input type="hidden" name="gui_action">
<input type="hidden" name="forward_port" value="15">
<input type="hidden" name="wait_time" value="3">
<% web_include_file("Top.asp"); %>
<div class="table-box-warpper table-responsive">
<table class="table table-info-bg">
<thead>
<tr>
<td><script>Capture(portforward.appname)</script></td>
<td><script>Capture(portforward.start2end)</script></td>
<td><script>Capture(share.protocol)</script></td>
<td><script>Capture(share.toipaddr)</script></td>
<td><script>Capture(share.enabled)</script></td>
<td><script>Capture(share.action)</script></td>
</tr>
</thead>
<tbody id="list_tbody">
<!--
<script>
(function(){
var name = [
'<% port_forward_table("name","0"); %>',
'<% port_forward_table("name","1"); %>',
'<% port_forward_table("name","2"); %>',
'<% port_forward_table("name","3"); %>',
'<% port_forward_table("name","4"); %>',
'<% port_forward_table("name","5"); %>',
'<% port_forward_table("name","6"); %>',
'<% port_forward_table("name","7"); %>',
'<% port_forward_table("name","8"); %>',
'<% port_forward_table("name","9"); %>',
'<% port_forward_table("name","10"); %>',
'<% port_forward_table("name","11"); %>',
'<% port_forward_table("name","12"); %>',
'<% port_forward_table("name","13"); %>',
'<% port_forward_table("name","14"); %>'
],
s_from = [
'<% port_forward_table("from","0"); %>',
'<% port_forward_table("from","1"); %>',
'<% port_forward_table("from","2"); %>',
'<% port_forward_table("from","3"); %>',
'<% port_forward_table("from","4"); %>',
'<% port_forward_table("from","5"); %>',
'<% port_forward_table("from","6"); %>',
'<% port_forward_table("from","7"); %>',
'<% port_forward_table("from","8"); %>',
'<% port_forward_table("from","9"); %>',
'<% port_forward_table("from","10"); %>',
'<% port_forward_table("from","11"); %>',
'<% port_forward_table("from","12"); %>',
'<% port_forward_table("from","13"); %>',
'<% port_forward_table("from","14"); %>'
],
e_to = [
'<% port_forward_table("to","0"); %>',
'<% port_forward_table("to","1"); %>',
'<% port_forward_table("to","2"); %>',
'<% port_forward_table("to","3"); %>',
'<% port_forward_table("to","4"); %>',
'<% port_forward_table("to","5"); %>',
'<% port_forward_table("to","6"); %>',
'<% port_forward_table("to","7"); %>',
'<% port_forward_table("to","8"); %>',
'<% port_forward_table("to","9"); %>',
'<% port_forward_table("to","10"); %>',
'<% port_forward_table("to","11"); %>',
'<% port_forward_table("to","12"); %>',
'<% port_forward_table("to","13"); %>',
'<% port_forward_table("to","14"); %>'
],
tcp = [
'<% port_forward_table("sel_tcp","0"); %>',
'<% port_forward_table("sel_tcp","1"); %>',
'<% port_forward_table("sel_tcp","2"); %>',
'<% port_forward_table("sel_tcp","3"); %>',
'<% port_forward_table("sel_tcp","4"); %>',
'<% port_forward_table("sel_tcp","5"); %>',
'<% port_forward_table("sel_tcp","6"); %>',
'<% port_forward_table("sel_tcp","7"); %>',
'<% port_forward_table("sel_tcp","8"); %>',
'<% port_forward_table("sel_tcp","9"); %>',
'<% port_forward_table("sel_tcp","10"); %>',
'<% port_forward_table("sel_tcp","11"); %>',
'<% port_forward_table("sel_tcp","12"); %>',
'<% port_forward_table("sel_tcp","13"); %>',
'<% port_forward_table("sel_tcp","14"); %>'
],
udp = [
'<% port_forward_table("sel_udp","0"); %>',
'<% port_forward_table("sel_udp","1"); %>',
'<% port_forward_table("sel_udp","2"); %>',
'<% port_forward_table("sel_udp","3"); %>',
'<% port_forward_table("sel_udp","4"); %>',
'<% port_forward_table("sel_udp","5"); %>',
'<% port_forward_table("sel_udp","6"); %>',
'<% port_forward_table("sel_udp","7"); %>',
'<% port_forward_table("sel_udp","8"); %>',
'<% port_forward_table("sel_udp","9"); %>',
'<% port_forward_table("sel_udp","10"); %>',
'<% port_forward_table("sel_udp","11"); %>',
'<% port_forward_table("sel_udp","12"); %>',
'<% port_forward_table("sel_udp","13"); %>',
'<% port_forward_table("sel_udp","14"); %>'
],
both = [
'<% port_forward_table("sel_both","0"); %>',
'<% port_forward_table("sel_both","1"); %>',
'<% port_forward_table("sel_both","2"); %>',
'<% port_forward_table("sel_both","3"); %>',
'<% port_forward_table("sel_both","4"); %>',
'<% port_forward_table("sel_both","5"); %>',
'<% port_forward_table("sel_both","6"); %>',
'<% port_forward_table("sel_both","7"); %>',
'<% port_forward_table("sel_both","8"); %>',
'<% port_forward_table("sel_both","9"); %>',
'<% port_forward_table("sel_both","10"); %>',
'<% port_forward_table("sel_both","11"); %>',
'<% port_forward_table("sel_both","12"); %>',
'<% port_forward_table("sel_both","13"); %>',
'<% port_forward_table("sel_both","14"); %>'
],
ip = [
'<% port_forward_table("ip","0"); %>',
'<% port_forward_table("ip","1"); %>',
'<% port_forward_table("ip","2"); %>',
'<% port_forward_table("ip","3"); %>',
'<% port_forward_table("ip","4"); %>',
'<% port_forward_table("ip","5"); %>',
'<% port_forward_table("ip","6"); %>',
'<% port_forward_table("ip","7"); %>',
'<% port_forward_table("ip","8"); %>',
'<% port_forward_table("ip","9"); %>',
'<% port_forward_table("ip","10"); %>',
'<% port_forward_table("ip","11"); %>',
'<% port_forward_table("ip","12"); %>',
'<% port_forward_table("ip","13"); %>',
'<% port_forward_table("ip","14"); %>'
],
enable = [
'<% port_forward_table("enable","0"); %>',
'<% port_forward_table("enable","1"); %>',
'<% port_forward_table("enable","2"); %>',
'<% port_forward_table("enable","3"); %>',
'<% port_forward_table("enable","4"); %>',
'<% port_forward_table("enable","5"); %>',
'<% port_forward_table("enable","6"); %>',
'<% port_forward_table("enable","7"); %>',
'<% port_forward_table("enable","8"); %>',
'<% port_forward_table("enable","9"); %>',
'<% port_forward_table("enable","10"); %>',
'<% port_forward_table("enable","11"); %>',
'<% port_forward_table("enable","12"); %>',
'<% port_forward_table("enable","13"); %>',
'<% port_forward_table("enable","14"); %>'
];
var prefix = '<% prefix_ip_get("lan_ipaddr",1); %>',
pro_str = [share.tcp, share.udp, share.both],
pro_val = ['tcp', 'udp', 'both'],
pro_sel;
for( var i = 0 ; i < name.length ; i++ )
{
pro_sel = pro_val[2];
document.write('<tr class="blue-bg">');
document.write('<td>');
document.write('<input type="text" class="num" maxLength="20" size="19" name="name' + i + '" value="' + name[i] + '" onBlur="valid_name(this,\'Name\')" />');
document.write('</td>');
document.write('<td>');
document.write('<input type="text" class="num" maxLength="5" style="width:50px" name="from' + i + '" value="' + s_from[i] + '" onBlur="valid_range2(this,1,65535,\'Port\',' + i + ')" />');
document.write('&nbsp;' + portforward.to + '&nbsp;');
document.write('<input type="text" class="num" maxLength="5" style="width:50px" name="to' + i + '" value="' + e_to[i] + '" onBlur="valid_range2(this,1,65535,\'Port\',' + i + ')" />');
document.write('</td>');
document.write('<td>');
if( both[i] == 'selected' ) pro_sel = pro_val[2];
else if( udp[i] == 'selected' ) pro_sel = pro_val[1];
else if( tcp[i] == 'selected' ) pro_sel = pro_val[0];
draw_select('pro' + i, pro_str, pro_val, '', pro_sel).width('auto');
document.write('</td>');
document.write('<td dir="ltr">');
document.write(prefix + '&nbsp;<input type="text" class="num" maxLength="3" style="width:40px" name="ip' + i + '" value="' + ip[i] + '" onBlur="valid_range_ex2(this,1,254,\'IP\',' + i + ')" />');
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
<input type="text" class="num" maxLength="20" size="19" name="name0" onBlur="valid_name(this,'Name')" value="<% port_forward_table("name","0"); %>" />
</td>
<td>
<input type="text" class="num" maxLength="5" style="width:50px" name="from0" value="<% port_forward_table("from","0"); %>" onBlur="valid_range2(this,1,65535,'Port',0)" />
<script>Capture(portforward.to)</script>
<input type="text" class="num" maxLength="5" style="width:50px" name="to0" value="<% port_forward_table("to","0"); %>" onBlur="valid_range2(this,1,65535,'Port',0)" />
</td>
<td>
<script>
(function(){
var str = [share.tcp, share.udp, share.both],
val = ['tcp', 'udp', 'both'],
sel = val[2];
if( '<% port_forward_table("sel_tcp","0"); %>' == 'selected' )
sel = val[0];
else if( '<% port_forward_table("sel_udp","0"); %>' == 'selected' )
sel = val[1];
else if( '<% port_forward_table("sel_both","0"); %>' == 'selected' )
sel = val[2];
draw_select('pro0', str, val, '', sel).width('auto');
})();
</script>
</td>
<td>
<% prefix_ip_get("lan_ipaddr",1); %>
<input type="text" class="num" maxLength="3" style="width:40px" name="ip0" value="<% port_forward_table("ip","0"); %>" onBlur="valid_range_ex2(this,1,254,'IP',0)" />
</td>
<td>
<script>draw_checkbox('enable0', '', 'on', '', '<% port_forward_table("enable","0"); %>' == 'checked');</script>
</td>
</tr>
-->
</tbody>
<tfoot>
<tr>
<td colspan="6">
<script>draw_button("javascript:open_add()", portforward.addnew, 'add_new')</script>
</td>
</tr>
</tfoot>
</table>
</div>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
