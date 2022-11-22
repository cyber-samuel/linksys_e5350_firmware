/* 
* func.js - Function Define.
*
* Copyright (c) U-Media Communications, Inc. All Rights Reserved.
*
* $Id: v1.0 12-Dec-2007 Jacky.Yang Exp $
*/
var IPandMask = "";
var currentIP;
var startTryProgress = 70; // 70%
var totalWaitTime=7; //second
var renewTime=500; //millisecond, progress reflash clock.
var renewClock;
var percent=0;
var redirectURL="/";
var urlPath, oldPercent, waitDHCPInfoValue;
var updateIPAddresStopToWait = true;
var updateWaitDHCPInfoStopToWait = true;
var waitCount=0;
var intval="";
var intval_cnt=0;
docTemp = IPandMask;
index = docTemp.indexOf(','); //IP
currentIP = docTemp.substr(0, index);
var current_lang = "EN";
function GetURLParameter(sParam)
{
var sPageURL = window.location.search.substring(1);
var sURLVariables = sPageURL.split('&');
for (var i = 0; i < sURLVariables.length; i++)
{
var sParameterName = sURLVariables[i].split('=');
if (sParameterName[0] == sParam)
{
return sParameterName[1];
}
}
}
function makeUpdateIPRequest(url, content) {
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
alert("Giving up :( Cannot create an XMLHTTP instance");
return false;
}
http_request.onreadystatechange = function () {alertUpdateIPContents()};
http_request.open('POST', url, true);
http_request.send(content);
}
function alertUpdateIPContents() {
if (http_request.readyState == 4) {
if (http_request.status == 200) {
/*IPandMask = http_request.responseText;
docTemp = IPandMask;
index = docTemp.indexOf(','); //IP
currentIP = docTemp.substr(0, index);*/
if (http_request.responseText != "NULL")
currentIP = http_request.responseText;
updateIPAddresStopToWait = true;
} else {
}
}
}
function updateIPAddress(){
if (updateIPAddresStopToWait == true) {
makeUpdateIPRequest("/goform/updateIPAddress", "something");
updateIPAddresStopToWait = false;
}
}
function makeWaitDHCPInfoRequest(url, content) {
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
alert("Giving up :( Cannot create an XMLHTTP instance");
return false;
}
http_request.onreadystatechange = function () {alertWaitDHCPInfoContents()};
http_request.open('POST', url, true);
http_request.send(content);
}
function alertWaitDHCPInfoContents() {
if (http_request.readyState == 4) {
if (http_request.status == 200) {
waitDHCPInfoValue = http_request.responseText;
docTemp = waitDHCPInfoValue;
index = docTemp.indexOf(','); //IP
currentIP = docTemp.substr(0, index);
updateWaitDHCPInfoStopToWait = true;
} else {
}
}
}
function waitDHCPInfo(){
if (updateWaitDHCPInfoStopToWait == true) {
waitDHCPInfoValue="";
currentIP="";
makeWaitDHCPInfoRequest("/goform/waitDHCPInfo", "something");
updateWaitDHCPInfoStopToWait = false;
}
document.getElementById("returnField").innerHTML = "<input type=button value=\"Close\" onclick=\"returnWPS();\">";
setTimeout("waitDHCPInfo()", 500);
/*if ((waitDHCPInfoValue == ""))
{
waitCount++;
setTimeout("waitDHCPInfo()", 500);
}
else
{
document.getElementById("returnField").innerHTML = "<input type=button value=\"Close\" onclick=\"returnWPS();\">";
}*/
}
function wait_page()
{	
/*if (percent > 80) {
rebootRedirect.location.href="http://" + currentIP +"/rebootredirect.shtml";
}*/
if(myBrowser()=="Chrome" || myBrowser()=="FF")//Griffin Chrome and FF use setTimeout can't work
{
if(intval=="")
{
window.clearInterval(intval);
intval="";
intval_cnt=0;
intval=window.setInterval("wait_page_intval()", 1000);//Chorme and FF always 1s
}
return;
}
if(myBrowser()!="Safari" && myBrowser()!="Chrome")
{
if ((Math.round(percent) > 50) && (Math.round(percent)%5) == 0)
rebootRedirect.location.href=redirectURL;
}
if (percent == 0)
{
renewClock=100 / ((totalWaitTime*1000)/renewTime);
objectDisplay("saveField", "none");
objectDisplay("mainform", "none");
if(current_lang != "SA"){
document.getElementById("waitform").innerHTML = "<table bolder=\"0\" style=\"margin-top:10px;\"><tr><td colspan=\"2\"><font color=red>Processing, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#ffffff\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=400 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"95%\"><font color=red><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
}
else{
document.getElementById("waitform").innerHTML = "<table bolder=\"0\" style=\"margin-top:10px;\"><tr><td colspan=\"2\"><font color=red>Processing, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#ffffff\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=400 align=\"right\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"95%\" align=\"right\"><font color=red><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
}
}
percent+=renewClock;
if (percent >= 100) {
percent = 100;
location.href = redirectURL;
return;
}
document.getElementById("progress").style.width = Math.round(percent) + "%";
document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
if (percent != 100)
window.setTimeout("wait_page()", renewTime);
}
function wait_pageSTA()
{	
if(myBrowser()=="Chrome" || myBrowser()=="FF")//Griffin Chrome and FF use setTimeout can't work
{
if(intval=="")
{
window.clearInterval(intval);
intval="";
intval_cnt=0;
intval=window.setInterval("wait_page_intval_bassic_page()", 1000);//Chorme and FF always 1s
}
return;
}
if(myBrowser()!="Safari" && myBrowser()!="Chrome")
{
if ((Math.round(percent) > 50) && (Math.round(percent)%5) == 0)
rebootRedirect.location.href=redirectURL;
}
if (percent == 0)
{
renewClock=100 / ((totalWaitTime*1000)/renewTime);
objectDisplay("saveFieldSTA", "none");
objectDisplay("mainformSTA", "none");
if(current_lang != "SA"){
document.getElementById("waitformSTA").innerHTML = "<table bolder=\"0\" style=\"margin-top:10px;\"><tr><td colspan=\"2\"><font color=red>Processing, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#ffffff\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=400 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"95%\"><font color=red><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
}
else{
document.getElementById("waitformSTA").innerHTML = "<table bolder=\"0\" style=\"margin-top:10px;\"><tr><td colspan=\"2\"><font color=red>Processing, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#ffffff\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=400 align=\"right\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"95%\" align=\"right\"><font color=red><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
}
}
percent+=renewClock;
if (percent >= 100) {
percent = 100;
location.href = redirectURL;
return;
}
document.getElementById("progress").style.width = Math.round(percent) + "%";
document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
if (percent != 100)
window.setTimeout("wait_pageSTA()", renewTime);
}
function wait_page_intval()
{	
if (percent == 0)
{
objectDisplay("saveField", "none");
objectDisplay("mainform", "none");
if(current_lang != "SA"){
document.getElementById("waitform").innerHTML = "<table bolder=\"0\" style=\"margin-top:10px;\"><tr><td colspan=\"2\"><font color=red>Processing, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#ffffff\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=400 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"95%\"><font color=red><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
}
else{
document.getElementById("waitform").innerHTML = "<table bolder=\"0\" style=\"margin-top:10px;\"><tr><td colspan=\"2\"><font color=red>Processing, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#ffffff\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=400 align=\"right\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"95%\" align=\"right\"><font color=red><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
}
}
percent=intval_cnt*100/totalWaitTime;
intval_cnt++;
if (percent >= 100) {
percent = 100;
location.href = redirectURL;
window.clearInterval(intval);
intval="";
intval_cnt=0;
return;
}
document.getElementById("progress").style.width = Math.round(percent) + "%";
document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
}
function wait_page_intval_bassic_page()
{	
if (percent == 0)
{
objectDisplay("saveFieldSTA", "none");
objectDisplay("mainformSTA", "none");
if(current_lang != "SA"){
document.getElementById("waitformSTA").innerHTML = "<table bolder=\"0\" style=\"margin-top:10px;\"><tr><td colspan=\"2\"><font color=red>Processing, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#ffffff\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=400 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"95%\"><font color=red><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
}
else{
document.getElementById("waitformSTA").innerHTML = "<table bolder=\"0\" style=\"margin-top:10px;\"><tr><td colspan=\"2\"><font color=red>Processing, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#ffffff\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=400 align=\"right\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"95%\" align=\"right\"><font color=red><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
}
}
percent=intval_cnt*100/totalWaitTime;
intval_cnt++;
if (percent >= 100) {
percent = 100;
location.href = redirectURL;
window.clearInterval(intval);
intval="";
intval_cnt=0;
return;
}
document.getElementById("progress").style.width = Math.round(percent) + "%";
document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
}
function connecting_wait_page()
{
if ( (Math.round(percent) >= 20) && ((Math.round(percent)%5) == 0) && (oldPercent != (Math.round(percent)%5))) {
updateIPAddress();
oldPercent = Math.round(percent)%5;
rebootRedirect.location.href="http://" + currentIP +"/rebootredirect.shtml";
}
/*if ((Math.round(percent) > 60) && ((Math.round(percent)%5) == 0))
rebootRedirect.location.href="http://" + currentIP +"/rebootredirect.shtml";*/
if (percent == 0)
{
renewClock=100 / ((totalWaitTime*1000)/renewTime);
objectDisplay("mainform", "none");
if(current_lang != "SA"){
document.getElementById("waitform").innerHTML = "<table bolder=\"0\" style=\"margin-top:10px;\"><tr><td colspan=\"2\"><font color=red>Processing, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#ffffff\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=400 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"95%\"><font color=red><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
}
else{
document.getElementById("waitform").innerHTML = "<table bolder=\"0\" style=\"margin-top:10px;\"><tr><td colspan=\"2\"><font color=red>Processing, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#ffffff\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=400 align=\"right\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"95%\" align=\"right\"><font color=red><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
}
}
percent+=renewClock;
if (percent >= 100) {
percent = 100;
location.href="http://" + currentIP +"/rebootredirect.shtml";
}
document.getElementById("progress").style.width = Math.round(percent) + "%";
document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
if (percent != 100)
window.setTimeout("connecting_wait_page()", renewTime);
}
function process_page()
{	
updateIPAddress();
if ((Math.round(percent) > 70) && (Math.round(percent)%5) == 0)
rebootRedirect.location.href="http://" + currentIP +"/rebootredirect.shtml";
if (percent == 0)
{
renewClock=100 / ((totalWaitTime*1000)/renewTime);
objectDisplay("mainform", "none");
if(current_lang != "SA"){
document.getElementById("waitform").innerHTML = "<table bolder=\"0\" style=\"margin-top:10px;\"><tr><td colspan=\"2\"><font color=red>Processing, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#ffffff\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=400 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"95%\"><font color=red><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
}
else{
document.getElementById("waitform").innerHTML = "<table bolder=\"0\" style=\"margin-top:10px;\"><tr><td colspan=\"2\"><font color=red>Processing, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#ffffff\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=400 align=\"right\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"95%\" align=\"right\"><font color=red><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
}
}
percent+=renewClock;
if (percent >= 100) {
percent = 100;
location.href = redirectURL;
}
document.getElementById("progress").style.width = Math.round(percent) + "%";
document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
if (percent != 100)
window.setTimeout("process_page()", renewTime);
}
function reboot_page()
{
if ((Math.round(percent) > startTryProgress) && (Math.round(percent)%5) == 0)
rebootRedirect.location.href="http://" + currentIP +"/rebootredirect.shtml";
if (percent == 0)
{
renewClock=100 / ((totalWaitTime*1000)/renewTime);
objectDisplay("mainform", "none");
if(current_lang != "SA"){
document.getElementById("waitform").innerHTML = "<table bolder=\"0\" style=\"margin-top:10px;\"><tr><td colspan=\"2\"><font color=red>Rebooting, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#ffffff\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=400 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"95%\"><font color=red><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
}
else{
document.getElementById("waitform").innerHTML = "<table bolder=\"0\" style=\"margin-top:10px;\"><tr><td colspan=\"2\"><font color=red>Rebooting, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#ffffff\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=400 align=\"right\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"95%\" align=\"right\"><font color=red><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
}
}
percent+=renewClock;
if (percent >= 100) {
percent = 100;
location.href = redirectURL;
}
document.getElementById("progress").style.width = Math.round(percent) + "%";
document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
if (percent != 100)
window.setTimeout("reboot_page()", renewTime);
}
function reboot_page_intval()
{	
if ((Math.round(percent) > 70) && (Math.round(percent)%5) == 0)
rebootRedirect.location.href="http://" + currentIP +"/rebootredirect.shtml";
if (percent == 0)
{
objectDisplay("mainform", "none");
if(current_lang != "SA"){
document.getElementById("waitform").innerHTML = "<table bolder=\"0\" style=\"margin-top:10px;\"><tr><td colspan=\"2\"><font color=red>Rebooting, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#ffffff\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=400 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"95%\"><font color=red><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
}
else{
document.getElementById("waitform").innerHTML = "<table bolder=\"0\" style=\"margin-top:10px;\"><tr><td colspan=\"2\"><font color=red>Rebooting, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#ffffff\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=400 align=\"right\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"95%\" align=\"right\"><font color=red><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
}
}
percent=intval_cnt*100/totalWaitTime;
intval_cnt++;
if (percent >= 100) {
percent = 100;
location.href = redirectURL;
window.clearInterval(intval);
intval="";
intval_cnt=0;
return;
}
document.getElementById("progress").style.width = Math.round(percent) + "%";
document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
}
function default_reboot(lang)
{	
if ((Math.round(percent) > 70) && (Math.round(percent)%5) == 0)
rebootRedirect.location.href="http://" + currentIP +"/rebootredirect.shtml";
if (percent == 0)
{
renewClock=100 / ((totalWaitTime*1000)/renewTime);
objectDisplay("mainform", "none");
if(lang != "SA"){
document.getElementById("waitform").innerHTML = "<table bolder=\"0\" style=\"margin-top:10px;\"><tr><td colspan=\"2\"><font color=red>Rebooting, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#ffffff\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=400 align=\"left\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"95%\"><font color=red><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
}
else{
document.getElementById("waitform").innerHTML = "<table bolder=\"0\" style=\"margin-top:10px;\"><tr><td colspan=\"2\"><font color=red>Rebooting, please wait......</font></td></tr><tr><td width=\"95%\"><table align=\"left\" bgcolor=\"#ffffff\" cellpadding=\"0\" cellspacing=\"0\" bordercolor=\"#000000\" style=\"border-style: solid; border-width: 1px\"><tr><td width=400 align=\"right\"><table id=\"progress\" bgcolor=\"blue\" height=\"25\"><tr><td></td></tr></table></td></tr></table></td><td width=\"95%\" align=\"right\"><font color=red><span id=\"progressValue\">&nbsp;</span></font></td></tr></table>";
}
}
percent+=renewClock;
if (percent >= 100) {
percent = 100;
location.href = redirectURL;
}
document.getElementById("progress").style.width = Math.round(percent) + "%";
document.getElementById("progressValue").innerHTML = Math.round(percent) + "%";
if (percent != 100)
window.setTimeout("default_reboot()", renewTime);
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
else if(IE6){ return "IE6"; }  
else if(IE7){ return "IE7"; }  
else if(IE8){ return "IE8"; }  
else return "IE";
}  
if(isFF){ return "FF"; }  
if(isOpera){ return "Opera"; }  
if(isSafari){ return "Safari"; }  
if(isChrome){ return "Chrome"; }  
} //myBrowser() end
