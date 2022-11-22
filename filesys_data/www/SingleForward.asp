<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Single Port Forwarding</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
save:   true,
cancel: true
});
document.title = apptopmenu.singleport;
var close_session = "<% get_session_status(); %>";
var lan_ip = '<% nvram_get("lan_ipaddr"); %>';
var ip_prefix = '<% prefix_ip_get("lan_ipaddr",1); %>'.replace(/ /g,'');
var NAME = new Array( "FTP","Telnet","SMTP","DNS","TFTP","Finger","HTTP","POP3","NNTP","SNMP","PPTP");
var PORT = new Array( "21","23","25","53","69","79","80","110","119","161","1723");
var PROTO = new Array( "TCP","TCP","TCP","UDP","UDP","TCP","TCP","TCP","TCP","UDP","TCP");
function change_port_protocol(n,index)
{
var i=0;
if ( eval("document.portRange.name"+n+".value") == share.none ) 
{
document.getElementById("Xfrom"+n).innerHTML = "---";
document.getElementById("Xto"+n).innerHTML = "---";
document.getElementById("Xprotocol"+n).innerHTML = "---";
}
else
for(i=0; i<NAME.length; i++){
if ( eval("document.portRange.name"+n+".value") == NAME[i] ) 
{
document.getElementById("Xfrom"+n).innerHTML = PORT[i];
document.getElementById("Xto"+n).innerHTML = PORT[i];
document.getElementById("Xprotocol"+n).innerHTML = PROTO[i];
}
}
}
var list_max_size = 20;
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
var Port_Single_Forward_Names = [
'<% single_forward_table("name","0"); %>',
'<% single_forward_table("name","1"); %>',
'<% single_forward_table("name","2"); %>',
'<% single_forward_table("name","3"); %>',
'<% single_forward_table("name","4"); %>',
'<% single_forward_table("name","5"); %>',
'<% single_forward_table("name","6"); %>',
'<% single_forward_table("name","7"); %>',
'<% single_forward_table("name","8"); %>',
'<% single_forward_table("name","9"); %>',
'<% single_forward_table("name","10"); %>',
'<% single_forward_table("name","11"); %>',
'<% single_forward_table("name","12"); %>',
'<% single_forward_table("name","13"); %>',
'<% single_forward_table("name","14"); %>',
'<% single_forward_table("name","15"); %>',
'<% single_forward_table("name","16"); %>',
'<% single_forward_table("name","17"); %>',
'<% single_forward_table("name","18"); %>',
'<% single_forward_table("name","19"); %>'
];
var DataList = [];
for( var i = 0 ; i < Port_Single_Forward_Infos_length ; i++ )
{
DataList.push({
name:	Port_Single_Forward_Names[i],
epo:	Port_Single_Forward_Infos[i].Ex_Port,
ipo:	Port_Single_Forward_Infos[i].In_Port,
pro:	Port_Single_Forward_Infos[i].Protocol,
ip:		Port_Single_Forward_Infos[i].To_Ip,
en:		Port_Single_Forward_Infos[i].Enable
});
}
function Port_Range_Forward_Info(id,Start_Port, End_Port, Protocol,To_Ip,Enable){
this.id = id;
this.Start_Port=Start_Port;
this.End_Port=End_Port;
this.Protocol=Protocol;
this.To_Ip=To_Ip;
this.Enable=Enable;
}
Port_Range_Forward_Infos = new Array();
Port_Range_Forward_Infos_length = 0;
<% Get_Port_Range_Forward_Info("all_list","0"); %>
function chk_multi_port_range(F,count,starti,xfrom,xto,xip,xpro,xenable)
{
var i=0,j=0,m=0;
var flg = true ;
var errmsgs;
var tport;
for(i=0; i<count; i++)
{
if(i>4)
{
if ( eval(xfrom+parseInt(starti+i)+".value") == 0  || eval(xto+parseInt(starti+i)+".value") == 0 )
continue;
for(j=0;j<Port_Range_Forward_Infos_length;j++)
{
if(Port_Range_Forward_Infos[j].Start_Port=="" || Port_Range_Forward_Infos[j].End_Port=="")
continue;
if( parseInt(eval(xfrom+parseInt(starti+i)+".value"))>=parseInt(Port_Range_Forward_Infos[j].Start_Port) &&
parseInt(eval(xfrom+parseInt(starti+i)+".value"))<=parseInt(Port_Range_Forward_Infos[j].End_Port) &&
eval(xenable+parseInt(starti+i)+".value")=="on" && Port_Range_Forward_Infos[j].Enable=="on" &&
(eval(xpro+parseInt(starti+i)+".value")=="both"||Port_Range_Forward_Infos[j].Protocol=="both"||
eval(xpro+parseInt(starti+i)+".value")==Port_Range_Forward_Infos[j].Protocol)&&
eval(xip+parseInt(starti+i)+".value")!=Port_Range_Forward_Infos[j].To_Ip)
{
errmsgs = "The " + eval(xfrom+parseInt(starti+i)+".value") + " External Port is conflict!";
alert(errmsgs);
flg=false;
break;
}			
}
}
else
{
if ( eval("F.name"+i+".value") == "None" ) continue;
tport=0;
for(m=0; m<NAME.length; m++)
{
if ( eval("F.name"+i+".value") == NAME[m] )
{
tport=PORT[m];
break;
}
}
if(tport>0)
{
for(j=0;j<Port_Range_Forward_Infos_length;j++)
{
if(Port_Range_Forward_Infos[j].Start_Port=="" || Port_Range_Forward_Infos[j].End_Port=="")
continue;
if( tport>=parseInt(Port_Range_Forward_Infos[j].Start_Port) &&
tport<=parseInt(Port_Range_Forward_Infos[j].End_Port) &&
eval(xenable+parseInt(starti+i)+".value")=="on" && Port_Range_Forward_Infos[j].Enable=="on" &&
(Port_Range_Forward_Infos[j].Protocol=="both"||Port_Range_Forward_Infos[j].Protocol=="tcp")&&
eval(xip+parseInt(starti+i)+".value")!=Port_Range_Forward_Infos[j].To_Ip)
{
errmsgs = "The " + tport + " External Port is conflict!";
alert(errmsgs);
flg=false;
break;
}                                                                                                     
}
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
if(i>4)
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
}
return true;
}
function to_submit(F)
{
var i = 0;
var ip = "";
var ip_prefix = "";
var forward_port1 = new Array();
var forward_port2 = new Array();
var forward_port3 = new Array();
var forward_port4 = new Array();
var forward_port5 = new Array();
var forward_port = '<% nvram_get("forward_port"); %>';
for (i = 0; i < 20; i++)
{
ip_prefix = '<% prefix_ip_get("lan_ipaddr",2); %>';
ip = ip_prefix + eval("F.ip"+i).value;
if (ip == lan_ip || ip == (ip_prefix + "255")) {	
alert(errmsg.err72);
eval("F.ip"+i).focus();
return;
}
}
if ( chk_default_port(F) == false ) return ; 
if ( chk_multi_port(F,15,5,"F.from","F.to","F.pro") == false ) return;
if ( chk_multi_port_and_ip(F,15,0,"F.from","F.to","F.ip","F.pro","F.enable")==false) return;
if ( chk_multi_port_range(F,15,0,"F.from","F.to","F.ip","F.pro","F.enable")==false) return;
if(forward_port != "")
{
forward_port4 = forward_port.split(" ");
for(var i=0; i<forward_port4.length; i++)
{
forward_port1 = forward_port4[i].split(":");
forward_port2 = forward_port4[i].split("&");
forward_port3 = forward_port2[0].split(":");
forward_port5 = forward_port1[2];
for(var j=0;j<DataList.length;j++)
{
if((parseInt(eval("F.from"+j+".value")) >= parseInt(forward_port1[3])) && (parseInt(eval("F.from"+j+".value")) <= parseInt(forward_port3[4]))){
if(forward_port5 == 'both' || eval("F.pro"+j+".value") == forward_port5 || eval("F.pro"+j+".value") =='both')
{
alert(errmsg.err74);
return;
}
}
}	
}
}
F.submit_button.value = "SingleForward";
F.gui_action.value = "Apply";
ajaxSubmit(0,"false");
}
function chk_default_port(F)
{
var i,j,k,dport=-1,dip=0;
for (i=0; i<5; i++)
{
if ( eval("F.name"+i+".value") == "None" ) continue;
if ( eval("F.enable"+i+".checked") == false ) continue;
for(k=i+1;k<5;k++)
{
if ( eval("F.name"+i+".value") == eval("F.name"+k+".value") )
{
alert( errmsg.err74);
return false;
}
}
for(j=0; j<NAME.length; j++)
{
if ( eval("F.name"+i+".value") == NAME[j] )
{
if ( dport == j && ( eval("F.ip"+i+".value") == eval("F.ip"+dip+".value") ) )
{
alert ( errmsg.err74 ) ;
return false ;
}
dport = j ;
dip = i ;
break;
}
}
for(k=0; k<15; k++)
{
if ( eval("F.enable"+parseInt(5+k)+".checked") != true ) continue;
if ( eval("F.from"+parseInt(5+k)+".value") == PORT[dport])
{
if(eval("F.pro"+parseInt(5+k)+".value") == PROTO[dport].toLowerCase() 
|| eval("F.pro"+parseInt(5+k)+".value") == "both")
{
alert ( errmsg.err74 ) ;
return false ;
}
}
}
}
return true;
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
var td7 = document.createElement("td");
var show = idx < DataList.length;
tr.className = "blue-bg";
tr.setAttribute('onclick', 'EditRow(' + idx + ')');
if( !show ) tr.style.display = 'none';
var name = show ? DataList[idx].name : '';
td1.innerHTML = name;
td1.innerHTML += '<input type="hidden" name="name' + idx + '" value="' + name + '" />';
var epo = show ? DataList[idx].epo : '0';
td2.innerHTML = epo;
td2.innerHTML += '<input type="hidden" name="from' + idx + '" value="' + epo + '" />';
var ipo = show ? DataList[idx].ipo : '0';
td3.innerHTML = ipo;
td3.innerHTML += '<input type="hidden" name="to' + idx + '" value="' + ipo + '" />';
var pro = show ? DataList[idx].pro : 'both';
if( pro == 'tcp' )
td4.innerHTML = share.tcp;
else if( pro == 'udp' )
td4.innerHTML = share.udp;
else
td4.innerHTML = share.both;
td4.innerHTML += '<input type="hidden" name="pro' + idx + '" value="' + pro + '" />';
var ip = show ? DataList[idx].ip : '0';
if( show ) td5.innerHTML = ip_prefix.replace(/ /g,'') + ip;
td5.innerHTML += '<input type="hidden" name="ip' + idx + '" value="' + ip + '" />';
var en = show ? DataList[idx].en : '';
if( en == 'on' )
{
td6.innerHTML = '<div class="btn-group"><span class="label label-success">' + share.enabled + '</span></div>';
td6.innerHTML += '<input type="checkbox" name="enable' + idx + '" value="on" style="display:none" checked="checked"/>';
}
else
{
td6.innerHTML = '<div class="btn-group"><span class="label label-default">' + share.disabled + '</span></div>';
td6.innerHTML += '<input type="checkbox" name="enable' + idx + '" value="on" style="display:none" />';
}
td7.innerHTML = '<button class="btn btn-danger" type="button" onclick="DelRow(event,' + idx + ')">' + sbutton.remove + '</button> ';
tr.appendChild(td1);
tr.appendChild(td2);
tr.appendChild(td3);
tr.appendChild(td4);
tr.appendChild(td5);
tr.appendChild(td6);
tr.appendChild(td7);
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
showPopout('SingleForwardAdd.asp', '600px');
else
showPopout('SingleForwardAdd.asp?session_id=<% nvram_get("session_key"); %>', '600px');
}
</SCRIPT></HEAD>
<BODY onload="init()" onbeforeunload = "return checkFormChanged(document.portRange)">
<FORM name="portRange" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="forward_single" value="15" />
<input type="hidden" name="wait_time" value="3" />
<% web_include_file("Top.asp"); %>
<div class="table-box-warpper table-responsive">
<table class="table table-info-bg">
<thead>
<tr>
<th><script>Capture(portforward.appname)</script></th>
<th><script>Capture(share.extport)</script></th>
<th><script>Capture(share.intport)</script></th>
<th><script>Capture(share.protocol)</script></th>
<th><script>Capture(share.toipaddr)</script></th>
<th><script>Capture(share.enabled)</script></th>
<td><script>Capture(share.action)</script></td>
</tr>
</thead>
<tbody id="list_tbody">
</tbody>
<tfoot>
<tr>
<td colspan="7">
<script>draw_button("javascript:open_add()", portforward.addnewsing, 'add_new')</script>
</td>
</tr>
</tfoot>
</table>
</div>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
