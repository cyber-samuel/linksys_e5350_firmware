<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>>
<HEAD>
<TITLE>vlan</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
save:   true,
cancel: true
});
document.title = topmenu.vlansetup;
var close_session = "<% get_session_status(); %>";
var VLAN_ENTRY = 5;
var ele_id_name = new Array("desc_", "id_", "net_", "port1_", "port2_", "port3_", "port4_","enb_");
var ele_item = {"desc":0, "id":1, "net":2, "port1":3, "port2":4, "port3":5, "port4":6, "enb":7};
var port_option = new Array(vlan.untagged, vlan.tagged, vlan.excluded);
var vlan_info = new Array();
<% get_vlan_list("all_list","0"); %>
function getEle(id)
{
return (document.getElementById(id));
}
function init_port(obj, idx, value)
{
var j = 0;
for(j=0;j<port_option.length;j++)
{
if( port_option[j] == value )
obj.selectedIndex = j;
}
update_selected(obj);
}
function init_data()
{
var i=0;
if(vlanCnt <= 0){
getEle(ele_id_name[ele_item.desc]+'0_span').innerHTML = vlan.defInt;
getEle(ele_id_name[ele_item.desc]+'0').value = vlan.defInt;
init_port(getEle(ele_id_name[ele_item.net]+'0'), 0, port_option[0]);
} else {	
for(i=0;i<vlanCnt;i++)
{
if(i == 0)
getEle(ele_id_name[ele_item.desc]+i+'_span').innerHTML = vlan_info[i][ele_item.desc];
getEle(ele_id_name[ele_item.desc]+i).value = vlan_info[i][ele_item.desc];
getEle(ele_id_name[ele_item.enb]+i).checked = vlan_info[i][ele_item.enb] == 'on';
getEle(ele_id_name[ele_item.id]+i).value = vlan_info[i][ele_item.id];
init_port(getEle(ele_id_name[ele_item.net]+i), i, vlan_info[i][ele_item.net]);
if(i!=0)
{
init_port(getEle(ele_id_name[ele_item.port1]+i), i, vlan_info[i][ele_item.port1]);
init_port(getEle(ele_id_name[ele_item.port2]+i), i, vlan_info[i][ele_item.port2]);
init_port(getEle(ele_id_name[ele_item.port3]+i), i, vlan_info[i][ele_item.port3]);
init_port(getEle(ele_id_name[ele_item.port4]+i), i, vlan_info[i][ele_item.port4]);
}
}
}
}
function check_default_data(idx)
{
var def_val = '';
if( idx == 0 ) def_val = vlan.defInt;
if( getEle(ele_id_name[ele_item.desc]+idx).value != def_val )
return true;
if( getEle(ele_id_name[ele_item.enb]+idx).checked )
return true;
if( getEle(ele_id_name[ele_item.id]+idx).value != '' )
return true;
var sel_idx = 2;
if( idx == 0 ) sel_idx = 0;
if( getEle(ele_id_name[ele_item.net]+idx).selectedIndex != sel_idx )
return true;
if( idx == 0 )
return false;
if( getEle(ele_id_name[ele_item.port1]+idx).selectedIndex != 2 )
return true;
if( getEle(ele_id_name[ele_item.port2]+idx).selectedIndex != 2 )
return true;
if( getEle(ele_id_name[ele_item.port3]+idx).selectedIndex != 2 )
return true;
if( getEle(ele_id_name[ele_item.port4]+idx).selectedIndex != 2 )
return true;
return false;
var data="";
data = "";
data += getEle(ele_id_name[ele_item.desc]+idx).value;
data += ",";
data += getEle(ele_id_name[ele_item.id]+idx).value;
data += ",";
data += getEle(ele_id_name[ele_item.net]+idx).selectedIndex;
data += ",";
if(idx==0)
data+="1,1,1,1";
else
{
data += getEle(ele_id_name[ele_item.port1]+idx).selectedIndex;
data += ",";
data += getEle(ele_id_name[ele_item.port2]+idx).selectedIndex;
data += ",";
data += getEle(ele_id_name[ele_item.port3]+idx).selectedIndex;
data += ",";
data += getEle(ele_id_name[ele_item.port4]+idx).selectedIndex;
}
if(data != ",,2,2,2,2,2")
return true;
if(getEle(ele_id_name[ele_item.enb]+idx).checked==true)
return true;
return false;
}
function check_vlan_port(ele)
{
var i=0, obj, flag=false;
if(ele==ele_item.net){
for(i=0;i<VLAN_ENTRY;i++)
{
obj = getEle(ele_id_name[ele]+i);
if(obj.value == port_option[0])
{
if(flag == true){
alert(errmsg.err104);
obj.focus();
return false;
}
flag = true;
}
}
return true;
}
else{
for(i=1;i<VLAN_ENTRY;i++)
{
obj = getEle(ele_id_name[ele]+i);
if(obj.value != port_option[2])
{
if(flag == true){
alert(errmsg.err104);
obj.focus();
return false;
}
flag = true;
}
}
return true;
}
}
function check_repeated_vlan()
{
var i=0, j=0, data="", tmpData="";
for(i=0;i<VLAN_ENTRY;i++)
{
var vlanDesc = getEle(ele_id_name[ele_item.desc]+i).value;
if(vlanDesc != ""){
data += getEle(ele_id_name[ele_item.desc]+i).value;
data += ",";
data += getEle(ele_id_name[ele_item.id]+i).value;
data += ",";
data += getEle(ele_id_name[ele_item.net]+i).selectedIndex;
data += ",";
if(i==0)
data+="1,1,1,1";
else
{
data += getEle(ele_id_name[ele_item.port1]+i).selectedIndex;
data += ",";
data += getEle(ele_id_name[ele_item.port2]+i).selectedIndex;
data += ",";
data += getEle(ele_id_name[ele_item.port3]+i).selectedIndex;
data += ",";
data += getEle(ele_id_name[ele_item.port4]+i).selectedIndex;
}
for(j=i+1;j<VLAN_ENTRY;j++)
{
tmpData += getEle(ele_id_name[ele_item.desc]+j).value;
tmpData += ",";
tmpData += getEle(ele_id_name[ele_item.id]+j).value;
tmpData += ",";
tmpData += getEle(ele_id_name[ele_item.net]+j).selectedIndex;
tmpData += ",";
tmpData += getEle(ele_id_name[ele_item.port1]+j).selectedIndex;
tmpData += ",";
tmpData += getEle(ele_id_name[ele_item.port2]+j).selectedIndex;
tmpData += ",";
tmpData += getEle(ele_id_name[ele_item.port3]+j).selectedIndex;
tmpData += ",";
tmpData += getEle(ele_id_name[ele_item.port4]+j).selectedIndex;
if(((data != ",,2,2,2,2,2")) && (data == tmpData)){
alert(errmsg.err105);
getEle(ele_id_name[ele_item.desc]+j).focus();
return false;
}
if((getEle(ele_id_name[ele_item.id]+i).value ==  getEle(ele_id_name[ele_item.id]+j).value)&&(getEle(ele_id_name[ele_item.id]+i).value != "")){
alert(errmsg.err106);
getEle(ele_id_name[ele_item.id]+j).focus();
return false;
}
tmpData = "";
}
data = "";
}
}
return true;
}
function pre_submit()
{
var i = 0, data="", obj, objVal;
var reg = /^[0-9]*$/;
if(check_repeated_vlan() == false)
return false;
for(i=0;i<VLAN_ENTRY;i++)
{
if(check_default_data(i) == false)
continue;
objVal = getEle(ele_id_name[ele_item.desc]+i).value;
if( objVal == "" ){
alert(errmsg.err107);
getEle(ele_id_name[ele_item.desc]+i).focus();
return false;
}
obj = getEle(ele_id_name[ele_item.id]+i);
if((obj.value == "") || (parseInt(obj.value)<3 || parseInt(obj.value)>4094) || (obj.value!="" && reg.test(obj.value)==false)){
/*if((i==0)&&getEle(ele_id_name[ele_item.enb]+i).checked == false){
continue;
}*/
alert(errmsg.err108);
obj.focus();
return false;
}
}
if((check_vlan_port(ele_item.net) == false) || (check_vlan_port(ele_item.port1) == false) || (check_vlan_port(ele_item.port2) == false) || 
(check_vlan_port(ele_item.port3) == false) || (check_vlan_port(ele_item.port4) == false))
return false;
return true;
}
function draw_port(name, def)
{
var sele = "";
document.write("	<TD height=25>");
document.write("		<SELECT name='"+name+"' id='"+name+"' style='width:65px;font-size: 7pt' onChange='' >");
for(j=0;j<port_option.length;j++)
{
if(j == def)
sele = "selected";
else
sele = "";
document.write("			<OPTION value='"+port_option[j]+"' "+sele+" >"+port_option[j]+"</OPTION>");
}
document.write("		</SELECT>");
document.write("	</TD>");
}
function to_submit(F)
{
var ret = pre_submit();
if(ret == false)
return;
F.vlan_info.value = VLAN_ENTRY;
F.submit_button.value = "vlan";
F.gui_action.value = "Apply";
ajaxSubmit(65,"afterSuccess");
}
function init() 
{
var swmode = '<% nvram_get("switch_mode");%>';
if( swmode == 1)
alert(share.brdgmwn);
var close_session = "<% get_session_status(); %>";
if ( close_session == "1" )
{
document.forms[0].action= "apply.cgi";
}
else
{
document.forms[0].action= "apply.cgi?session_id=<% nvram_get("session_key"); %>";
}
init_data();
setInitFormData(function(){
to_submit(document.forms[0])
});
}
</SCRIPT>
</HEAD>
<BODY onload="init()"onbeforeunload = "return checkFormChanged(document.vlan)">
<FORM id="vlan" name="vlan" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<!--<input type="hidden" name="change_action" />-->
<input type="hidden" name="submit_type" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="wait_time" value="3" />
<input type="hidden" name="vlan_info" value="0" />
<% web_include_file("Top.asp"); %>
<div class="table-box-warpper table-responsive">
<table class="table table-info-bg table-bordered">
<thead>
<th><script>Capture(vlan.tabledesc)</script></th>
<th><script>Capture(vlan.tableenable)</script></th>
<th><script>Capture(vlan.tablevlanid)</script></th>
<th><script>Capture(vlan.tableinternet)</script></th>
<th><script>Capture(vlan.tableport1)</script></th>
<th><script>Capture(vlan.tableport2)</script></th>
<th><script>Capture(vlan.tableport3)</script></th>
<th><script>Capture(vlan.tableport4)</script></th>
<thead>
<tbody>
<script>
(function(){
var str, sel, desc, vlid, inet, pot1, pot2, pot3, pot4;
for( var i = 0 ; i < VLAN_ENTRY ; i++ )
{
desc = ele_id_name[ele_item.desc] + i;
enab = ele_id_name[ele_item.enb] + i;
vlid = ele_id_name[ele_item.id] + i;
inet = ele_id_name[ele_item.net] + i;
pot1 = ele_id_name[ele_item.port1] + i;
pot2 = ele_id_name[ele_item.port2] + i;
pot3 = ele_id_name[ele_item.port3] + i;
pot4 = ele_id_name[ele_item.port4] + i;
document.write('<tr>');
document.write('<td>');
if( i == 0 )
{
document.write('<span id="' + desc + '_span"></span>');
document.write('<input type="hidden" id="' + desc + '" name="' + desc + '" value="" />');
}
else
document.write('<input type="text" maxLength="32" name="' + desc + '" id="' + desc + '" onBlur="valid_name(this,\'Name\')" value="" class="num" style="width:150px" />');
document.write('</td>');
document.write('<td>');
if (i < vlan_info.length)
draw_checkbox(enab, '', 'on', '',vlan_info[i][ele_item.enb] == 'on' ? "1":"" );
else
draw_checkbox(enab, '', 'on', '',"");
document.write('</td>');
document.write('<td>');
document.write('<input type="text" maxlength="4" size="4" style="width:40px" name="' + vlid + '" id="' + vlid + '" onblur="valid_name(this,\'Name\');" value="" class="num" />');
document.write('</td>');
document.write('<td>');
str = [vlan.untagged, vlan.tagged, vlan.excluded];
sel = str[2];
if( i == 0 )
{
str.pop();
sel = str[0];
}
draw_select(inet, str, str, '', sel).width('80px');
document.write('</td>');
if( i == 0 )
{
document.write('<td>&nbsp;</td>');
document.write('<td>&nbsp;</td>');
document.write('<td>&nbsp;</td>');
document.write('<td>&nbsp;</td>');
}
else
{
str = [vlan.untagged, vlan.tagged, vlan.excluded];
sel = str[2];
document.write('<td>');
draw_select(pot1, str, str, '', sel).width('80px');
document.write('</td>');
document.write('<td>');
draw_select(pot2, str, str, '', sel).width('80px');
document.write('</td>');
document.write('<td>');
draw_select(pot3, str, str, '', sel).width('80px');
document.write('</td>');
document.write('<td>');
draw_select(pot4, str, str, '', sel).width('80px');
document.write('</td>');
}
document.write('</tr>');
}
})();
</script>
</tbody>
</table>
</div>
<% web_include_file("Bottom.asp"); %>
</FORM>
</BODY>
</HTML>
