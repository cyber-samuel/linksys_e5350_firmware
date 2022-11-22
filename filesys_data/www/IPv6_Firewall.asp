<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>IPv6 Firewall</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<style type="text/css">
FONT-SIZE: 8pt; 
FONT-FAMILY: Arial;
}
.BLANKSPAN
{
padding-left:10px;
padding-right:10px;
padding-bottom:3px;
padding-top:3px;
text-align:center;
color:#ffffff;
}
</style>
<SCRIPT>
setFormActions({
save:   true,
cancel: true
});
document.title = apptopmenu.ipv6_firewall;
var close_session = "<% get_session_status(); %>";
var ipv6_clitbl = null;
var Firewall_List = new Array();
var CurrentTrId = 0;
var editEntry = 0;
/*Firewall_List[0] = new Firewall_List_Entry('description','ipv6 address','TCP/UDP','Port From','Port To', 'TCP/UDP', 'Port From', 'Port To');*/
/*filter_ipv6_cnt=2
filter_ipv6_list=123;345;tcp;234;234;tcp;234;234/456;567;tcp;67;78;tcp;67;89/ */
var Filter_ipv6_list = "<% nvram_get("filter_ipv6_list"); %>";
var Filter_cnt = <% nvram_get("filter_ipv6_cnt"); %>;
function Viewtbl()
{
ipv6_clitbl = self.open('IPv6_Client_Table.asp','ipv6_clitbl','alwaysRaised,resizable,scrollbars,width=920,height=400');
ipv6_clitbl.focus();
}
function exit()
{
closeWin(ipv6_clitbl);
}
function Firewall_List_Entry(desc,addr,pro0,from0,to0,pro1,from1,to1){
this.desc = desc;
this.addr = addr;
this.pro0 = pro0;
this.from0 = from0;
this.to0 = to0;
this.pro1 = pro1;
this.from1 = from1;
this.to1 = to1;
}
function init(){
var j =0;
while (Filter_cnt != 0)
{
var filter_list = Filter_ipv6_list.split("/");
var n = Filter_cnt -1;
var list_value = filter_list[Filter_cnt -1].split(";");
Firewall_List[j] = new Firewall_List_Entry(list_value[0],list_value[1],list_value[2],list_value[3],list_value[4],list_value[5],list_value[6],list_value[7]);
j++;
Filter_cnt--;
}
reDrawList();
var swmode = '<% nvram_get("switch_mode");%>';
if( swmode == 1)
alert(share.brdgmwn);
var bridge_mode = "<% nvram_get("wbridge_mode");%>";
if(bridge_mode == "1")
alert(wlanbridge.warn);
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
function to_submit(){
var str="";
var F=document.forms[0];
F.filter_ipv6_cnt.value = Firewall_List.length;
for(var i=0; i<Firewall_List.length; i++){
str += Firewall_List[i].desc + ";";
str += Firewall_List[i].addr + ";";
str += Firewall_List[i].pro0 + ";";
str += Firewall_List[i].from0 + ";";
str += Firewall_List[i].to0 + ";";
str += Firewall_List[i].pro1 + ";";
str += Firewall_List[i].from1 + ";";
str += Firewall_List[i].to1 + "/";
}
F.filter_ipv6_list.value =  str;
F.submit_button.value = "IPv6_Firewall";
F.gui_action.value = "Apply";
ajaxSubmit(0,"false");		
}
function apply_tbl(F)
{
if((F.ipv6_from0.value=="" && F.ipv6_to0.value=="")){
F.ipv6_from0.value=F.ipv6_from1.value;
F.ipv6_to0.value=F.ipv6_to1.value;
F.ipv6_from1.value="";
F.ipv6_to1.value="";
}
if(valid_range(F.ipv6_from0,1,65535,"Port")==false)	return false;
if(valid_range(F.ipv6_to0,1,65535,"Port")==false)	return false;
if(F.ipv6_from1.value!="" || F.ipv6_to1.value!=""){
if(valid_range(F.ipv6_from1,1,65535,"Port")==false)	return false;
if(valid_range(F.ipv6_to1,1,65535,"Port")==false)	return false;
}
/*IPv6 address check*/
var regExp="^([0-9a-fA-F\:])";
var ip6addr_tmp=F.ipv6_addr.value;
var buff1=ip6addr_tmp.split(":");
var buff2=ip6addr_tmp.split(/::/);
for(i = 0; i < ip6addr_tmp.length; i++)
{
ch = ip6addr_tmp.charAt(i);
if(ch.search(regExp) == -1){
alert(errmsg.err109);
return false;
}
if(i>1){
if (ch==":" && ip6addr_tmp.charAt(i-1)==":" && ip6addr_tmp.charAt(i-2)==":"){
alert(errmsg.err109);
return false;
}
}
}
for(i=0;i<buff1.length;i++){
if(buff1[i].length>4){
alert(errmsg.err109);
return false;
}
}
if(buff2.length==1){
if(buff1.length!=8 || buff1[0]=="" || buff1[buff1.length-1]==""){
alert(errmsg.err109);
return false;
}
}
else{
if(ip6addr_tmp.charAt(0)==":" && ip6addr_tmp.charAt(1)==":"){
if(buff1.length>9){
alert(errmsg.err109);
return false;
}
}
else if(ip6addr_tmp.charAt(ip6addr_tmp.length)==":" && ip6addr_tmp.charAt(ip6addr_tmp.length-1)==":"){
if(buff1.length>9){
alert(errmsg.err109);
return false;
}
}
else{
if(buff1.length>8){
alert(errmsg.err109);
return false;
}
}
}
if(buff2.length==2){
if(buff2[0]=="" && buff2[1]==""){
alert(errmsg.err109);
return false;
}
}
if(buff2.length>2){
alert(errmsg.err109);
return false;
}
if(buff1.length==8 && buff1[0].match(/ffff/i) && buff1[1].match(/ffff/i) && buff1[2].match(/ffff/i) && buff1[3].match(/ffff/i) && buff1[4].match(/ffff/i) && buff1[5].match(/ffff/i) && buff1[6].match(/ffff/i) && buff1[7].match(/ffff/i)){
alert(errmsg.err109);
return false;
}
var illegal=0;
for(i=0;i<buff1.length;i++){
if(buff1[i]==0 || buff1[i]=="")
illegal++;
if(i==buff1.length-1 && illegal==buff1.length){
alert(errmsg.err109);
return false;
}
}
if(buff1[0].match(/fe80/i))
{
alert(errmsg.err109);
return false;
}
if(buff1[0].match(/^ff/i))
{
alert(errmsg.err109);
return false;
}
/*IPv6 address check*/
var idx = 0;
var desc = F.desc.value;
var addr = F.ipv6_addr.value;
var pro0 = F.ipv6_pro0.value;
var from0 = F.ipv6_from0.value;
var to0 = F.ipv6_to0.value;
var pro1 = F.ipv6_pro1.value;
var from1 = F.ipv6_from1.value;
var to1 = F.ipv6_to1.value;
var str;
if(editEntry==0){
if(Firewall_List.length>=15){
alert(errmsg.exceptions);
return;
}
Firewall_List[Firewall_List.length] = new Firewall_List_Entry(desc,addr,pro0,from0,to0,pro1,from1,to1);
reDrawList();
}
else{
Firewall_List[CurrentTrId] = new Firewall_List_Entry(desc,addr,pro0,from0,to0,pro1,from1,to1);
reDrawList();
editEntry = 0;
}
cancel_tbl(F);
}
function reDrawList()
{
var tbody = document.getElementById("tabSummary");
for( var i = tbody.children.length ; i > 0; i-- )
tbody.removeChild(tbody.children[i-1]);
for( var i = 0 ; i < Firewall_List.length ; i++ )
addList(i);
}
function addList(idx)
{
var tbody = document.getElementById("tabSummary");
var row = document.createElement("tr");
var tdArray = new Array();
var str = "";
row.setAttribute("id", 'sum_tr_' + idx);
var td1 = document.createElement("td");
td1.innerHTML = string_break(18,Firewall_List[idx].desc);
var td2 = document.createElement("td");
td2.innerHTML = Firewall_List[idx].addr;
var td3 = document.createElement("td");
td3.innerHTML = value2string(Firewall_List[idx].pro0) + ': ' + Firewall_List[idx].from0 + '~' + Firewall_List[idx].to0;
if( Firewall_List[idx].from1 != '' )
{
td3.innerHTML += '<br />'
td3.innerHTML += value2string(Firewall_List[idx].pro1) + ': ' + Firewall_List[idx].from1 + '~' + Firewall_List[idx].to1;
}
var td4 = document.createElement("td");
td4.innerHTML = '<button class="btn" type="button" onclick="EditEntry(' + idx + ')">' + sbutton.edit + '</button> ';
td4.innerHTML += '<button class="btn" type="button" onclick="delRow(' + idx + ')">' + sbutton.remove + '</button> ';
row.appendChild(td1);
row.appendChild(td2);
row.appendChild(td3);
row.appendChild(td4);
tbody.appendChild(row);
}
function delRow(idx){
delArrayElement(idx);
reDrawList();
editEntry = 0;
}
function delArrayElement(idx){
var list = [];
for( var i = 0 ; i < Firewall_List.length ; i++ )
if( idx != i )
list.push(Firewall_List[i]);
Firewall_List = list;
}
function EditEntry(num)
{
CurrentTrId = num; // Save Old TR ID
var F = document.forms[0];
F.desc.value = Firewall_List[num].desc;
F.ipv6_addr.value = Firewall_List[num].addr;
F.ipv6_pro0.value = Firewall_List[num].pro0;
F.ipv6_from0.value = Firewall_List[num].from0;
F.ipv6_to0.value = Firewall_List[num].to0;
F.ipv6_pro1.value = Firewall_List[num].pro1;
F.ipv6_from1.value = Firewall_List[num].from1;
F.ipv6_to1.value = Firewall_List[num].to1;
editEntry = 1;  
}
function value2string(val)
{
var pro;
if(val=="tcp")
pro=share.tcp;
else if(val=="udp")
pro=share.udp;
else
pro=share.both;
return pro;
}
function cancel_tbl(F)
{
F.desc.value="";
F.ipv6_addr.value="0:0:0:0:0:0:0:0";
F.ipv6_pro0.selectedIndex=0;
F.ipv6_from0.value="";
F.ipv6_to0.value="";
F.ipv6_pro1.selectedIndex=0;
F.ipv6_from1.value="";
F.ipv6_to1.value="";
editEntry = 0;
}
</SCRIPT>
</head>
<body onload="init()" onunload="exit()" onbeforeunload = "return checkFormChanged(document.IPv6_Firewall)">
<FORM name="IPv6_Firewall" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="filter_ipv6_list" />
<input type="hidden" name="filter_ipv6_cnt" />
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="need_action" value="0" />
<input type="hidden" name="wait_time" value="3" />
<% web_include_file("Top.asp"); %>
<script>draw_table(MAINFUN2,ipv6firewall.settings);</script>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(firewall.description)</script></td>
<td>
<input type="text" maxLength="63" size="20" name="desc" value="" />
</td>
</tr>
<tr>
<td><script>Capture(ipv6firewall.ipv6addr)</script></td>
<td>
<input type="text" maxLength="63" size="20" name="ipv6_addr" value="0:0:0:0:0:0:0:0" />
<!-- <script>draw_button("javascript:Viewtbl()", ipv6firewall.ipv6clitbl, 'ipv6_clitbl')</script> -->
</td>
</tr>
<tr>
<td><script>Capture(filter.allow)</script></td>
<td>
<script>
(function(){
var str = [share.tcp, share.udp, share.both],
val = ['tcp', 'udp', 'both', '0'];
draw_select('ipv6_pro0', str, val).width('auto');
})();
</script>
<input type="text" maxLength="5" size="5" name="ipv6_from0" value="" />
<script>Capture(portforward.to)</script>
<input type="text" maxLength="5" size="5" name="ipv6_to0" value="" />
<br />
<script>
(function(){
var str = [share.tcp, share.udp, share.both],
val = ['tcp', 'udp', 'both', '0'];
draw_select('ipv6_pro1', str, val).width('auto');
})();
</script>
<input type="text" maxLength="5" size="5" name="ipv6_from1" value="" />
<script>Capture(portforward.to)</script>
<input type="text" maxLength="5" size="5" name="ipv6_to1" value="" />&nbsp;(<script>Capture(share.optional)</script>)
</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>
<script>draw_button("javascript:apply_tbl(this.form)", hportser2.submit, 'apply')</script>
<script>draw_button("javascript:cancel_tbl(this.form)", wlanwscpopup.btncancel, 'cancel')</script>
</td>
</tr>
</tbody>
</table>
<script>draw_table(MAINTITLE,ipv6firewall.exceptions);</script>
<br />
<!-- <div class="table-responsive"></div> -->
<div class="table-box-warpper table-responsive">
<table class="table table-info-bg table-bordered">
<thead>
<th><script>Capture(firewall.description)</script></th>
<th><script>Capture(ipv6firewall.addr)</script></th>
<th><script>Capture(filter.allow)</script></th>
<th>&nbsp;</th>
</thead>
<tbody id="tabSummary">
</tbody>
</table>
</div>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
