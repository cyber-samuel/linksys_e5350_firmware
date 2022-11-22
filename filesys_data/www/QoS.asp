<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>QoS</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<style type="text/css">
FONT-SIZE: 8pt;
FONT-FAMILY: Arial;
TEXT-ALIGN: center;
HEIGHT: 28;
BORDER-LEFT-WIDTH: 1;
BORDER-TOP-STYLE: none;
BORDER-BOTTOM-WIDTH: 1;
border:solid 1px #2971b9
}
FONT-SIZE: 8pt; 
FONT-FAMILY: Arial;
}
.table tr.cgy_tr > td {
padding-top: 0;
padding-bottom: 3px;
}
width: auto;
margin-bottom: 0;
margin-top: 4px;
}
padding-top: 0;
padding-bottom: 0;
}
</style>
<SCRIPT>
setFormActions({
save:   true,
cancel: true
});
var infor ="none";
var qos_enable = <% nvram_get("QoS"); %>;  
var DegMode = 0 ;
var CurrentTrId = 0;  // row index
var game_name = new Array(
"New",
"Neverwinter Nights 2",
"Enemy Territory",
"World In Conflict",
"Call of Duty 4",
"Sins of A Solar Empire",
"Half-Life 2:The Orange Box",
"Crysis",
"Frontlines",
"Warhammer 40,000:Dawn of War:Soulstorm",
"S.T.A.L.K.E.R.:Shadow Of Chernoby",
"World Of Warcraft",
"Supreme Commander",
"Titan Quest: Immortal Throne",
"Battle field 2142",
"Half-Life 2: Episode 1",
"Heroes of Might & Magic V",
"Guild Wars Factions I & II"
);
var app_name = new Array(
"New",
"MSN Messenger",	
"Skype",
"Yahoo Message"	,
"Windows Live Messenger",
"AIM",
"Windows Media Player",
"RealPlayer",
"QuickTime",
"iTunes",
"Yahoo Music Jukebox",
"Rhapsody"
);
var QosList = new Array();
<% qos_init(); %>
function QosEntry(idx,category,selValue,name,priority,infor){
this.idx = idx;
this.cate = category;
this.val = selValue;
this.name = name;
this.pri = priority;
this.infor = infor;
}
var wl_wme_count = 1;
var wl_wme_no_ack_count = 0;
var qos_enable_count=1;
var eth_port_str="";
function SelWME(F,I)
{
if ( F._wl_wme.checked == true ){
choose_enable(F._wl_wme_no_ack);
}else {
choose_disable(F._wl_wme_no_ack);
}
wl_wme_count=wl_wme_count + 1;	
}
function ChgVal()
{
wl_wme_no_ack_count = wl_wme_no_ack_count + 1 ; 
}
function init(){
if(document.QoS.wl_wme)	SelWME(document.QoS,'<% nvram_get("wl_wme"); %>');
QosDisabled(!qos_enable);
if( ns4 == true || ns6 == true) {
}
checkportrange();
for(var i=0; i < QosList.length; i++)
{
addtoSummary(i);
if(QosList[i].cate== 4 )
eth_port_str += QosList[i].cate + ";" + QosList[i].val + ";" + QosList[i].name + ";" + QosList[i].pri + ";"; 
}
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
var eth_port_fin="";
var F=document.forms[0];
if (  CHECK_QOS_ENTRY() == false ) return ; 
if ( F._wl_wme.checked == true )
{
F.wl0_wme.value = 'on';
if( F.rate_mode.options[F.rate_mode.selectedIndex].value == "0")
{
var speed_limit_low = (F.upbunit.options[F.upbunit.selectedIndex].value == "0") ? <% nvram_get("QoS_min_wan_speed"); %>:1;
var speed_limit_high = (F.upbunit.options[F.upbunit.selectedIndex].value == "0") ? <% nvram_get("QoS_wan_speed"); %> : (<% nvram_get("QoS_wan_speed"); %> / 1024);
var strings =  (F.upbunit.options[F.upbunit.selectedIndex].value == "0") ? "Kbps":"Mbps";
if( Number(F.manual_rate.value)<speed_limit_low || Number(F.manual_rate.value)>speed_limit_high )
{
alert(errmsg.err14 + '['+speed_limit_low+' - ' + speed_limit_high +'] '+strings+'.');
F.manual_rate.focus();
return ;	
}
}
}else {
F.wl0_wme.value = 'off';
}
if ( F._wl_wme_no_ack.checked == true )
{
F.wl_wme_no_ack.value = "on";
} else {
F.wl_wme_no_ack.value = "off";
}
if ( F._QoS.checked == true )
{
F.QoS.value = "1";
} else {
F.QoS.value = "0";
}
F.QoS_cnt.value = QosList.length;
for(var i=0; i<QosList.length; i++){
str +=  QosList[i].cate + ";" + QosList[i].val + ";" + QosList[i].name + ";" + QosList[i].pri + ";";
if(QosList[i].cate == 4)
eth_port_fin += QosList[i].cate + ";" + QosList[i].val + ";" + QosList[i].name + ";" + QosList[i].pri + ";";
if ((QosList[i].cate == 1)||(QosList[i].cate == 2))
{
if (QosList[i].val == 0)
{ 
for (var k=0; k < 9; k++){
if (k == 8)
str+= QosList[i].infor[k] + "#";
else
str+= QosList[i].infor[k] + ";";
}
}
else
str+= QosList[i].infor + "#";
}
else 
str+=QosList[i].infor + "#";
}
F.qos_list.value =  str;
F.wait_time.value ="5";
if((wl_wme_count %2)|| (wl_wme_no_ack_count %2)|| (eth_port_str !=eth_port_fin )||((eth_port_str!="")&&(qos_enable_count %2)))
{
F.need_action.value ="restart"; 
F.wait_time.value ="13";
}
F.submit_button.value = "QoS";
F.gui_action.value = "Apply";
ajaxSubmit(35,"false");	
}
function rate_grey(num,F)
{
var sw_disabled=(num == F.rate_mode[0].value)?true:false;
var bgcolor = (num == F.rate_mode[0].value)?"#E7E7E7":"#FFFFFF";
F.manual_rate.disabled = sw_disabled;
F.manual_rate.style.backgroundColor = bgcolor;
F.upbunit.disabled = sw_disabled;
F.upbunit.style.backgroundColor = bgcolor;
update_selected(F.upbunit);
}
function SetQos() {
var F = document.forms[0];
var flag;
if(F._QoS.checked == true) {	
flag = 0;
rate_grey(F.rate_mode[0].value, F);	
F.rate_mode.style.backgroundColor = "#FFFFFF";
F.Category.style.backgroundColor = "#FFFFFF";
F.Application.style.backgroundColor = "#FFFFFF";
F.Priority.style.backgroundColor = "#FFFFFF";
F.VoicePri.style.backgroundColor = "#FFFFFF";
}else{
flag = 1;
rate_grey(F.rate_mode.value, F);
F.rate_mode.style.backgroundColor = "#E7E7E7";
F.Category.style.backgroundColor = "#E7E7E7";
F.Application.style.backgroundColor = "#E7E7E7";
F.Priority.style.backgroundColor = "#E7E7E7";
F.VoicePri.style.backgroundColor = "#E7E7E7";
}
F.rate_mode.disabled = flag;
F.Category.disabled = flag;
F.Application.disabled = flag;
F.Priority.disabled = flag;
F.Add.disabled = flag;
F.Games.disabled = flag;
F.AppName.disabled = flag;
F.MAC.disabled = flag;
F.Ethernet.disabled = flag;
F.VoicePri.disabled = flag;
update_selected(F.rate_mode);
update_selected(F.upbunit);
update_selected(F.Category);
update_selected(F.Application);
update_selected(F.Games);
update_selected(F.Ethernet);
update_selected(F.Priority);
update_selected(F.VoicePri);
}
function QosDisabled(flag){
var F = document.forms[0];
if(flag)
{
F._QoS.checked = false;
rate_grey(F.rate_mode[0].value, F);
F.rate_mode.style.backgroundColor = "#E7E7E7";
F.Category.style.backgroundColor = "#E7E7E7";
F.Application.style.backgroundColor = "#E7E7E7";
F.Priority.style.backgroundColor = "#E7E7E7";
F.VoicePri.style.backgroundColor = "#E7E7E7";
}
else
{
F._QoS.checked = true;
rate_grey(F.rate_mode.value, F);
F.rate_mode.style.backgroundColor = "#FFFFFF";
F.Category.style.backgroundColor = "#FFFFFF";
F.Application.style.backgroundColor = "#FFFFFF";
F.Priority.style.backgroundColor = "#FFFFFF";
F.VoicePri.style.backgroundColor = "#FFFFFF";
}
F.rate_mode.disabled = flag;
F.Category.disabled = flag;
F.Application.disabled = flag;
F.Priority.disabled = flag;
F.Add.disabled = flag;
F.Games.disabled = flag;
F.AppName.disabled = flag;
F.MAC.disabled = flag;
F.Ethernet.disabled = flag;
F.VoicePri.disabled = flag;
update_selected(F.rate_mode);
update_selected(F.upbunit);
update_selected(F.Category);
update_selected(F.Application);
update_selected(F.Games);
update_selected(F.Ethernet);
update_selected(F.Priority);
update_selected(F.VoicePri);
var tab = document.getElementById("tabSummary");
tab.disabled = flag;
F.Category.value = 1;
cateChange("1");
qos_enable_count=qos_enable_count+1;
/*
F.Category.style.backgroundColor = bkcolor;
F.Application.style.backgroundColor = bkcolor;
F.Priority.style.backgroundColor = bkcolor;
*/
}
function cateChange(category) 
{
var imgHeight = new Array("","81","81","106","81","106");
document.getElementById('tdmsg').innerHTML = "";
document.getElementById('trApp').style.display = "none";                                                                                
document.getElementById('trGame').style.display = "none";
document.getElementById('trName').style.display = "none"; 
document.getElementById('trMAC').style.display = "none";  
document.getElementById('trEth').style.display = "none";                                                                               
document.getElementById('trRange1').style.display = "none";
document.getElementById('trPri').style.display = "none";
document.getElementById('trVoicePri').style.display = "none";    
document.getElementById('trBtn').style.display = "none";
document.forms[0].Priority.value = 2;
switch(category) {
case "1":
document.forms[0].Application.value = 1;
document.forms[0].AppName.value="";
document.forms[0].fport1.value = ""; 	//Add 2010-02-10
document.forms[0].tport1.value = ""; 	//Add 2010-02-10
document.forms[0].fport2.value = ""; 	//Add 2010-02-10
document.forms[0].tport2.value = ""; 	//Add 2010-02-10
document.forms[0].fport3.value = ""; 	//Add 2010-02-10
document.forms[0].tport3.value = ""; 	//Add 2010-02-10
document.forms[0].pro1.value = 0;		//Add 2010-02-10
document.forms[0].pro2.value = 0;		//Add 2010-02-10
document.forms[0].pro3.value = 0;		//Add 2010-02-10
document.getElementById('trApp').style.display = "";
document.getElementById('trPri').style.display = "";
break;
case "2":
document.forms[0].Games.value = 1;
document.forms[0].AppName.value="";
document.forms[0].fport1.value = ""; 	//Add 2010-02-10
document.forms[0].tport1.value = ""; 	//Add 2010-02-10
document.forms[0].fport2.value = ""; 	//Add 2010-02-10
document.forms[0].tport2.value = ""; 	//Add 2010-02-10
document.forms[0].fport3.value = ""; 	//Add 2010-02-10
document.forms[0].tport3.value = ""; 	//Add 2010-02-10
document.forms[0].pro1.value = 0;	//Add 2010-02-10
document.forms[0].pro2.value = 0;	//Add 2010-02-10
document.forms[0].pro3.value = 0;	//Add 2010-02-10
document.getElementById('trGame').style.display = "";
document.getElementById('trPri').style.display = "";
break;
case "3":
document.forms[0].AppName.value="";
document.forms[0].MAC.value="00:00:00:00:00:00";	//Add 2010-02-04
document.getElementById('tdmsg').innerHTML = "&nbsp;" + qos.mymac + ": <b><% nvram_get("http_client_mac"); %> </b>";
document.getElementById('trName').style.display = "";
document.getElementById('trMAC').style.display = "";
document.getElementById('trPri').style.display = "";
break;
case "4":
document.forms[0].Ethernet.value =1;
document.getElementById('trEth').style.display = "";
document.getElementById('trPri').style.display = "";
break;
case "5":
document.forms[0].VoicePri.value =3;
document.forms[0].AppName.value="";
document.forms[0].MAC.value="00:00:00:00:00:00";	//Add 2010-02-04
document.getElementById('trName').style.display = "";
document.getElementById('trMAC').style.display = "";
document.getElementById('trVoicePri').style.display = "";
break;
default:
alert("fail");
break;
}
document.getElementById('trBtn').style.display = "";
}
function DisplayNewRow(flag){
var tmp = "none";
if(flag == 0) {
tmp = ""; //add new app
}
else {
}  	
document.getElementById('trName').style.display = tmp;
document.getElementById('trRange1').style.display = tmp;
}
function checkValid(category){
var f = document.forms[0];
var funreturn = true ; 
if ( DegMode ) alert(category);        
if ( category == 3 || category == 5 ) 
{
if ( f.MAC.value == "00:00:00:00:00:00")
{
alert(errmsg.err17);
return false ;
}
}
if ( category == 1 || category == 2 )
{
if (document.getElementById('trRange1').style.display == "none") return true ; 
if ( IsEmpty(f.fport1) == false )                  
{
if ( valid_range(f.fport1,0,65535,"") == false ) return false ;   
if ( IsEmpty(f.tport1) == false )
{
if ( valid_range(f.tport1,0,65535,"") == false ) return false ; 
/*Jemmy port from Alpha for check to port great than from port 2009.11.16*/
if(parseInt(f.fport1.value) > parseInt(f.tport1.value))
{
var tmp = f.fport1.value;
f.fport1.value = f.tport1.value;
f.tport1.value = tmp;
}
} 
else
{
alert(errmsg.err66);
return false ;                                     
} 
}
else
{
alert( errmsg.err66 ) ; 
return false ; 
}
if ( IsEmpty(f.fport2) == false ) 
{
if ( valid_range(f.fport2,0,65535,"") == false ) return false ; 
if ( IsEmpty(f.tport2) == false ) 
{
if ( valid_range(f.tport2,0,65535,"") == false ) return false ; 
/*Jemmy port from Alpha for check to port great than from port 2009.11.16*/
if(parseInt(f.fport2.value) > parseInt(f.tport2.value))
{
var tmp = f.fport2.value;
f.fport2.value = f.tport2.value;
f.tport2.value = tmp;
}
}
else
{
alert(errmsg.err66);
return false ;  
}
}
else
{
if ( IsEmpty(f.tport2) == false )               
{  
alert( errmsg.err66 ) ; 
return false ; 
}
}
if ( IsEmpty(f.fport3) == false )
{
if ( valid_range(f.fport3,0,65535,"") == false ) return false ; 
if ( IsEmpty(f.tport3) == false )     
{
if ( valid_range(f.tport3,0,65535,"") == false ) return false ; 
/*Jemmy port from Alpha for check to port great than from port 2009.11.16*/
if(parseInt(f.fport3.value) > parseInt(f.tport3.value))
{
var tmp = f.fport3.value;
f.fport3.value = f.tport3.value;
f.tport3.value = tmp;
}
}
else
{
alert(errmsg.err66);
return false ; 
}
}
else
{
if ( IsEmpty(f.tport3) == false )               
{  
alert( errmsg.err66 ) ; 
return false ; 
}
}
}
return true ;
}
function value2string(cate,idx){
switch(cate){
case "1" : flag=0; break; 	
case "2" : flag=1; break;
case "4" : flag=2; break;
default : flag=3; break;
} 
var cateArray = new Array();
cateArray[0] = new Array("","MSN Messenger","Skype","Yahoo Message","Windows Live Messenger","AIM","Windows Media Player","RealPlayer","QuickTime","iTunes","Yahoo Music Jukebox","Rhapsody");
cateArray[1] = new Array("","Neverwinter Nights 2","Enemy Territory","World In Conflict","Call of Duty 4","Sins of A Solar Empire","Half-Life 2:The Orange Box","Crysis","Frontlines","Warhammer 40,000:Dawn of War:Soulstorm","S.T.A.L.K.E.R.:Shadow Of Chernoby","World Of Warcraft","Supreme Commander","Titan Quest: Immortal Throne","Battle field 2142","Half-Life 2: Episode 1","Heroes of Might & Magic V","Guild Wars Factions I & II");
cateArray[2] = new Array("","Ethernet Port 1", "Ethernet Port 2","Ethernet Port 3","Ethernet Port 4");
/*cateArray[3] = new Array("Low","Normal","Medium","High");*/
cateArray[3] = new Array(qos.low, qos.normal, qos.medium, qos.high);
return (cateArray[flag][idx]); 
}
function checkportrange()
{
var f = document.forms[0];
var en_portcheck = false ; 
if ( (IsEmpty(f.fport1) == false) && (IsEmpty(f.tport1)== false) )
{
choose_enable(f.fport2);
choose_enable(f.tport2);
}
else
{
f.fport2.value="";       
f.tport2.value="";
choose_disable(f.fport2);       
choose_disable(f.tport2);
}
if ( (IsEmpty(f.fport2) == false) && (IsEmpty(f.tport2)== false) )
{
choose_enable(f.fport3);
choose_enable(f.tport3);
en_portcheck = true ;
}
else
{
f.fport3.value="";
f.tport3.value="";
choose_disable(f.fport3);
choose_disable(f.tport3);
}
if ( en_portcheck == true ) 
{
r1 = f.fport1.value ; 
r2 = f.tport1.value ; 
r3 = f.fport2.value ; 
r4 = f.tport2.value ; 
r5 = f.fport3.value ; 
r6 = f.tport3.value ; 
if ( IsEmpty(f.fport1) == false && IsEmpty(f.tport1)==false && 
IsEmpty(f.fport2) == false && IsEmpty(f.tport2)==false )            
{
if ( IsCrossRange(r1,r2,r3,r4) == true ) 
{
alert( errmsg.err67 );
f.fport2.value="";       
f.tport2.value="";
return ; 
}
}
if ( IsEmpty(f.fport3) == false && IsEmpty(f.tport3)==false )
{
if ( IsCrossRange(r1,r2,r5,r6) == true ) 
{
alert( errmsg.err67 );
f.fport3.value="";       
f.tport3.value="";
return ; 
}
if ( IsCrossRange(r3,r4,r5,r6) == true ) 
{
alert( errmsg.err67 );
f.fport3.value="";       
f.tport3.value="";
return ; 
}
}  
}
}
function CHECK_QOS_ENTRY(){
var f = document.forms[0];
var appName ="none";
var infor = "none";
var priority =0;
var selValue =0;
var i , j ; 
var category = "none";
for ( i=0; i<QosList.length; i++)
{ 
category = QosList[i].cate ; 
selValue = QosList[i].val ;
infor = QosList[i].infor ; 
appName = QosList[i].name ;  
for ( j=i+1; j<QosList.length; j++)
{
if ( (appName.length == QosList[j].name.length) && (appName.indexOf(QosList[j].name)!=-1))
{
alert( errmsg.err57 ); 
return false ;                      
}
{ 
if ( category=="3" && category=="5" ) continue;                          
if ( infor.length != QosList[j].infor.length) continue ; 
if ( checkinfor(infor,QosList[j].infor,category)==false)
{
if (category==3 ||category==5){
alert( errmsg.err65 ); 
return false ; 
}
if (category==1 || category==2){
alert(errmsg.err74);
return false;
}
}
}
}
}
return true ; 
}
function checkinfor(src,dst,item)
{
var i,x,y,sameflg=0;
if(item==3 || item==5){
src = src.split(":");
dst = dst.split(":");
for(i=0; i<6; i++)
{
if ( src[i]==dst[i]) sameflg++;
}
if ( sameflg == 6 ) return false ; 
return true ;
}
if(item==1 || item==2){
for(x=0; x<7; x+=3)
{
for( y=0; y<7; y+=3)
{
if ( IsCrossRange(src[x],src[x+1],dst[y],dst[y+1],src[x+2],dst[y+2]) == true )
return false ;
}
}
return true ;
}
}
function modifyQosEntry(category){
var f = document.forms[0];
var appName ="none";
var infor = "none";
var priority =0;
var selValue =0;
var i ; 
switch(category) {
case "1":  //App
case "2":  //Games                        
if(category == "1") var tmp= f.Application.value;
else var tmp = f.Games.value; 
if ( tmp == 0){
var rangeArray = new Array("0","0","0","0","0","0","0","0","0");
rangeArray[0]=f.fport1.value; rangeArray[1]=f.tport1.value; rangeArray[2]=f.pro1.value;
if(f.fport2.value){          	  
rangeArray[3]=f.fport2.value; rangeArray[4]=f.tport2.value; rangeArray[5]=f.pro2.value;
}   
if(f.fport3.value){
rangeArray[6]=f.fport3.value; rangeArray[7]=f.tport3.value; rangeArray[8]=f.pro3.value;
}	 
infor = rangeArray;
appName = f.AppName.value;
}
else {
selValue = tmp;   
if ( category == "1")
appName = app_name[tmp];
else
appName = game_name[tmp];             
}
priority = f.Priority.value;
break;       	
case "3":  //MAC
appName = f.AppName.value;
infor = f.MAC.value;
priority = f.Priority.value;
break;
case "4":  //Ethernet Port
selValue = f.Ethernet.value;
appName = "Ethernet Port "+selValue;
priority = f.Priority.value;
break;
case "5":  //Voice
appName = f.AppName.value;
infor = f.MAC.value;
priority = f.VoicePri.value;
break;
default: alert("fail");
}
if ( appName == null || appName == "")
{
alert(errmsg.err64);
return false ; 
} 
var portstr ; 
if ( selValue == "0" )
{
for (i=0; i<app_name.length; i++)        
{
if ( appName == app_name[i])	//Modified 2010-02-04
{
alert(errmsg.err68);		//errmsg.err68 = "This Application Name has already been reserved. It can't be added twice."
return false ;                    
}
}
for (i=0; i<game_name.length; i++)
{
if ( appName == game_name[i])		//Modified 2010-02-04
{ 
alert(errmsg.err68);
return false ;
}
}
/*
for(i=1; i<5; i++)
{
portstr = "Ethernet Port "+i;
if ( appName.indexOf(portstr)!=-1)
{
alert(errmsg.err68);
return false ; 
}
} 
*/
}
var idx = 0 ;
if (f.Category.disabled == 1 )
idx = CurrentTrId ;
else                          
idx = QosList.length;
QosList[idx] = new QosEntry(idx,category,selValue,appName,priority,infor);
return true ;
}
function showSummary(){
var selectedCate = document.forms[0].Category.value;    
var f = document.forms[0];
var data ; 
var qos_cnt = QosList.length; 
if(qos_cnt >= 15) return;
if ( checkValid(selectedCate) == false ) return ;     
if ( modifyQosEntry(selectedCate) == false ) return ;    
if (document.forms[0].Category.disabled == 1) { //Edit
reDrawList();
}
else
reDrawList();
resetElement();
}
function reDrawList()
{
var tbody = document.getElementById("tabSummary");
for( var i = tbody.children.length ; i > 0; i-- )
tbody.removeChild(tbody.children[i-1]);
for( var i = 0 ; i < QosList.length ; i++ )
addtoSummary(i);
}
function addtoSummary(idx) {
var tbody = document.getElementById("tabSummary");
var row = document.createElement("tr");
var tdArray = new Array();
var str = "",data;
row.setAttribute("id",idx);
for(i=0; i<5; i++) {
tdArray[i] = document.createElement("td");
}
tdArray[0].innerHTML = value2string("pri",QosList[idx].pri);
if (QosList[idx].val == 0)
data = QosList[idx].name;
else                          
data = value2string(QosList[idx].cate,QosList[idx].val);
tdArray[1].innerHTML = string_break(18,data) ; 
if (QosList[idx].infor == "none") //2006/3/20 
tdArray[2].innerHTML = "---";
else {
if(QosList[idx].cate == "3" || QosList[idx].cate == "5") 
str = "MAC " + QosList[idx].infor;
else {
str  = errmsg.err46 + " <br />" + QosList[idx].infor[0] + " - " + QosList[idx].infor[1];
if (QosList[idx].infor[3] >0 ) str += "<br />" +QosList[idx].infor[3] + " - " + QosList[idx].infor[4];
if (QosList[idx].infor[6] >0 ) str += "<br />" +QosList[idx].infor[6] + " - " + QosList[idx].infor[7];
}
tdArray[2].innerHTML = str;
tdArray[4].innerHTML = '<button class="btn" type="button" onclick="EditEntry(' + idx + ')">' + sbutton.edit + '</button>';
}
tdArray[3].innerHTML = '<button class="btn" type="button" onclick="delRow(' + idx + ')">' + sbutton.remove + '</button>';
for(i=0; i<5; i++) row.appendChild(tdArray[i]);
tbody.appendChild(row);
if( ns4 == true || ns6 == true) {
var baseheight =27;
if((QosList[idx].cate == "1" || QosList[idx].cate == "2") && QosList[idx].val ==0){
if( QosList[idx].infor[3]!="0") baseheight +=12;
if( QosList[idx].infor[6]!="0") baseheight +=12;
}
}
QosList[idx].idx=idx;
}
function EditEntry(num){
CurrentTrId = num; // Save Old TR ID
var idx=0;
while((idx<QosList.length) && (QosList[idx].idx != num)) idx++;
var f = document.forms[0];
var category = QosList[idx].cate;
var selValue = QosList[idx].val;
cateChange(category);
if((category == 1 && selValue==0) || (category == 2 && selValue==0))
DisplayNewRow(0);
f.Category.value = category;
f.Priority.value = QosList[idx].pri;	
f.Category.disabled = 1;
update_selected(f.Category);
switch(category){   
case "1":    
f.Application.disabled = 1; 
f.Application.value = selValue;
update_selected(f.Application);
if(selValue ==0){ 
f.AppName.value = QosList[idx].name;
f.fport1.value=QosList[idx].infor[0];
f.tport1.value=QosList[idx].infor[1];
f.pro1.value=QosList[idx].infor[2];
update_selected(f.pro1);
if ( QosList[idx].infor[3] != 0 ) f.fport2.value=QosList[idx].infor[3]; 
if ( QosList[idx].infor[4] != 0 ) f.tport2.value=QosList[idx].infor[4]; 
f.pro2.value=QosList[idx].infor[5];
update_selected(f.pro2);
if ( QosList[idx].infor[6] != 0 ) f.fport3.value=QosList[idx].infor[6]; 
if ( QosList[idx].infor[7] != 0 ) f.tport3.value=QosList[idx].infor[7]; 
f.pro3.value=QosList[idx].infor[8];
update_selected(f.pro3);
checkportrange();
}
break;
case "2":
f.Games.disabled = 1; 
f.Games.value = selValue;
update_selected(f.Games);
if(selValue ==0){ 
f.AppName.value = QosList[idx].name;
f.fport1.value=QosList[idx].infor[0];
f.tport1.value=QosList[idx].infor[1];
f.pro1.value=QosList[idx].infor[2];
update_selected(f.pro1);
if ( QosList[idx].infor[3] != 0 ) f.fport2.value=QosList[idx].infor[3]; 
if ( QosList[idx].infor[4] != 0 ) f.tport2.value=QosList[idx].infor[4]; 
f.pro2.value=QosList[idx].infor[5];
update_selected(f.pro2);
if ( QosList[idx].infor[6] != 0 ) f.fport3.value=QosList[idx].infor[6]; 
if ( QosList[idx].infor[7] != 0 ) f.tport3.value=QosList[idx].infor[7];
f.pro3.value=QosList[idx].infor[8];
update_selected(f.pro3); 
checkportrange();
}
break;
case "3":  
case "5": //2006/3/20 
f.AppName.value = QosList[idx].name;
f.MAC.value = QosList[idx].infor;
f.VoicePri.value = QosList[idx].pri;
break;
default : alert("fail");   
}
update_selected(f.VoicePri);
}
function delRow(idx){
delArrayElement(idx);
reDrawList();
/*
if( ns4 == true || ns6 == true) {
}
*/
document.forms[0].Category.disabled = false;	//Add 2010-02-04
update_selected(document.forms[0].Category);
document.forms[0].Application.disabled = false;	//Add 2010-02-09
update_selected(document.forms[0].Application);
document.forms[0].Games.disabled = false;	//Add 2010-02-09
update_selected(document.forms[0].Games);
}
function delArrayElement(idx){
var list = [];
for(var i = 0 ; i < QosList.length ; i++ )
if( idx != i )
list.push(QosList[i]);
QosList = list;
}
function resetElement(){
var F = document.forms[0];
F.Category.disabled=0;
update_selected(F.Category);
F.Application.disabled=0;
update_selected(F.Application);
F.Games.disabled=0;
update_selected(F.Games);
F.AppName.value = '';
F.AppName.disabled=0;
F.MAC.value = '00:00:00:00:00:00';
F.fport1.value = '';
F.tport1.value = '';
F.fport2.value = '';
F.tport2.value = '';
F.tport2.disabled = 1;
F.fport3.value = '';
F.tport3.value = '';
F.tport3.disabled = 1;
F.pro1.selectedIndex = 0;
update_selected(F.pro1);
F.pro2.selectedIndex = 0;
update_selected(F.pro2);
F.pro3.selectedIndex = 0;
update_selected(F.pro3);
F.Priority.selectedIndex = 1;
update_selected(F.Priority);
F.VoicePri.selectedIndex = 1;
update_selected(F.VoicePri);
}
</SCRIPT>
</head>
<body onload="init()" onbeforeunload = "return checkFormChanged(document.QoS)">
<FORM name="QoS" method="<% get_http_method(); %>"action="apply.cgi">
<input type="hidden" name="wl0_wme" />
<input type="hidden" name="wl_wme_no_ack" />
<input type="hidden" name="QoS" />
<input type="hidden" name="qos_list" />
<input type="hidden" name="QoS_cnt" />
<input type="hidden" name="enable_game" value="0" />
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="need_action" value="0" />
<input type="hidden" name="wait_time" value="3" />
<% web_include_file("Top.asp"); %>
<script>draw_table(MAINFUN2,qos.qos);</script>
<table class="table table-info">
<tbody>
<tr>
<td>
<script>draw_checkbox('_wl_wme', qos.wlqos, 'on', "SelWME(this.form,'on')" <% nvram_match("wl0_wme","on",", 1"); %>);</script>
</td>
<td>(<script>Capture(hwlad2.def)</script>: <script>Capture(share.enabled)</script>)</td>
</tr>
<tr>
<td>
<script>draw_checkbox('_wl_wme_no_ack', qos.noack, 'on', 'ChgVal()' <% nvram_match("wl_wme_no_ack","on",", 1"); %>);</script>
</td>
</tr>
<tr>
<td colspan="2">
<hr class="table-title-underline">
</td>
</tr>
<tr>
<td>
<!--script>draw_checkbox('_QoS', share.enabled, '0', '' <% nvram_match("QoS","1",", 1"); %>);</script-->
<script>draw_checkbox('_QoS', qos.intqccpri, '1', 'SetQos()' <% nvram_match("QoS","1",", 1"); %>);</script>
</td>
</tr>
<tr>
<td><script>Capture(qos.uband)</script></td>
<td>
<script>
(function(){
var str = [share.auto, share.mtumanual],
val = ['1', '0'];
draw_select('rate_mode', str, val, 'rate_grey(this.value,this.form)', '<% nvram_get("rate_mode"); %>').width('auto');
})();
</script>
&nbsp;&nbsp;
<input type="text" class="num" maxlength="6" value="<% nvram_get("manual_rate"); %>" name="manual_rate" onblur="isdigit(document.QoS.manual_rate,'')" style="width:42px" />
&nbsp;&nbsp;
<script>
(function(){
var str = ['Kbps', 'Mbps'],
val = ['0', '1'];
draw_select('upbunit', str, val, '', '<% nvram_get("upbunit"); %>').width('auto');
})();
</script>
</tr>
<tr>
<td><script>Capture(qos.category)</script></td>
<td>
<script>
(function(){
var str = [bmenu.applications, qos.onlinegame, share.macaddr, qos.voicedevice],
val = ['1', '2', '3', '5'];
draw_select('Category', str, val, 'cateChange(this.value)');
})();
</script>
<div id="tdmsg"></div>
</td>
</tr>
<tr>
<td colspan="2">
<hr class="table-title-underline">
</td>
</tr>
<tr class="cgy_tr" id="trApp">
<td><script>Capture(bmenu.applications)</script></td>
<td>
<script>
(function(){
var str = [
qos.msnmess,
qos.skype,
qos.yahoomess,
qos.winlivemsg,
qos.aim,
qos.winmediaplay,
qos.realplayer,
qos.quicktime,
qos.itunes,
qos.yahoomusic,
qos.rhapsody,
qos.addapp
],
val = [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '0' ];
draw_select('Application', str, val, 'DisplayNewRow(this.value)');
})();
</script>
</td>
</tr>
<tr class="cgy_tr" id="trGame">
<td><script>Capture(qos.game)</script></td>
<td>
<script>
(function(){
var str = [
qos.neverwinternights2,
qos.enemyterritory,
qos.worldinconflict,
qos.callofduty4,
qos.sinofasolarempire,
qos.halflifetob,
qos.crysis,
qos.frontlines,
qos.warhanmer4k,
qos.shadowofchr,
qos.worldofwar,
qos.suprecomm,
qos.titanquest,
qos.battlefield,
qos.halflife2,
qos.heroesofmight,
qos.guildwarsfactions,
qos.addgame
],
val = [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '0' ];
draw_select('Games', str, val, 'DisplayNewRow(this.value)');
})();
</script>
</td>
</tr>
<tr class="cgy_tr" id="trName">
<td><script>Capture(qos.entername)</script></td>
<td>
<input type="text" class="num" maxLength="31" size="19" name="AppName" onBlur="valid_name1(this)" />
</td>
</tr>
<tr class="cgy_tr" id="trMAC">
<td><script>Capture(share.macaddr)</script></td>
<td>
<input type="text" maxLength="17" size="15" name="MAC" value="00:00:00:00:00:00" onBlur="valid_macs_17(this)" />
</td>
</tr>
<tr class="cgy_tr" id="trEth">
<td><script>Capture(qos.etherport)</script></td>
<td>
<script>
(function(){
var str = [
qos.etherport + ' 1',
qos.etherport + ' 2',
qos.etherport + ' 3',
qos.etherport + ' 4'
],
val = [ '1', '2', '3', '4' ];
draw_select('Ethernet', str, val, 'DisplayNewRow(this.value)');
})();
</script>
</td>
</tr>
<tr class="cgy_tr" id="trRange1">
<td><script>Capture(portsrv.portrange)</script></td>
<td>
<div class="table-box-warpper table-responsive">
<table class="table table-info-bg table-bordered" id="range_table">
<tbody>
<tr>
<td>&nbsp;</td>
<td>
<input type="text" class="num"  onblur="checkportrange()" maxLength="5" name="fport1" style="width:50px" /> 
<script>Capture(portforward.to)</script> 
<input type="text" class="num"  onblur="checkportrange()" maxLength="5" name="tport1" style="width:50px" />
</td>
<td>
<script>
(function(){
var str = [ share.tcp, share.udp, share.both ],
val = [ '1', '2', '0' ];
draw_select('pro1', str, val, '', val[2]).width('auto');
})();
</script>
</td>
</tr>
<tr>
<td>(<script>Capture(share.optional)</script>)</td>
<td>
<input type="text" class="num"  onblur="checkportrange()" maxLength="5" name="fport2" style="width:50px" /> 
<script>Capture(portforward.to)</script> 
<input type="text" class="num"  onblur="checkportrange()" maxLength="5" name="tport2" style="width:50px" />
</td>
<td>
<script>
(function(){
var str = [ share.tcp, share.udp, share.both ],
val = [ '1', '2', '0' ];
draw_select('pro2', str, val, '', val[2]).width('auto');
})();
</script>
</td>
</tr>
<tr>
<td>(<script>Capture(share.optional)</script>)</td>
<td>
<input type="text" class="num"  onblur="checkportrange()" maxLength="5" name="fport3" style="width:50px" /> 
<script>Capture(portforward.to)</script> 
<input type="text" class="num"  onblur="checkportrange()" maxLength="5" name="tport3" style="width:50px" />
</td>
<td>
<script>
(function(){
var str = [ share.tcp, share.udp, share.both ],
val = [ '1', '2', '0' ];
draw_select('pro3', str, val, '', val[2]).width('auto');
})();
</script>
</td>
</tr>
</tbody>
</table>
</div>
</td>
</tr>
<tr class="cgy_tr" id="trPri">
<td><script>Capture(qos.priority)</script></td>
<td>
<script>
(function(){
var str = [
qos.high,
qos.medium + ' (' + qos.recommend + ')',
qos.normal,
qos.low
],
val = [ '3', '2', '1', '0' ];
draw_select('Priority', str, val, '', val[1]);
})();
</script>
</td>
</tr>
<tr class="cgy_tr" id="trVoicePri">
<td><script>Capture(qos.priority)</script></td>
<td>
<script>
(function(){
var str = [
qos.high,
qos.medium + ' (' + qos.recommend + ')',
qos.normal,
qos.low
],
val = [ '3', '2', '1', '0' ];
draw_select('VoicePri', str, val, '', val[0]);
})();
</script>
</td>
</tr>
<tr class="cgy_tr" id="trBtn">
<td>&nbsp;</td>
<td>
<script>draw_button("javascript:showSummary()", hportser2.submit, 'Add')</script>
</td>
</tr>
</tbody>
</table>
<script>draw_table(MAINTITLE,share.summary);</script>
<br />
<div class="table-box-warpper table-responsive">
<table class="table table-info-bg table-bordered">
<thead>
<th><script>Capture(qos.priority)</script></th>
<th><script>Capture(share.name)</script></th>
<th><script>Capture(share.information)</script></th>
<th>&nbsp;</th>
<th>&nbsp;</th>
</thead>
<tbody id="tabSummary">
</tbody>
</table>
</div>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
