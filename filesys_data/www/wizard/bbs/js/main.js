/* Aug 14, 2014--Modifications were made by U-Media Communication, inc.
* Copyright (c) 2014, U-Media Communications, Inc. All Rights Reserved. */
var userAgent = navigator.userAgent;
var referer = document.referrer;
/* re-define alert function
window.alert = function(text) {
if(document.getElementById("alert_box") && document.getElementById("alert_message")) {
text=text.toString().replace(/\\/g,'\\').replace(/\n/g,'<br />').replace(/\r/g,'<br />');
$("#alert_message").html(text);
$("#alert_box").reveal({ animation: 'fade', animationspeed: 100 });
} else {
delete window.alert;
alert(text);
}
}
*/
var bbs = new Object();
var TOO_STRONG = -30; //dBm
var TOO_WEAK = -75; //dBm
var DEBUG = 0;
function deactivateAll(cnt) {
for (var i=1; i<=cnt; i++) {
var clss = document.getElementById('item'+ i).className;
document.getElementById('item'+ i).className = clss.replace(/activerow/, '');
}
}
function getQuerystring(key, default_) {
if (default_ == null) default_=""; 
key = key.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
var regex = new RegExp("[\\?&]"+key+"=([^&#]*)");
var qs = regex.exec(window.location.href);
if(qs == null) {
return default_;
} else {
return qs[1].replace(/%20/g, ' ').replace(/%27/g, "'");
}
}
function hideshow (hide, show) {
document.getElementById(hide).style.display = 'none';
document.getElementById(show).style.display = 'block';
document.getElementById(show).focus();
}
function option_select(item, value)
{
var i;
if(item) {
for (i=0; i<item.options.length; i++) {
if (item.options[i].value == value) {
item.options.selectedIndex = i;
break;
}
}
}
}
function dynamicInsert(insertName, thType) {
if (thType == "js") {
var diFile = document.createElement('script');
diFile.setAttribute("type", "text/javascript");
diFile.setAttribute("src", insertName);
} else if (thType == "css") {
var diFile = document.createElement("link");
diFile.setAttribute("rel", "stylesheet");
diFile.setAttribute("type", "text/css");
diFile.setAttribute("href", insertName);
}
if (typeof diFile != "undefined") {
document.getElementsByTagName("head")[0].appendChild(diFile);
}
}
function dynamicRemove(removeName, thType) {
var targetElement = (thType == "js") ? "script" : (thType == "css") ? "link" : "none";
var targetAttr = (thType == "js") ? "src" : (thType == "css") ? "href" : "none";
var allsuspects = document.getElementsByTagName(targetElement);
var i = allsuspects.length;
for (i; i >= 0; i--) {
if (allsuspects[i] && allsuspects[i].getAttribute(targetAttr) != null
&& allsuspects[i].getAttribute(targetAttr).indexOf(removeName) != -1) {
allsuspects[i].parentNode.removeChild(allsuspects[i]);
}
}
}
function dw(string) {
if(string)
document.write(string);
}
function dId(name) {
return document.getElementById(name);
}
function language_change(lang) {
if(lang == "SKUDEFAULT") lang = "EN";
if(lang != "") {
dw("<script type=\"text\/javascript\" src=\"lang/"+lang+".js\"><\/script>");
}
}
var http_request = false;
function donothing() {}
function makeRequest(url, content, func) {
http_request = false;
if (window.XMLHttpRequest) { // Mozilla, Safari,...
http_request = new XMLHttpRequest();
if (http_request.overrideMimeType) {
http_request.overrideMimeType('text/xml');
}
} else if (window.ActiveXObject) { // IE
try {
http_request = new ActiveXObject("Msxml2.XMLHTTP");
} catch (e) {
try {
http_request = new ActiveXObject("Microsoft.XMLHTTP");
} catch (e) {}
}
}
if (!http_request) {
return false;
}
http_request.onreadystatechange = func;
http_request.open('../../../../www.linksys.com/index.html', url, true);
}
var makeRequestFunc = makeRequest;
function transAtoH(str)
{
var loopCount=0;
var origSTR="";
var tempChar;
for (loopCount=0; loopCount<str.length; loopCount++) {
tempChar = str.charCodeAt(loopCount).toString(16).toUpperCase();
origSTR = origSTR+ tempChar;
}
return origSTR;
}
function transHtoA(str)
{
var loopCount=0;
var origSTR="";
var tempChar;
for (loopCount=0; loopCount<str.length; loopCount=loopCount+2) {
tempChar = String.fromCharCode(parseInt(str.substr(loopCount, 2), 16));
if (tempChar == '"')
origSTR = origSTR + "\"";
else
origSTR = origSTR + tempChar;
}
return origSTR;
}
function transSpace(str)
{
var loopCount=0;
var origSSID="";
var tempChar;
for (loopCount=0; loopCount<str.length; loopCount++) {
tempChar = str.charAt(loopCount);
if (tempChar == ' ')
origSSID = origSSID + "&nbsp;";
else
origSSID = origSSID + tempChar;
}
return origSSID;
}
function d2b(value)
{
var num1;
var num2=null;
var currnum;
currnum = 128;
num1 = eval(value);
if(num1 >= currnum)
{
num2 = "1";
num1 = num1 - currnum;
currnum = currnum / 2;
}
else
{
num2 = "0";
currnum = currnum / 2;
}		
for (p = 1; p <= 7; p++)
{
if(num1 >= currnum)
{
num2 = num2 + "1";
num1 = num1 - currnum;
currnum = currnum / 2;
}
else
{
num2 = num2 + "0";
currnum = currnum / 2;
}
}
return num2;
}
function atoi(str, num)
{
i=1;
if(num != 1 ){
while (i != num && str.length != 0){
if(str.charAt(0) == '.'){
i++;
}
str = str.substring(1);
}
if(i != num )
return -1;
}
for(i=0; i<str.length; i++){
if(str.charAt(i) == '.'){
str = str.substring(0, i);
break;
}
}
if(str.length == 0)
return -1;
return parseInt(str, 10);
}
function isAllNum(str)
{
for (var i=0; i<str.length; i++){
if((str.charAt(i) >= '0' && str.charAt(i) <= '9') || (str.charAt(i) == '.' ))
continue;
return 0;
}
return 1;
}
function checkRange(str, num, min, max)
{
d = atoi(str, num);
if (d*1 > max*1 || d*1 < min*1)
return false;
return true;
}
function checkMaskRange(str)
{
m = new Array(255,254,252,248,240,224,192,128,0);
for(i=0;i<9;i++)
if (str == m[i])
return true;
return false;
}
function checkIpAddr(field, ismask)
{
if (field.value == "") {
return false;
}
if (isAllNum(field.value) == 0) {
return false;
}
v = new Array(atoi(field.value, 1), atoi(field.value, 2), atoi(field.value, 3), atoi(field.value, 4) );
if (ismask) {
if (!checkMaskRange(v[0]) || !checkMaskRange(v[1]) || !checkMaskRange(v[2]) || !checkMaskRange(v[3]) ||
(v[0] < 255 && v[1]+v[2]+v[3] > 0) ||
(v[0] == 255 && v[1] < 255 && v[2]+v[3] > 0) ||
(v[0] == 255 && v[1] == 255 && v[2] < 255 && v[3] > 0) ||
field.value == "0.0.0.0" || field.value == "255.255.255.254" || field.value == "255.255.255.255")
{
return false;
}
}
else {
if(!checkRange(field.value, 1, 0, 223)){
return false;
}
if ((!checkRange(field.value, 1, 0, 255)) ||
(!checkRange(field.value, 2, 0, 255)) ||
(!checkRange(field.value, 3, 0, 255)) ||
(!checkRange(field.value, 4, 1, 254)) ||
field.value == "127.0.0.1")
{
return false;
}
}
return true;
}
function checkIPwithSubnetMask(ip1, ip2, ip3, ip4, subnet1, subnet2, subnet3, subnet4)
{
var i,j,vi=0,vj=0,zero=0,one=0;
var ip_b=new Array(d2b(ip1), d2b(ip2), d2b(ip3), d2b(ip4));
var subnet_b=new Array(d2b(subnet1), d2b(subnet2), d2b(subnet3), d2b(subnet4));
for(i=0;i<4;i++) {
for(j=0;j<8;j++) {
if(subnet_b[i].charAt(j) == "0") {
vi = i;
vj = j;
break;
}
}
}
for(i=vi;i<4;i++) {
if (i==vi) {
for(j=vj;j<8;j++) {
if(ip_b[i].charAt(j) == "0")
zero++;
else if(ip_b[i].charAt(j) == "1")
one++;
else 
return false;
}
} else {
for(j=0;j<8;j++) {
if(ip_b[i].charAt(j) == "0")
zero++;
else if(ip_b[i].charAt(j) == "1")
one++;
else 
return false;
}
}
}
if (zero == 0 && one != 0)	{
return false;
} else if (zero != 0 && one == 0) {
return false;
} else if (zero == 0 && one == 0) {
return false;
}
return true;
}
function checkGatewayIPwithSubnetMask(ip1, ip2, ip3, ip4, subnet1, subnet2, subnet3, subnet4, gw1, gw2, gw3, gw4)
{
var i,j;
var a= new Array(d2b(ip1),d2b(ip2),d2b(ip3),d2b(ip4));
var b= new Array(d2b(subnet1),d2b(subnet2),d2b(subnet3),d2b(subnet4));
var gw = new Array(d2b(gw1),d2b(gw2),d2b(gw3),d2b(gw4));
for(i=0;i<4;i++) {
for(j=0;j<8;j++) {
if(b[i].charAt(j) == "1")
if(a[i].charAt(j) != gw[i].charAt(j)) {
return false;
}
}
}
return true;
}
function MM_preloadImages() { //v3.0
var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function getCurSeconds()
{
var time = new Date();
var when = time.getTime();
return when;
}
function myBrowser(){  
var userAgent = navigator.userAgent; 
var isOpera = userAgent.indexOf("Opera") > -1; 
var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera ; 
var isFF = userAgent.indexOf("Firefox") > -1 ; 
var isSafari = userAgent.indexOf("Safari") > -1 && userAgent.indexOf("Chrome") < 1 ; 
var isChrome = userAgent.indexOf("Chrome") > -1 ; 
if(isIE){  
var IE5 = IE55 = IE6 = IE7 = IE8 = false;  
var reIE = new RegExp("MSIE (//d+//.//d+);");  
reIE.test(userAgent);  
var fIEVersion = parseFloat(RegExp["$1"]);  
IE55 = fIEVersion == 5.5 ;  
IE6 = fIEVersion == 6.0 ;  
IE7 = fIEVersion == 7.0 ;  
IE8 = fIEVersion == 8.0 ;  
if(IE55){ return "IE55"; }  
if(IE6){ return "IE6"; }  
if(IE7){ return "IE7"; }  
if(IE8){ return "IE8"; }  
}  
if(isFF){ return "FireFox"; }  
if(isOpera){ return "Opera"; }  
if(isSafari){ return "Safari"; }  
if(isChrome){ return "Chrome"; }  
} //myBrowser() end
function check_os() {
var ua = navigator.userAgent;
var ua_lower = ua.toLowerCase();
var os_type = "";
windows = (ua_lower.indexOf("windows",0) != -1)?1:0;
mac = (ua_lower.indexOf("mac",0) != -1 || ua_lower.indexOf("macintosh",0) != -1)?1:0;
linux = (ua_lower.indexOf("linux",0) != -1)?1:0;
unix = (ua_lower.indexOf("x11",0) != -1)?1:0;
android = (ua_lower.indexOf("android",0) != -1)?1:0;
if (windows) os_type = "Windows";
else if (mac) os_type = "MacOS";
else if (android) os_type = "Android";
else if (linux) os_type = "Linux";
else if (unix) os_type = "Unix";
return os_type;
}
