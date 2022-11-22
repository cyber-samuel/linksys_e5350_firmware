/*
*/
ie4 = ((navigator.appName == "Microsoft Internet Explorer") && (parseInt(navigator.appVersion) >= 4 ))
ns4 = ((navigator.appName == "Netscape") && (parseInt(navigator.appVersion) < 6 ))
ns6 = ((navigator.appName == "Netscape") && (parseInt(navigator.appVersion) >= 6 ))
var ZERO_NO = 1;	// 0x0000 0001
var ZERO_OK = 2;	// 0x0000 0010
var MASK_NO = 4;	// 0x0000 0100
var MASK_OK = 8;	// 0x0000 1000
var BCST_NO = 16;	// 0x0001 0000
var BCST_OK = 32;	// 0x0010 0000
var SPACE_NO = 1;
var SPACE_OK = 2;
var IP_FULL = 1;
var IP_LAST = 2;
var RANGE_SET;
var DHCP_START_IP = new Array(); 
var DHCP_END_IP = new Array();
var RANGE_COUNT; 
var MAX_RANGE_COUNT;
function choose_enable(en_object)
{
if(!en_object)	return;
en_object.disabled = false;			// netscape 4.x can not work, but 6.x can work
if( en_object.type && (en_object.type.toLowerCase() == "radio" || en_object.type.toLowerCase() == "checkbox") )
update_checked(en_object);
if( en_object.tagName && (en_object.tagName.toLowerCase() == "select") )
update_selected(en_object);
}
function choose_disable(dis_object)
{
if(!dis_object)	return;
dis_object.disabled = true;
if( dis_object.type && (dis_object.type.toLowerCase() == "radio" || dis_object.type.toLowerCase() == "checkbox") )
update_checked(dis_object);
if( dis_object.tagName && (dis_object.tagName.toLowerCase() == "select") )
update_selected(dis_object);
}
function DISABLE_ALL(flg,F)
{
var len,i,bt;
len = F.elements.length;
for(i=0; i<len; i++)
{
F.elements[i].disabled = flg ;
}
}
function check_action(I,N)
{
if(ns4){	//ie.  will not need and will have question in "select"
if(N == 0){
if(EN_DIS == 1) I.focus();
else I.blur();
}
else if(N == 1){
if(EN_DIS1 == 1) I.focus();
else I.blur();
}
else if(N == 2){
if(EN_DIS2 == 1) I.focus();
else I.blur();
}
else if(N == 3){
if(EN_DIS3 == 1) I.focus();
else I.blur();
}
}
}
function check_action1(I,T,N)
{
if(ns4){	//ie.  will not need and will have question in "select"
if(N == 0){
if(EN_DIS == 1) I.focus();
else I.value = I.defaultChecked;
}
if(N == 1){
if(EN_DIS1 == 1) I.focus();
else I.value = I.defaultChecked;
}
}
}
function valid_range(I,start,end,M )
{
M1 = unescape(M);
if(!isdigit(I,M1))
return false;
d = parseInt(I.value, 10);	
if ( !(d<=end && d>=start) )		
{		
alert(errmsg.err14 + '['+ start + ' - ' + end +'].');
I.value = I.defaultValue;
return false;
}
else
I.value = d;	// strip 0
return true;
}
function valid_rangeNEW(I,start,end,M)
{
M1 = unescape(M);
if(!isdigit(I,M1))
return false;
d = parseInt(I.value, 10);
if ( !(d<=end && d>=start) )
{
alert(errmsg.err14 + '['+ start + ' - ' + end +'].');
window.onblur=document.getElementById(I.id).blur();
I.value = I.defaultValue;
return false;
}
else
I.value = d;    // strip 0
return true;
}
function valid_mac(I,T)
{
var m1,m2=0;
if(I.value.length == 1)
I.value = "0" + I.value;
m1 =parseInt(I.value.charAt(0), 16);
m2 =parseInt(I.value.charAt(1), 16);
if( isNaN(m1) || isNaN(m2) )
{
alert(errmsg.err15);	
I.value = I.defaultValue;
}
I.value = I.value.toUpperCase();
if(T == 0)                                                              
{                                                                       
if((m2 & 1) == 1){                               
alert(errmsg.err16);
I.value = I.defaultValue;                       
}                                                       
}                       
}
function valid_macs_12(I){	
var m,m3;	
if(I.value == "")
return true;
else if(I.value.length==12){
for(i=0;i<12;i++){			
m=parseInt(I.value.charAt(i), 16);			
if( isNaN(m) )				
break;		
}		
if( i!=12 ){
alert(errmsg.err17);
I.value = I.defaultValue;		
return false;
}	
}	
else{		
alert(errmsg.err5);
I.value = I.defaultValue;	
return false;
}
I.value = I.value.toUpperCase();
if(I.value == "FFFFFFFFFFFF"){
alert(errmsg.err19);
I.value = I.defaultValue;	
return false;
}
if(check_multicast_mac(I.value)){
I.value = I.defaultValue;	
return false;
}
m3 = I.value.charAt(1);
if((m3 & 1) == 1 || m3 == 'B' || m3 == 'D' || m3 == 'F'){ //modified by michael to deny the "B/D/F" char at 20080422
alert(errmsg.err16);
I.value = I.defaultValue;                       
return false;
}       
return true;                                                
}
function valid_macs_17(I)
{
oldmac = I.value;
var mac = ignoreSpaces(oldmac);
if (mac == "") 
{
alert(errmsg.err17);
I.value = I.defaultValue;
return false;
}
var m = mac.split(":");
if (m.length != 6) 
{
alert(errmsg.err21);
I.value = I.defaultValue;		
return false;
}
var idx = oldmac.indexOf(':');
if (idx != -1) {
var pairs = oldmac.substring(0, oldmac.length).split(':');
for (var i=0; i<pairs.length; i++) {
nameVal = pairs[i];
len = nameVal.length;
if (len != 2) {
alert(errmsg.err17);
I.value = I.defaultValue;		
return false;
}
for(iln = 0; iln < len; iln++) {
ch = nameVal.charAt(iln).toLowerCase();
if (ch >= '0' && ch <= '9' || ch >= 'a' && ch <= 'f') {
}
else {
alert (errmsg.err23);
I.value = I.defaultValue;		
return false;
}
}	
}
}
I.value = I.value.toUpperCase();
if(I.value == "FF:FF:FF:FF:FF:FF"){
alert(errmsg.err19);
I.value = I.defaultValue;	
return false;
}
if(check_multicast_mac(I.value)){
I.value = I.defaultValue;	
return false;
}
m3 = I.value.charAt(1);
if((m3 & 1) == 1 || m3 == 'B' || m3 == 'D' || m3 == 'F'){ //modified by michael to deny the "B/D/F" char at 20080422
alert(errmsg.err16);
I.value = I.defaultValue;                       
return false;
}                                                       
return true;
}
function ignoreSpaces(string) {
var temp = "";
string = '' + string;
splitstring = string.split(" ");
for(i = 0; i < splitstring.length; i++)
temp += splitstring[i];
return temp;
}
function check_space(I,M1){
M = unescape(M1);
for(i=0 ; i<I.value.length; i++){
ch = I.value.charAt(i);
if(ch == ' '){
alert(errmsg2.err10);
I.value = I.defaultValue;	
return false;
}
}
return true;
}
function valid_key(I,l){	
var m;	
if(I.value.length==l*2)	{		
for(i=0;i<l*2;i++){			 
m=parseInt(I.value.charAt(i), 16);
if( isNaN(m) )				
break;		
}		
if( i!=l*2 ){		
alert(errmsg.err25);			
I.value = I.defaultValue;		
}	
}	
else{		
alert(errmsg.err26);		
I.value = I.defaultValue;	
}
}
function special_char_trans(I)
{ 
var bbb = I ; 
var ccc = bbb.replace(/\s/g,"%20");
return ccc ;
}
function valid_device_name(I)
{
if(I.value.length < 1)
{
alert(AD_FUN.MSG41);
I.value = I.defaultValue;
I.focus();
return false;
}
var re = new RegExp("[^a-zA-Z0-9-]+","gi")
if(re.test(I.value))	
{
alert(AD_FUN.MSG42);
I.value = I.defaultValue;
I.focus();
return false;
}
var re = new RegExp("^[0-9-]","gi")
if(re.test(I.value))
{
alert(AD_FUN.MSG43);
I.value = I.defaultValue;
I.focus();
return false;
}
return true;
}
function valid_name(I,M,flag)
{
isascii(I,M);
var bbb = I.value.replace(/^\s*/,"");
var ccc = bbb.replace(/\s*$/,"");
I.value = ccc;
if(flag & SPACE_NO){
check_space(I,M);
}
}
function valid_pc_name(I,M,flag)
{
if(!isascii_pc(I,M))
return false;
var bbb = I.value.replace(/^\s*/,"");
var ccc = bbb.replace(/\s*$/,"");
I.value = ccc;
if(flag & SPACE_NO){
check_space(I,M);
}
return true;
}
function wz_isascii(I,M)
{
for(i=0 ; i<I.value.length; i++){
ch = I.value.charAt(i);
if(ch < ' ' || ch > '~'){
alert(M + ' ' + share.errorASCII);
I.value = I.defaultValue;	
return false;
}
}
return true;
}
function wz_check_space(I,M1){
M = unescape(M1);
for(i=0 ; i<I.value.length; i++){
ch = I.value.charAt(i);
if(ch == ' '){
alert(M + wiz.space);
I.value = I.defaultValue;	
return false;
}
}
return true;
}
function wz_valid_name(I,M,flag)
{
var rm_head_tail_sp = I.value.replace(/^\s+/, "").replace(/\s+$/, "");
if(!wz_isascii(I, M)) return false;
if(flag & SPACE_NO){
if(!wz_check_space(I,M)) return false;
}
I.value = rm_head_tail_sp;
return true;
}
function html2Escape(sHtml) {
return sHtml.replace(/[<>&" ]/g,function(c){return {'<':'&lt;','>':'&gt;','&':'&amp;','"':'&quot;',' ':'&nbsp;'}[c];});
}
function valid_name1(I,flag)
{
var bbb = I.value.replace(/^\s*/,"");
var ccc = bbb.replace(/\s*$/,"");
var ch , i ;
I.value = ccc;
if(flag & SPACE_NO){
check_space(I,M);
}
var re = new RegExp("[^a-zA-Z0-9-_\\s]+","gi")
if (( re.test(I.value)))
{
alert(errmsg.err14+" [A - Z , a - z , 0 - 9 , - , _ ]");
I.value = I.defaultValue;
return false;
}
I.value = ccc;
return true;
}
function valid_mask(F,N,flag){
var match0 = -1;
var match1 = -1;
var m = new Array(4);
for(i=0;i<4;i++)
m[i] = eval(N+"_"+i).value;
if(m[0] == "0" && m[1] == "0" && m[2] == "0" && m[3] == "0"){
if(flag & ZERO_NO){
alert(errmsg.err27);
return false;
}
else if(flag & ZERO_OK){
return true;
}
}
if(m[0] == "255" && m[1] == "255" && m[2] == "255" && m[3] == "255"){
if(flag & BCST_NO){
alert(errmsg.err27);
return false;
}
else if(flag & BCST_OK){
return true;
}
}
for(i=3;i>=0;i--){
for(j=1;j<=8;j++){
if((m[i] % 2) == 0)   match0 = (3-i)*8 + j;
else if(((m[i] % 2) == 1) && match1 == -1)   match1 = (3-i)*8 + j;
m[i] = Math.floor(m[i] / 2);
}
}
if(match0 > match1){
alert(errmsg.err27);
return false;
}
return true;
}
function isdigit(I,M)
{
for(i=0 ; i<I.value.length; i++){
ch = I.value.charAt(i);
if(ch < '0' || ch > '9'){
alert(errmsg.err28);
I.value = I.defaultValue;	
return false;
}
}
return true;
}
function isascii(I,M)
{
for(i=0 ; i<I.value.length; i++){
ch = I.value.charAt(i);
if(ch < ' ' || ch > '~'){
alert(errmsg.err29);
I.value = I.defaultValue;	
return false;
}
}
return true;
}
function isascii_pc(I,M)
{
for(i=0 ; i<I.value.length; i++){
ch = I.value.charAt(i);
if(ch < ' ' || ch > '~' || ch == '<' || ch == '>' || ch == '/'){
alert(errmsg.err29);
return false;
}
}
return true;
}
function isxdigit(I,M)
{
for(i=0 ; i<I.value.length; i++){
ch = I.value.charAt(i).toLowerCase();
if(ch >= '0' && ch <= '9' || ch >= 'a' && ch <= 'f'){}
else{
alert(errmsg.err30);
I.value = I.defaultValue;	
return false;
}
}
return true;
}
function closeWin(var_win){
if ( ((var_win != null) && (var_win.close)) || ((var_win != null) && (var_win.closed==false)) )
var_win.close();
}
function valid_ip(F,N,M1,flag){
var m = new Array(4);
M = unescape(M1);
for(i=0;i<4;i++)
m[i] = eval(N+"_"+i).value
if(m[0] == 127 || m[0] == 224){
alert(errmsg.err31);
return false;
}
if(m[0] == "0" && m[1] == "0" && m[2] == "0" && m[3] == "0"){
if(flag & ZERO_NO){
alert(errmsg.err31);
return false;
}
}
if((m[0] != "0" || m[1] != "0" || m[2] != "0") && m[3] == "0"){
if(flag & MASK_NO){
alert(errmsg.err31);
return false;
}
}
return true;
}
function valid_ip_gw(F,I,N,G)
{
var IP = new Array(4);
var NM = new Array(4);
var GW = new Array(4);
for(i=0;i<4;i++)
IP[i] = eval(I+"_"+i).value
for(i=0;i<4;i++)
NM[i] = eval(N+"_"+i).value
for(i=0;i<4;i++)
GW[i] = eval(G+"_"+i).value
for(i=0;i<4;i++){
if((IP[i] & NM[i]) != (GW[i] & NM[i])){
alert(errmsg.err32);
return false;
}
}
if((IP[0] == GW[0]) && (IP[1] == GW[1]) && (IP[2] == GW[2]) && (IP[3] == GW[3])){
alert(errmsg.err33);
return false;
}
return true;
}
function delay(gap) //gap is in millisecs
{
var then,now; then=new Date().getTime();
now=then;
while((now-then)<gap)
{
now=new Date().getTime();
}
}
function Capture(obj)
{
document.write(obj);	
}
function __T(obj)
{
return obj;
}
function productname()
{
var title = '<% get_firmware_title("num"); %>';
if( title == "1")
document.write(share.productname1);	
else if( title == "2")
document.write(share.productname2);
else if( title == "3")
document.write(share.productname3);
else if( title == "4")
document.write(share.productname4);
else if( title == "5")
document.write(share.productname5);	
else if( title == "6")
document.write(share.productname6);
else if( title == "32")
document.write(share.productname32);
else if( title == "33")
document.write(share.productname33);
}	
function is_lanip(type,ip)
{
var lan_ip = '<% nvram_get("lan_ipaddr"); %>';
if(type == IP_FULL) {
if(lan_ip == ip)
return true;
else
return false;
}
else if(type == IP_LAST) {
var num = new Array();
num = lan_ip.split('.');
if(num[3] == ip)
return true;
else
return false;
}
}
function valid_email(I)
{
var match = 0;
for(i=0 ; i<I.value.length; i++){
ch = I.value.charAt(i);
if(ch == '@'){
match = 1;
break;
}
}
if(match == 0 || (match == 1 && i == 0) || (match == 1 && i == I.value.length-1)) {
alert(errmsg.err63);
I.value = I.defaultValue;	
I.focus();
return false;
}
else
return true;
}
function valid_domainname(I)
{
var match = 0;
var i;
isascii(I,"");
for(i=0 ; i<I.value.length; i++){
ch = I.value.charAt(i);
if(ch == '@' || ch == ' '){
match = 1;
break;
}
}
if(match == 1) {
alert(__T(errmsg.err31));
I.value = I.defaultValue;	
return false;
}
else
return true;
}
function IsEmpty(aText)
{
if ( (aText.value.length==0) || (aText.value==null))
{
return true ; 
}
else
{
return false ; 
}
}
function setCookie(name, value, expires) {
document.cookie = escape(name) + "=" + escape(value) + "; path=/" + ((expires == null) ? "" : "; expires=" + expires.toGMTString());
}
function getCookie(name) {
var cookiename = name + "=";
var dc = document.cookie;
var begin, end;
if (dc.length > 0) { 
begin = dc.indexOf(cookiename);
if (begin != -1) {
begin += cookiename.length;
end = dc.indexOf(";", begin);
if (end == -1) {
end = dc.length;
}
return unescape(dc.substring(begin, end));
}
}
return null;
}
function deleteCookie(name) {
document.cookie = name + "=; expires=Thu, 01-Jan-70 00:00:01 GMT" + "; path=/";
}
function IsEmpty(aText)
{
if ( (aText.value.length==0) || (aText.value==null))
{
return true ; 
}
else
{
return false ; 
}
}
function IsCrossRange(n1,n2,n3,n4,p1,p2)
{
var a,b,c,d ;
a = parseInt(n1,10);
b = parseInt(n2,10);
c = parseInt(n3,10);
d = parseInt(n4,10);
if ( a==0 && b==0 && c==0 && d==0 ) return false ; 
if ( p1!=p2 && p1!=0 && p2!=0 ) return false ;
if ( a<=c && b>=c && ((p1==0 || p2==0) || (p1==p2))) return true ;
if ( a<=d && b>=d && ((p1==0 || p2==0) || (p1==p2))) return true ;
if ( a>=c && b<=d && ((p1==0 || p2==0) || (p1==p2))) return true ; 
return false ;
}
function check_char(obj) 
{ 
for(i = 0; i < obj.length; i++)
{
ch = obj.charAt(i);
if(ch.search(/^[A-Za-z0-9-]/i) == -1)
return true;
}
return false;
} 
function check_ip_domain(value)
{
var count = 0;
var flag = 2;
for(i = 0; i < value.length; i++)
{
ch = value.charAt(i);
if(ch == '.')
count++;
if(count > 3)
flag = false;
else if(ch.search(/^[0-9.]/i) == -1)
flag = true; 
}
if(flag == true)
return check_domain(value);
else if(flag == false)
return false;
if(check_ip(value))
return true;
else
return false;
}
function check_domain( domain_main)
{
var sub_name;
var temp_firstchar;
var temp_endchar;    
if ( (domain_main.length==0) || (domain_main==null) || (domain_main.length > 256))
return false;
else
{
temp_firstchar = domain_main.charAt(0);
temp_endchar = domain_main.charAt(domain_main.length-1);
if((temp_firstchar.search(/^[A-Za-z0-9]/i) == -1) ||
(temp_endchar.search(/^[A-Za-z0-9]/i) == -1))
return false;
}
sub_name = domain_main.split(/\./);  
if(sub_name.length < 3)
return false;
for(var i = 0; i < sub_name.length; i++)
{
if((sub_name[i].length > 0) && (sub_name[i].length < 2) || (sub_name[i].length > 63))
return false;
else if(check_char(sub_name[i]))
return false;
}
return true;
}
function check_ip(ip_addr)
{
var sub_ip;
var host_id;
if (ip_addr.search(/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/) == -1)
return false;
sub_ip = ip_addr.split(/\./);   
if (sub_ip[0] >= 0xff || sub_ip[1] >= 0xff || sub_ip[2] >= 0xff || sub_ip[3] >= 0xff)
return false;   
if(sub_ip[0] == 0 && sub_ip[1] == 0 && sub_ip[2] == 0 && sub_ip[3] == 0)
return false;  
if(sub_ip[3] == 0 || sub_ip[3] == 255)
return false;
if((sub_ip[0] == 127) && (sub_ip[1] == 0) && (sub_ip[2] == 0) && (sub_ip[3] == 1))
return true;
if(sub_ip[0] < 128) /* A class */
{
if(sub_ip[0] == 0 || sub_ip[0] == 127)
return false;
host_id = sub_ip[1] * 0x10000 + sub_ip[2] * 0x100 + sub_ip[3] * 0x1;
if(host_id == 0 || host_id == 0xffffff)
return false;
}
else if(sub_ip[0] < 192) /* B class */
{
host_id = sub_ip[2] * 0x100 + sub_ip[3] * 0x1; 
if(host_id == 0 || host_id == 0xffff)
return false;           
}
else if(sub_ip[0] < 224) /* C class */
{
host_id = sub_ip[3] * 0x1;
if(host_id == 0 || host_id == 0xff)
return false;             
}
else  /* Limit broadcast, Multicast net */
{
return false;                                         
}    
return true;
}
function string_break(len,src)
{
var line = parseInt(src.length/len) ;
var i ,dst="" ;
if ( line == 0 ) return src;
if ( parseInt(src%len) != 0 ) line ++ ;
for(i=0; i<line; i++)
{
dst = dst + src.substring(0,len)+"<BR>";
src = src.substring(len,src.length);
}
return dst ;
}
function chk_multi_port(F,count,starti,xfrom,xto,xport)
{
var i=0,j=0;
var flg = true ;
for(i=0; i<count; i++)
{
for(j=i+1; j<count; j++)
{
if ( eval(xfrom+parseInt(starti+i)+".value") == 0  || eval(xto+parseInt(starti+i)+".value") == 0 )
continue;
if ( (eval(xport+parseInt(starti+i)+".value") ==  eval(xport+parseInt(starti+j)+".value")) ||
((eval(xport+parseInt(starti+i)+".value") == "both") ||
(eval(xport+parseInt(starti+j)+".value") == "both")))
{
if( eval(xfrom+parseInt(starti+i)+".value") == eval(xfrom+parseInt(starti+j)+".value") )
{
flg = false ;
break;
}
}
}
if ( flg == false ) break;
}
if ( flg == false ) alert( errmsg.err74 ) ;
return flg ;
}
function check_addr(data) // ita add it
{
var data_A = new Array();
var len = data.split(" ").length;
var b,data;
data_A = data.split(" ");
for( var a=0 ; a < len ; a++){
for( b=a+1 ; b < len ; b++ ){
if((data_A[a]!='0,0,both,0')&&(data_A[b]!='0,0,both,0')&&(data_A[a]==data_A[b])){
alert(errmsg.err73);
return false;
}
}
}
}
function check_port(i_startport,i_endport,o_startport,o_endport)
{
var tmp_port;
if(i_startport > i_endport)
{
tmp_port = i_startport;
i_startport =i_endport;
i_endport = tmp_port;
}
if(o_startport > o_endport)
{
tmp_port = o_startport;
o_startport = o_endport;
o_endport = tmp_port;
}
if((i_startport <= o_startport) && (i_endport >= o_endport))
return false;
else if((i_startport >= o_startport) && (i_startport <= o_endport) && (i_endport >= o_endport))
return false ; 
else if((i_endport >= o_startport) && (i_endport <= o_endport))
return false;
else if((i_startport >= o_startport) && (i_endport <= o_endport))
return false;
else if((i_startport == o_endport) || (i_endport == o_startport) || (i_endport == o_endport))
return false;
return true;
}
function draw_table(is_mfun,ntitle)
{
var HLINK = "";
if( window.Menu )
{
if ( close_session == "1" )
{
var HLINK = "<a class=AU target=_blank href="+Menu[SelectItemIdx][SelectSubItem][DHELP]+">"+share.help+"...</a>";
}
else
{
HLINK = "<a class=AU target=_blank href="+Menu[SelectItemIdx][SelectSubItem][DHELP]+";session_id="+session_key+">"+share.help+"...</a>";
}
}
if ( is_mfun == MAINTITLE ) 
{
document.write('<div class="TitleofContent">' + ntitle + '</div>');
}
else if ( is_mfun == MAINFUN2 ) 
{
document.write('<div class="table-title">' + ntitle + '</div>');
document.write('<hr class="table-title-underline">');
}
else if ( is_mfun == MAINFUN ) 
document.write("<TD class=TITLE1 colspan=2>"+ntitle+"</TD><TD colspan=2 class=FUNNAME1></TD>");
else if ( is_mfun == SUBFUN ) 
document.write("<TD class=TITLE2>"+ntitle+"</TD><TD class=TITLE_IMG></TD>");
else if ( is_mfun == ISHR ) 
document.write("<TD class=TITLE2></TD><TD class=TITLE_IMG></TD><TD class=FUNNAME1 colspan=2><HR></TD>");
else if ( is_mfun == ISHRS ) 
document.write("<TD class=TITLE2></TD><TD class=TITLE_IMG></TD><TD class=FUNNAME1 colspan=2><HR class=HR_S></TD>");
else if ( is_mfun == ISBLANK ) 
document.write("<TD class=TITLE2></TD><TD class=TITLE_IMG></TD><TD class=FUNNAME1 colspan=2>&nbsp;</TD>");
else if ( is_mfun == ISTAIL ) 
document.write("<TD class=TITLE2></TD><TD class=TITLE_IMG></TD><TD class=FUNNAME1 colspan=2></TD><TD class=HELP4></TD><TD class=HELP3 rowspan=2></TD>");
else if ( is_mfun == ISHELP_TAIL ) 
document.write("<TD class=HELP2></TD><TD class=HELP3 rowspan=2></TD>");
else if ( is_mfun == ISHELP_LINK ) 
document.write(HLINK);
else if ( is_mfun == ISHELP ) 
document.write("<TD class=HELP></TD><TD class=HELP1><p class=HELP_P>"+HLINK+"</p></TD>");
else if ( is_mfun == ISHELP2 ) 
document.write("<TD class=HELP></TD><TD class=HELP1><p class=HELP_P1>"+ntitle+"</p></TD>");
}
function draw_bottom(link,text,name,cls)
{
name = name || '';
cls  = cls || '';
if ( text == sbutton.cancel || text == portsrv.cancel)
if(link == "")
document.write('<button class="btncancel ' + cls + '" id="btnCancel" type="button" name="' + name + '" onclick="document.location.reload(true)">' + text + '</button> ');
else if( /^javascript:/.test(link) )
document.write('<button class="btncancel ' + cls + '" id="btnCancel" type="button" name="' + name + '" onclick="' + link + '">' + text + '</button> ');
else
document.write('<button class="btncancel ' + cls + '" id="btnCancel" type="button" name="' + name + '" onclick="document.location.replace(\'' + link + '\')">' + text + '</button> ');
else if ( text == sbutton.save ) 
if( /^javascript:/.test(link) )
document.write('<button class="btn btn-primary ' + cls + '" id="btnSave" type="button" name="' + name + '" onclick="' + link + '">' + text + '</button> ');
else
document.write('<button class="btn btn-primary ' + cls + '" id="btnSave" type="button" name="' + name + '" onclick="to_submit(document.forms[0])">' + text + '</button> ');
else if ( text == sbutton.refresh ) 
if(link == "")
document.write('<button class="btn ' + cls + '" id="btnRefresh" type="button" name="' + name + '" onclick="document.location.reload(true)">' + text + '</button> ');
else if( /^javascript:/.test(link) )
document.write('<button class="btn ' + cls + '" id="btnRefresh" type="button" name="' + name + '" onclick="' + link + '">' + text + '</button> ');
else
document.write('<button class="btn ' + cls + '" id="btnRefresh" type="button" name="' + name + '" onclick="document.location.replace(\'' + link + '\')">' + text + '</button> ');
else
if( /^javascript:/.test(link) )
document.write('<button class="btn ' + cls + '" type="button" name="' + name + '" onclick="' + link + '">' + text + '</button> ');
else
document.write('<button class="btn ' + cls + '" type="button" name="' + name + '" onclick="document.location.replace(\'' + link + '\')">' + text + '</button> ');
}
function check_multicast_mac(data)
{
var mac_arr = new Array("0000","0001","0000","0000","0101","1110");
var nmac = new Array();
var imac = new Array();
var i,j,k=0,range="";
if ( data.length == 17 )
{
nmac = data.split(":");
for(i=0; i<6; i++)
{
for(j=0; j<2; j++)
{
imac[k] = trans16to2(nmac[i].charAt(j));
k++;
}
}
}
else if ( data.length == 12 ) 
{
for(i=0; i<12; i++)
{
imac[k] = trans16to2(data.charAt(i));
k++;
}
}
else 
return false;
for(i=0; i<6; i++)
{
for(j=0; j<4; j++)
{
if ( mac_arr[i].charAt(j) != imac[i][j] ) return false ;
}
}
for(i=6; i<8; i++)
{
for(j=0; j<4; j++)
{
range = range + imac[i][j] ;
}
}
range = trans2to10(range);
if ( range <= 127 )
{
alert(errmsg.err75);
return true ;
}
return false ;
}
function trans16to2(data)
{
var str = new Array("A","B","C","D","E","F");
var num = new Array(10,11,12,13,14,15);
var sd = new Array(0,0,0,0);
var i,x,y;
if(data < '0' || data > '9')
{
data = data.toUpperCase();
for(i=0; i<str.length; i++)
{
if ( data.indexOf(str[i])!=-1 )
{
data = num[i];
break;
}
}
}
for(i=3; i>=0; i--)
{
sd[i] = parseInt(data%2);
data = parseInt(data/2);
}
return sd;
}
function trans2to10(data)
{
var num=0,i,j;
for(i=0; i<8; i++)
{
j = 7-i;
num = num + parseInt(data.charAt(j))*(1<<i);
}
return num ;
}
function DHCP_IP_RANGE(F,submask,lanip3)
{
var mask = new Array();
var lainip3,iplen,iprange,i,st,et;
mask = submask.split(".");
iprange = 256 - parseInt(mask[3]);
iplen = 256/iprange;
MAX_RANGE_COUNT = iprange-3 ; // 3 =  Network IP + Broadcast IP + Router IP
if ( iprange > 50 ) 
RANGE_COUNT = 50;
else
RANGE_COUNT = iprange - 3 ; 
for(i=0; i<iplen; i++)
{
if( iplen == 1 && lanip3 == 1 ) 
{
DHCP_START_IP[0] = "100" ;
DHCP_END_IP[0] = parseInt(DHCP_START_IP[0])+parseInt(RANGE_COUNT)-1;
RANGE_SET = 1 ; 
return true ; 
}
else
{
st = i*iprange ; 
et = ((i+1)*iprange)-1;
if ( lanip3 == st ) 
{
RANGE_SET = -1 ; 
return errmsg.err77 ; 			
}
if( lanip3 == et)
{
RANGE_SET = 0 ; 
return errmsg.err78 ;  
}
if (( parseInt(st) < parseInt(lanip3) ) && ( parseInt(lanip3) < parseInt(et) ))
{
st = st + 1 ; //It cannot be the network IP
if ( st == lanip3 ) 
{
DHCP_START_IP[0] = st+1;
DHCP_END_IP[0] = parseInt(DHCP_START_IP[0])+parseInt(RANGE_COUNT)-1;
RANGE_SET = 1 ;
return true ; 
}
else
{
if ( lanip3 - st >= RANGE_COUNT ) 
{
DHCP_START_IP[0] = st ; 
DHCP_END_IP[0] = parseInt(DHCP_START_IP[0]) + parseInt(RANGE_COUNT) -1 ; 
RANGE_SET = 1; 
}
else
{
DHCP_START_IP[0] = st ; 
DHCP_END_IP[0] = parseInt(lanip3)-1;
DHCP_START_IP[1] = parseInt(lanip3)+1;
DHCP_END_IP[1] = parseInt(DHCP_START_IP[1])+parseInt(RANGE_COUNT)-(parseInt(DHCP_END_IP[0])-parseInt(DHCP_START_IP[0]))-2;
RANGE_SET = 2 ; 
return true; 
}
}
}
}	
}		
return false ; 
}
function valid_subnet(F,I,N,G)
{
var IP = new Array(4);
var NM = new Array(4);
var GW = new Array(4);
for(i=0;i<4;i++)
IP[i] = eval(I+"_"+i).value
for(i=0;i<4;i++)
NM[i] = eval(N+"_"+i).value
for(i=0;i<4;i++)
GW[i] = eval(G+"_"+i).value
for(i=0;i<4;i++){
if((IP[i] & NM[i]) != (GW[i] & NM[i])){
return false;
}
}
return true;
}
function layerWrite(id,nestref,text)
{
if(ns4)
{
var lyr = (nestref)? eval('document.'+nestref+'.document.'+id+'.document') : document.layers[id].document ;
lyr.open();
lyr.write(text);
lyr.close();
}
else if (ie4)
document.all[id].innerHTML = text ;
else if(ns6)
document.getElementById(id).innerHTML = text ;
}
/* below functions are KK add */
function draw_button()
{
draw_bottom.apply(this, arguments);
}
function draw_radio(name, str, val, evt, chk)
{
if(Object.prototype.toString.call(str) != '[object Array]')
str = [str];
if(Object.prototype.toString.call(val) != '[object Array]')
val = [val];
if( typeof evt == 'undefined' )
evt = '';
if( typeof chk == 'undefined' )
chk = -1;
var html = '',
epy  = '',
cls  = '',
attr = '';
for( var i = 0 ; i < str.length ; i++ )
{
epy  = '';
cls = '';
attr = '';
if( !str[i].length )
epy = 'empty';
if( i == chk )
{
cls = 'checked';
attr = 'checked="checked"';
}
html = '\
<div class="radio ' + epy + '">\
<span class="' + cls + '"><input type="radio" name="' + name + '" value="' + val[i] + '" onclick="' + evt + ';update_checked(this.name)" ' + attr + ' /></span>\
</div>\
';
if( str[i] )
html += '\
<span class="radiostd">' + str[i] + '</span>\
';
document.write(html);
}
}
function draw_checkbox(name, str, val, evt, chk)
{
if( typeof str == 'undefined' )
str = '';
if( typeof val == 'undefined' )
val = '';
if( typeof evt == 'undefined' )
evt = '';
if( typeof chk == 'undefined' )
chk = false;
var html = '',
epy  = '',
cls  = '',
attr = '';
if( !str.length )
epy = 'empty';
if( chk )
{
cls = 'checked';
attr = 'checked="checked"';
}
var lang = '<% get_lang(); %>';
if(lang == 'ar')
{	
html = '\
<div class="checker ' + epy + '">\
<span class="' + cls + '"><input type="checkbox" id="' + name + '" name="' + name + '" value="' + val + '" onclick="' + evt + ';update_checked(this.name)" ' + attr + ' /></span>\
</div>\
<span class="checkstd">' + " " + str + '</span>\
';
}
else
{
html = '\
<div class="checker ' + epy + '">\
<span class="' + cls + '"><input type="checkbox" id="' + name + '" name="' + name + '" value="' + val + '" onclick="' + evt + ';update_checked(this.name)" ' + attr + ' /></span>\
</div>\
<span class="checkstd">' + str + '</span>\
';
}
document.write(html);
}
function update_checked(name)
{
var obj = null,
prt = null;
if( name.length && typeof name == 'string' )
obj = document.getElementsByName(name);  // element name
else if( !name.length )
obj = [name]; // single element
else
obj = name; // element group
for( var i = 0 ; i < obj.length ; i++ )
{
prt = obj[i].parentNode || obj[i].parentElement;
if(obj[i].checked)
addClassName(prt, 'checked');
else
delClassName(prt, 'checked');
if(obj[i].disabled)
addClassName(prt, 'disabled');
else
delClassName(prt, 'disabled');
}
}
function draw_select(name, str, val, evt, sel)
{
if( typeof str == 'undefined' )
str = [];
if( typeof val == 'undefined' )
val = [];
if( typeof evt == 'undefined' )
evt = '';
sel = get_selected_idx(val, sel);
var hvsl = false,
attr = '',
html = '\
<div class="selector">\
<span class="selectSpan">\
<p>' + str[sel] + '</p>\
</span>\
<select class="selectOption valid untouched pristine" id="' + name + '" name="' + name + '" onchange="' + evt + ';update_selected(this.name)">\
';
for( var i = 0 ; i < str.length ; i++ )
{
attr = '';
if( i == sel )
attr = 'selected';
html += '\
<option value="' + val[i] + '" ' + attr + '>' + str[i] + '</option>\
';
}
html += '\
</select>\
</div>\
';
document.write(html);
return {
width: function(width){
set_select_width(name, width);
}
}
}
function update_selected(name)
{
var obj = null,
txt = null,
prt = null,
dev = null;
if( name.length && typeof name == 'string' )
obj = document.getElementsByName(name);
else if( name.options )
obj = [name]; // single element
else
obj = name; // element group
if( obj.length )
obj = obj[0];
else
return;
if( obj.size && parseInt(obj.size) >= 1 )
return;
if( !obj.name || obj.name == '' )
return;
prt = obj.parentNode || obj.parentElement;
txt = obj.options[obj.selectedIndex].innerHTML || '';
dev = prt.getElementsByClassName('selectSpan');
if( dev.length )
dev = dev[0].children;
if( dev.length )
dev[0].innerHTML = txt;
if(obj.disabled)
addClassName(prt, 'disabled');
else
delClassName(prt, 'disabled');
}
function set_select_width(name, width)
{
var obj = [name],
prt = null;
if( name.length && typeof name == 'string' )
obj = document.getElementsByName(name);
if( obj.length )
obj = obj[0];
else
return;
prt = obj.parentNode || obj.parentElement;
prt.style.minWidth = 'auto';
prt.style.width = width;
}
function get_selected_idx(vals, val)
{
for( var i = 0 ; i < vals.length ; i++ )
if( vals[i] == val )
return i;
return 0;
}
function set_selected_idx(name, val)
{
var obj = null;
if( name.length && typeof name == 'string' )
obj = document.getElementsByName(name);
else if( name.options )
obj = [name]; // single element
else
obj = name; // element group
if( obj.length )
obj = obj[0];
else
return;
for( var i = 0 ; i < obj.options.length ; i++ )
{
if( obj.options[i].value == val )
{
obj.selectedIndex = i;
break;
}
}
update_selected(obj);
}
function draw_title_button(/* title, ... */)
{
var args = Array.prototype.slice.call(arguments);
document.write('<div class="table-title table-title-group">');
document.write('<span>' + args.shift() + '</span>&nbsp;&nbsp;&nbsp;');
draw_button.apply(this, args);
document.write('</div>');
document.write('<hr class="table-title-underline">');
}
function addClassName(obj, name){
var cls = (obj.className || '').split(' '),
names = [],
found = 0;
for(var i = 0, j = 0 ; i < cls.length ; i++)
{
if(cls[i].length == 0) continue;
names[j++] = cls[i];
if( cls[i] == name )
found = 1;
}
if( found == 0 )
names[j] = name;
obj.className = names.join(' ');
}
function delClassName(obj, name){
var cls = (obj.className || '').split(' '),
names = [];
for(var i = 0, j = 0 ; i < cls.length ; i++)
{
if(cls[i].length == 0) continue;
if( cls[i] != name )
names[j++] = cls[i];
}
obj.className = names.join(' ');
}
function getWin(){
/* check is in iframe, if in iframe use the parent */
if( window.self !== window.top )
return parent;
return window;
}
function resizeIframe(obj){
if( (obj.contentWindow || obj.contentDocument).document.login )
getWin().document.location.reload();
obj.style.height = 0;
obj.style.height = (obj.contentWindow || obj.contentDocument).document.body.scrollHeight + 'px';
}
/* pop-out */
function resizePopout(){
resizeIframe(getWin().document.getElementById('popIframe'));
visiblePopout();
}
function showPopout(page,width){
addClassName(document.body,'modal-open');
showWait();
document.getElementById('popModal').style.display = 'block';
document.getElementById('popModalDialog').style.maxWidth = width || '';
document.getElementById('popModalContent').innerHTML = '<iframe id="popIframe" src="' + setActionLink(page) + '" width="100%" height="auto" frameborder="0" scrolling="no" onload="resizePopout()"></iframe>';
}
function displayPopout()
{
var doc = getWin().document;
addClassName(doc.body,'modal-open');
doc.getElementById('popModal').style.display = 'block';
}
function hidePopout(){
var doc = getWin().document;
delClassName(doc.body,'modal-open');
doc.getElementById('popModal').style.display = 'none';
}
function closePopout(){
if( typeof window.formBtns.close != 'undefined' && /^javascript:/.test(window.formBtns.close) )
eval(window.formBtns.close);
getWin().hidePopout();
}
function hiddenPopout(){
getWin().document.getElementById('popModal').style.visibility = 'hidden';
}
function visiblePopout(){
hideWait();
getWin().document.getElementById('popModal').style.visibility = 'visible';
}
/* wizard */
function resizeWizard(){
resizeIframe(getWin().document.getElementById('wizardIframe'));
visibleWizard();
}
function showWizard(page){
addClassName(document.body,'modal-open');
showWait();
document.getElementById('wizardModal').style.display = 'block';
document.getElementById('wizardModalContent').innerHTML = '<iframe id="wizardIframe" src="' + setActionLink(page) + '" width="100%" height="auto" frameborder="0" scrolling="no" onload="resizeWizard()"></iframe>';
}
function displayWizard()
{
var doc = getWin().document;
addClassName(doc.body,'modal-open');
doc.getElementById('wizardModal').style.display = 'block';
}
function hideWizard(){
var doc = getWin().document;
delClassName(doc.body,'modal-open');
doc.getElementById('wizardModal').style.display = 'none';
}
function closeWizard(){
getWin().hideWizard();
}
function hiddenWizard(){
getWin().document.getElementById('wizardModal').style.visibility = 'hidden';
}
function visibleWizard(){
hideWait();
getWin().document.getElementById('wizardModal').style.visibility = 'visible';
}
/* wait */
function showWait(time,hide){
if(hide)
{
hidePopout();
if(getWin().document.getElementById('wizardModal'))
hideWizard();
}
hiddenPopout();
hiddenWizard();
if(time > "65")
getWin().document.getElementById('waitReboot').style.display = 'block';
else
getWin().document.getElementById('waitBox').style.display = 'block';
}
function hideWait(time){
if(!time || time == "0")
getWin().document.getElementById('waitBox').style.display = 'none';
else if(time < "65")
setTimeout(function(){getWin().document.getElementById('waitBox').style.display = 'none';},time*1000);
else 
setTimeout(function(){getWin().document.getElementById('waitReboot').style.display = 'none';},time*1000);
}
/* Form Action - Button Defines */
window.formBtns = {};
function setFormActions(btns){
window.formBtns = btns;
}
function hasFormActions(){
for( var x in window.formBtns )
{
if( !window.formBtns.hasOwnProperty(x) )
continue;
if( window.formBtns[x] )
return true;
}
return false;
}
function setActionLink(link){
if( link.indexOf(';session_id=') != -1 )
return link;
if( close_session != "1" )
link += ';session_id=' + session_key;
return link;
}
var initFormData = null,
doInitFormData = false;
function setInitFormData(func)
{
doInitFormData = true;
func();
}
function isFormChanged(forj)
{
fobj = fobj || document.forms[0];
if( initFormData !== null )
{
if( initFormData === $(fobj).serialize() )
{
alertInfo(other.nothingchg);
return false;
}
}
return true;
}
function ajaxSubmit(time, replace, url){
var args = Array.prototype.slice.call(arguments),
fobj = document.forms[0],
wait = 3,
func = function(){},
type = null,
arg;
while( args.length )
{
arg = args.shift();
type = Object.prototype.toString.call(arg);
if( type == "[object Number]" )
func = wait;
else if( type == "[object Function]" )
func = arg;
else if( arg.tagName && arg.tagName == 'FORM' )
fobj = arg;
}
if( fobj.wait_time && fobj.wait_time.value )
wait = fobj.wait_time.value || wait;
if( doInitFormData )
{
doInitFormData = false;
initFormData = $(fobj).serialize();
return;
}
if( initFormData !== null )
{
if( initFormData === $(fobj).serialize() )
{
alertInfo(other.nothingchg);
return;
}
}
hideAlert();
showWait(time);
$.post(fobj.action, $(fobj).serialize(), function(data){
if(replace == "false" || replace == "afterSuccess" || replace == "afterSave"){
if( data.indexOf('Fail') != -1 )
{
hideWait();
alertError(fail.msg);
}
else if( data.indexOf('action="login.cgi"') != -1 )
document.location.reload();
else if(data.indexOf('Success') != -1)
{
setTimeout(function(){
hideWait(time);
alertSuccess(other.succsavechg,time,replace);
func();
}, wait * 1000);
initFormData = $(fobj).serialize();
}
}
if(replace == "true")
{
if(url)
{
setTimeout(function(){
hideWait(0);
window.location.href=url;
},time *1000);
}
else
setTimeout(function(){document.location.reload();},time *1000);
}});
if(replace == "check")
setTimeout(function(){document.location.reload();},time *1000);
}
function checkFormChanged(fobj){
fobj = fobj || document.forms[0];
if( initFormData !== null && document.forms[0].submit_button.value !== "logout")
{
if( initFormData !== $(fobj).serialize() )
{
return "";
}
}
}
/* alert area */
var alertTimer = null;
function showAlert(type, str)
{
var obj = document.getElementById('alertArea'),
title = '',
cls = ''
sec = 3;
obj.className = 'alert';
if( type == 1 )
{
cls = 'success';
title = other.success;
}
else if( type == 2 )
{
cls = 'warning';
title = pctrl.warning;
sec = 5;
}
else if( type == 3 )
{
cls = 'danger';
title = other.error;
sec = 10;
}
else if( type == 4 )
{
cls = 'success';
title = other.success;
}
else if ( type == 5 )
{
cls = 'danger';
title = other.error;
}
else if( type == 6 )
{
cls = 'success';
title = other.success;;
}	
else if( type == 7 )
{
cls = 'danger';
title = other.error;
}
else
{
cls = 'info';
title = other.info;
}
addClassName(obj, 'alert-' + cls);
obj.getElementsByTagName('h4')[0].innerHTML = title;
obj.getElementsByTagName('p')[0].innerHTML = str;
obj.style.display = '';
alertTimer = setTimeout(hideAlert, sec * 1000);
}
function hideAlert()
{
clearTimeout(alertTimer);
document.getElementById('alertArea').style.display = 'none';
}
function alertInfo(str)
{
showAlert(0, str);
}
function alertSuccess(str, time, replace)
{
if(!time || time == "0"||time == "[object HTMLFormElement]")
{
showAlert(1, str || other.succsavechg);
}
else
setTimeout(function(){showAlert(1, str || other.succsavechg);},time *1000);
if(time == "[object HTMLFormElement]")
setTimeout(function(){document.location.replace('Router_Login.asp');},1000);
if(replace == "afterSuccess")
setTimeout(function(){document.location.replace('Router_Login.asp');},time *1000 + 1000);
if(replace == "afterSave")
setTimeout(function(){document.location.reload();},time *1000 + 1000);
}
function alertWarning(str)
{
showAlert(2, str);
}
function alertError(str)
{
showAlert(3, str);
}
function alertUpgradeSuccess(str)
{
showAlert(4, str);
}
function alertUpgradeFailed(str)
{
showAlert(5, str);
}
function alertRestoreSuccess(str)
{
showAlert(6, str);
}
function alertRestoreFailed(str)
{
showAlert(7, str);
}
/*Emily Add start*/
function HIDDEN_PART(tagname,start,end,flag)
{
var i,starti,endi;
var obj = document.getElementsByTagName(tagname);
var len = obj.length;
for(i=0; i<len; i++)
{ 
if( obj[i].id.indexOf(start)!=-1) starti = i;
if( obj[i].id.indexOf(end)!=-1) endi = i;
}
if( starti == undefined ) return true;
if( endi == undefined) endi = starti;
for(i=starti; i<=endi; i++)
{
if(flag==0)
document.getElementsByTagName(tagname)[i].style.display='table-row';
else
document.getElementsByTagName(tagname)[i].style.display='none';
}
}   
/*Emily Add End*/
function alignright(id)
{
if('<% get_lang(); %>' == 'ar')
document.getElementById(id).align="right";
}
