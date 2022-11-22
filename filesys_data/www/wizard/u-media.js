/* 
* u-media.js - Common Function Definition.
*
* Copyright (c) 2008, U-Media Communications, Inc. All Rights Reserved.
*
*/
var stopToWait = false;
var http_request = false;
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
alert("The Subnet Mask is an illegal value!");
return false;
} else if (zero != 0 && one == 0) {
alert("The Subnet Mask is an illegal value!");
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
alert("The IP address and gateway are not in the same subnet mask.");
return false;
}
}
}
return true;
}
function checkSubnetMask(ip1, ip2, ip3, ip4, subnet1, subnet2, subnet3, subnet4){
var applyValue = true;
if (applyValue && !((ip1 & subnet1) > 128))
applyValue = false;
if (applyValue && subnet1 == 255)
{
if (applyValue && !(subnet2 == 0 || subnet2 == 128 || subnet2 == 192 || subnet2 == 224 || subnet2 == 240 || subnet2 == 248 || subnet2 == 252 || subnet2 == 255))
applyValue = false;
}
else if (applyValue && subnet1 != 255)
{
if (subnet2 > 0)
applyValue = false;
}
if (applyValue && subnet2 == 255)
{
if (applyValue && !(subnet3 == 0 || subnet3 == 128 || subnet3 == 192 || subnet3 == 224 || subnet3 == 240 || subnet3 == 248 || subnet3 == 252 || subnet3 == 255))
applyValue = false;
}
else if (applyValue && subnet2 != 255)
{
if (subnet3 > 0)
applyValue = false;
}
if (applyValue && subnet3 == 255)
{
if (applyValue && !(subnet4 == 0 || subnet4 == 128 || subnet4 == 192 || subnet4 == 224 || subnet4 == 240 || subnet4 == 248 || subnet4 == 252))
applyValue = false;
}
else if (applyValue && subnet3 != 255)
{
if (subnet4 > 0)
applyValue = false;
}	
if (applyValue)
return true;
else
{
alert("The Subnet Mask address is illegal.");
return false;
}
}
function maskRange(subnet, ip, gw)
{
var subCount=0, base=0;
switch (subnet*1)	
{
case 0:
return true;
break;
case 128: 	//2
subCount = 2;
base = 128;
break;
case 192: 	//4
subCount = 4;
base = 64;
break;
case 224: 	//8
subCount = 8;
base = 32;
break;
case 240: 	//16
subCount = 16;
base = 16;
break;
case 248: 	//32
subCount = 32;
base = 8;
break;
case 252: 	//64
subCount = 64;
base = 4;
break;
case 255:
if (ip == gw)
return true;
else
return false;
break;
}
for (loopCount=0; loopCount<subCount; loopCount++)
{
if (ip >= loopCount*base && gw >= loopCount*base && ip < (loopCount+1)*base && gw < (loopCount+1)*base)
{
if (ip >= loopCount*base && ip <= (loopCount+1)*base && gw >= loopCount*base && gw <= (loopCount+1)*base)
return true;
else
return false;
}
}
return false;
}
function checkGateway(ip1, ip2, ip3, ip4, subnet1, subnet2, subnet3, subnet4, gw1, gw2, gw3, gw4) {
var applyValue = true;
if (applyValue && (ip1 ^ subnet1 != subnet1 ^ gw1))
{
applyValue = false;
}
if (applyValue && !maskRange(subnet2, ip2, gw2))
{
applyValue = false;
}
if (applyValue && !maskRange(subnet3, ip3, gw3))
{
applyValue = false;
}
if (applyValue && !maskRange(subnet4, ip4, gw4))
{
applyValue = false;
}
if (applyValue)
return true;
else
{
alert("The IP address and gateway are not in the same subnet mask.");
return false;
}
}
function objectDisplay(IDName, value) {
if(document.getElementById(IDName))
document.getElementById(IDName).style.display = value;
}
function removeAllOption(selectID) {
var docTempName, loopCount;
docTempName = document.getElementById(selectID);
for (loopCount=docTempName.length; loopCount>=0; loopCount--)
docTempName.remove(loopCount);
}
function addNewOption(selectID, optionID, optionName, optionValue, optionText) {
var docTempName, newElement;
docTempName = document.getElementById(selectID);
newElement = document.createElement("option");
newElement.id = optionID;
newElement.name = optionName;
newElement.value = optionValue;
newElement.text = optionText;
try {
docTempName.add(newElement, null); //standards compliant
}
catch(ex) {
docTempName.add(newElement); //IE only
}
}
function stringToHex(tagName)
{
var resultStr="";
var docTemp;
docTemp = document.getElementById("display_"+tagName).value;
for (loopCount=0; loopCount<docTemp.length; loopCount++){
if (docTemp.substr(loopCount, 1) == '\\'){
if (docTemp.substr(loopCount+1, 1) == '"'){
resultStr = resultStr + docTemp.substr(loopCount+1, 1);
loopCount++;
}
else
resultStr = resultStr + docTemp.substr(loopCount, 1);
}
else
resultStr = resultStr + docTemp.substr(loopCount, 1);
}
document.getElementById("submit_"+tagName).value = resultStr;
}
function hexToString(string)
{
var loopCount=0;
var origSSID="";
var tempChar;
for (loopCount=0; loopCount<string.length; loopCount=loopCount+2) {
tempChar = String.fromCharCode(parseInt(string.substr(loopCount, 2), 16));
if (tempChar == '"')
origSSID = origSSID + "\"";
else
origSSID = origSSID + tempChar;
}
return origSSID;
}
function translateSubmitToHex(tagName)
{
var resultStr="";
var docTemp;
docTemp = document.getElementById("display_"+tagName).value;
for (loopCount=0; loopCount<docTemp.length; loopCount++){
if (docTemp.substr(loopCount, 1) == '\\'){
if (docTemp.substr(loopCount+1, 1) == '"'){
resultStr = resultStr + docTemp.substr(loopCount+1, 1);
loopCount++;
}
else
resultStr = resultStr + docTemp.substr(loopCount, 1);
}
else
resultStr = resultStr + docTemp.substr(loopCount, 1);
}
document.getElementById("submit_"+tagName).value = resultStr;
/*if (document.getElementById("submit_"+tagName).value.length < 1) {
alert("The SSID length can't less than 1 character!");
return false;
}*/
if ((tagName == "ESSID") && (document.getElementById("submit_"+tagName).value.length > 32)) {
alert("The SSID length can't big than 32 character!");
return false;
}
return true;
}
function transSSID(SSID)
{
var loopCount=0;
var origSSID="";
var tempChar;
for (loopCount=0; loopCount<SSID.length; loopCount=loopCount+2) {
tempChar = String.fromCharCode(parseInt(SSID.substr(loopCount, 2), 16));
if (tempChar == '"')
origSSID = origSSID + "\"";
else
origSSID = origSSID + tempChar;
}
return origSSID;
}
function getHTMLContent(IDName) {
if(window.ActiveXObject) { // IE
return document.getElementById(IDName).innerText;
} else if (window.XMLHttpRequest) { // Mozilla, Safari,...
return document.getElementById(IDName).textContent;
}
}
function checkWPAPSK(value) {
/*var pskValue;
if (value.length == 64) {
for (loopCount=0; loopCount<64; loopCount++)
{
pskValue = value.substr(loopCount, 1);
if (!(parseInt(pskValue, 16) >= 0) && !(parseInt(pskValue, 16) <= 15)) {
alert("Please input 64 Hex character of pre-shared key!");
return false;
}
}
return true;
}
else if (value.length < 8) {
alert("The passphrase key must between 8 and 63 ASCII characters!");
return false;
}*/
if (value.length < 8 || value.length > 63) {
alert("The passphrase key must between 8 and 63 ASCII characters!");
return false;
}
if (/[^\x00-\xff]/g.test(value)){   
alert("The passphrase key must between 8 and 63 ASCII characters!");
return false; 
}
if (!translateSubmitToHex("WPAPSK")){
return false;
}
return true;
}
function checkWPAPSKWithoutTranslate(value) {
/*var pskValue;
if (value.length == 64) {
for (loopCount=0; loopCount<64; loopCount++)
{
pskValue = value.substr(loopCount, 1);
if (!(parseInt(pskValue, 16) >= 0) && !(parseInt(pskValue, 16) <= 15)) {
alert("Please input 64 Hex character of pre-shared key!");
return false;
}
}
return true;
}
else if (value.length < 8) {
alert("The passphrase key must between 8 and 63 ASCII characters!");
return false;
}*/
if (value.length < 8 || value.length > 63) {
alert("The passphrase key must between 8 and 63 ASCII characters!");
return false;
}
if (/[^\x00-\xff]/g.test(value)){   
alert("The passphrase key must between 8 and 63 ASCII characters!");
return false; 
}
return true;
}
function checkWPAPSKDual(value, FB) {
/*var pskValue;
if (value.length == 64) {
for (loopCount=0; loopCount<64; loopCount++)
{
pskValue = value.substr(loopCount, 1);
if (!(parseInt(pskValue, 16) >= 0) && !(parseInt(pskValue, 16) <= 15)) {
alert("Please input 64 Hex character of pre-shared key!");
return false;
}
}
return true;
}
else if (value.length < 8) {
alert("The passphrase key must between 8 and 63 ASCII characters!");
return false;
}*/
if (value.length < 8 || value.length > 63) {
alert("The passphrase key must between 8 and 63 ASCII characters!");
return false;
}
if (/[^\x00-\xff]/g.test(value)){   
alert("The passphrase key must between 8 and 63 ASCII characters!");
return false; 
}
if(FB == "24G"){
if (!translateSubmitToHex("WPAPSK_24G")){
return false;
}
}
else if(FB == "5G"){
if (!translateSubmitToHex("WPAPSK_5G")){
return false;
}
}
return true;
}
function selectWEPKeyLength(keyLength) {
if (keyLength == 64) {
for (loopCount=0; loopCount<4; loopCount++) {
docTemp = document.getElementById("WEPKey"+loopCount);
docTemp.maxLength = 10;
docTemp = document.getElementById("WEPKey"+loopCount).value;
if (docTemp.length > 10)
document.getElementById("WEPKey"+loopCount).value = docTemp.substr(0,10);
}
}
else if (keyLength == 128) {
for (loopCount=0; loopCount<4; loopCount++) {
docTemp = document.getElementById("WEPKey"+loopCount);
docTemp.maxLength = 26;
}
}
if (document.getElementById("wepPassphrase").value != "")
Update_WEPKey(document.getElementById("wepPassphrase").value);
}
function selectWEPKeyLength_300N(keyLength) {
if (keyLength == 64) {
for (loopCount=1; loopCount<=4; loopCount++) {
docTemp = document.getElementById("wep_key_"+loopCount);
docTemp.maxLength = 10;
docTemp = document.getElementById("wep_key_"+loopCount).value;
if (docTemp.length > 10)
document.getElementById("wep_key_"+loopCount).value = docTemp.substr(0,10);
}
}
else if (keyLength == 128) {
for (loopCount=1; loopCount<=4; loopCount++) {
docTemp = document.getElementById("wep_key_"+loopCount);
docTemp.maxLength = 26;
}
}
}
function selectWEPKeyLengthO(keyLength, Freq) {
if (keyLength == 64) {
for (loopCount=0; loopCount<1; loopCount++) {
docTemp = document.getElementById("WEPKey" + loopCount + "_" + Freq);
docTemp.maxLength = 10;
docTemp = document.getElementById("WEPKey" + loopCount + "_" + Freq).value;
if (docTemp.length > 10)
document.getElementById("WEPKey" + loopCount + "_" + Freq).value = docTemp.substr(0,10);
}
}
else if (keyLength == 128) {
for (loopCount=0; loopCount<1; loopCount++) {
docTemp = document.getElementById("WEPKey" + loopCount + "_" + Freq);
docTemp.maxLength = 26;
}
}
/*if (document.getElementById(Freq + "_wepPassphrase").value != "")
Update_WEPKey(document.getElementById(Freq + "_wepPassphrase").value);*/
}
function selectWEPKeyLength_WET610N(keyLength) {
if (keyLength == 0) {
for (loopCount=0; loopCount<4; loopCount++) {
docTemp = document.getElementById("WEPKey"+loopCount);
docTemp.maxLength = 10;
docTemp = document.getElementById("WEPKey"+loopCount).value;
if (docTemp.length > 10)
document.getElementById("WEPKey"+loopCount).value = docTemp.substr(0,10);
}
}
else if (keyLength == 1) {
for (loopCount=0; loopCount<4; loopCount++) {
docTemp = document.getElementById("WEPKey"+loopCount);
docTemp.maxLength = 26;
}
}
if (document.getElementById("wepPassphrase").value != "")
Update_WEPKey(document.getElementById("wepPassphrase").value);
}
function selectWEPKeyLength_RE2000v2(keyLength , band_unit) {
if (keyLength == 0) {
for (loopCount=0; loopCount<4; loopCount++) {
docTemp = document.getElementById("WEPKey_"+ band_unit + loopCount);
docTemp.maxLength = 10;
docTemp = document.getElementById("WEPKey_"+ band_unit + loopCount).value;
if (docTemp.length > 10)
document.getElementById("WEPKey_"+ band_unit + loopCount).value = docTemp.substr(0,10);
}
}
else if (keyLength == 1) {
for (loopCount=0; loopCount<4; loopCount++) {
docTemp = document.getElementById("WEPKey_"+ band_unit + loopCount);
docTemp.maxLength = 26;
}
}
if (document.getElementById("wepPassphrase_" + band_unit).value != "")
Update_WEPKey_RE2000v2(document.getElementById("wepPassphrase_" + band_unit).value , band_unit );
}
function selectWPAMode(mode) {
if (mode*1 == 1) //WPA
{
removeAllOption("WPAPersonalEncryption");
addNewOption("WPAPersonalEncryption", "", "", "0", "TKIP");
}
else if ((mode*1 == 2) || (mode*1 == 3)) //WPA2, WPA2 Mixed
{
removeAllOption("WPAPersonalEncryption");
addNewOption("WPAPersonalEncryption", "", "", "1", "AES");
/*if (mode == 2)
docTemp = document.getElementById("WPAPersonalEncryption").options[0];
else if (mode == 3)
docTemp = document.getElementById("WPAPersonalEncryption").options[1];
docTemp.selected = true;*/
}
}
function selectWPAMode2G(mode) {
if (mode*1 == 1) //WPA
{
removeAllOption("WPAPersonalEncryption_24G");
addNewOption("WPAPersonalEncryption_24G", "", "", "0", "TKIP");
}
else if ((mode*1 == 2) || (mode*1 == 3)) //WPA2, WPA2 Mixed
{
removeAllOption("WPAPersonalEncryption_24G");
addNewOption("WPAPersonalEncryption_24G", "", "", "1", "AES");
/*if (mode == 2)
docTemp = document.getElementById("WPAPersonalEncryption").options[0];
else if (mode == 3)
docTemp = document.getElementById("WPAPersonalEncryption").options[1];
docTemp.selected = true;*/
}
}
function selectWPAMode5G(mode) {
if (mode*1 == 1) //WPA
{
removeAllOption("WPAPersonalEncryption_5G");
addNewOption("WPAPersonalEncryption_5G", "", "", "0", "TKIP");
}
else if ((mode*1 == 2) || (mode*1 == 3)) //WPA2, WPA2 Mixed
{
removeAllOption("WPAPersonalEncryption_5G");
addNewOption("WPAPersonalEncryption_5G", "", "", "1", "AES");
/*if (mode == 2)
docTemp = document.getElementById("WPAPersonalEncryption").options[0];
else if (mode == 3)
docTemp = document.getElementById("WPAPersonalEncryption").options[1];
docTemp.selected = true;*/
}
}
function Update_WEPKey(passphrase)
{
var key_len = document.getElementById("WEPKeyLength").value;
if (passphrase == "")
return;
var rand=0;
for (i=0; i< passphrase.length; i++) 
rand ^= (passphrase.charCodeAt(i)<<((i%4)*8));
for (var index = 0; index < 4; index++)
{
var result = "";
var total = (key_len == 0) ? 5 : 13;
for (var item = 0; item < total; item++) 
{
rand = rand * 0x343fd + 0x269ec3;
rand = (rand >> 16) & 32767;
result += rand.toString(16).substr(0,2);
}
document.getElementById("WEPKey" + index).value = result;
}
}
function Update_WEPKey_RE2000v2(passphrase , band_tmp)
{
var key_len = document.getElementById("WEPKeyLength_" + band_tmp).value;
if (passphrase == "")
return;
var rand=0;
for (i=0; i< passphrase.length; i++) 
rand ^= (passphrase.charCodeAt(i)<<((i%4)*8));
for (var index = 0; index < 4; index++)
{
var result = "";
var total = (key_len == 0) ? 5 : 13;
for (var item = 0; item < total; item++) 
{
rand = rand * 0x343fd + 0x269ec3;
rand = (rand >> 16) & 32767;
result += rand.toString(16).substr(0,2);
}
document.getElementById("WEPKey_" + band_tmp + index).value = result;
}
}
function updateWEPkeyByPassphrase()
{
var passphraseValue = document.getElementById("wepPassphrase").value;
if (passphraseValue == "")
{
for (var index = 0; index < 4; index++)
document.getElementById("WEPKey" + index).value = "";
return;
}
var rand=0;
for (i=0; i< passphraseValue.length; i++) 
rand ^= (passphraseValue.charCodeAt(i)<<((i%4)*8));
for (var index = 0; index < 4; index++)
{
var result = "";
var total = (document.getElementById("WEPKeyLength").value == 0) ? 5 : 13;
for (var item = 0; item < total; item++) 
{
rand = rand * 0x343fd + 0x269ec3;
rand = (rand >> 16) & 32767;
result += rand.toString(16).substr(0,2);
}
document.getElementById("WEPKey" + index).value = result;
}
}
function updateWEPkeyByPassphrase_RE2000v2(band_unit)
{
var passphraseValue = document.getElementById("wepPassphrase_"+band_unit).value;
if (passphraseValue == "")
{
for (var index = 0; index < 4; index++)
document.getElementById("WEPKey_" + band_unit + index).value = "";
return;
}
var rand=0;
for (i=0; i< passphraseValue.length; i++) 
rand ^= (passphraseValue.charCodeAt(i)<<((i%4)*8));
for (var index = 0; index < 4; index++)
{
var result = "";
var total = (document.getElementById("WEPKeyLength_"+band_unit).value == 0) ? 5 : 13;
for (var item = 0; item < total; item++) 
{
rand = rand * 0x343fd + 0x269ec3;
rand = (rand >> 16) & 32767;
result += rand.toString(16).substr(0,2);
}
document.getElementById("WEPKey_" + band_unit + index).value = result;
}
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
if (d > max || d < min)
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
function checkIpAddr(field, ismask, msg)
{
if (field.value == "") {
if(msg == "Network IP Address") {
alert("Error. Internet IP Address is empty!");
} else if(msg == "Subnet Mask") {
alert("Error. Subnet Mask is empty!");
} else if(msg == "Default Gateway") {
alert("Error. Default Gateway is empty!");
}
return false;
}
if (isAllNum(field.value) == 0) {
if(msg == "Network IP Address") {
alert("The Internet IP Address should be a [0-9] number.");
} else if(msg == "Subnet Mask") {
alert("The Subnet Mask should be a [0-9] number.");
} else if(msg == "Default Gateway") {
alert("The Default Gateway should be a [0-9] number.");
} else if(msg == "DNS 1") {
alert("The DNS 1 should be a [0-9] number.");
} else if(msg == "DNS 2") {
alert("The DNS 2(Optional) should be a [0-9] number.");
} else if(msg == "DNS 3") {
alert("The DNS 3(Optional) should be a [0-9] number.");	
}	
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
if(msg == "Network IP Address") {
alert("The Internet IP Address is an illegal value!");
} else if(msg == "Subnet Mask") {
alert("The Subnet Mask is an illegal value!");
} else if(msg == "Default Gateway") {
alert("The Default Gateway is an illegal value!");
}
return false;
}
}
else {
if(msg == "Network IP Address") {
if(!checkRange(field.value, 1, 0, 223)){
alert("The Internet IP Address is an illegal value!");
return false;
}
}
if(msg == "Default Gateway") {
if(!checkRange(field.value, 1, 0, 223)){
alert("The Default Gateway is an illegal value!");
return false;
}
}
if ((!checkRange(field.value, 1, 0, 255)) ||
(!checkRange(field.value, 2, 0, 255)) ||
(!checkRange(field.value, 3, 0, 255)) ||
(!checkRange(field.value, 4, 1, 254)) ||
field.value == "127.0.0.1")
{
if(msg == "Network IP Address") {
alert("The Internet IP Address is an illegal value!");
} else if(msg == "Subnet Mask") {
alert("The Subnet Mask is an illegal value!");
} else if(msg == "Default Gateway") {
alert("The Default Gateway is an illegal value!");
} else if(msg == "DNS 1") {
alert("Error. DNS 1 is an illegal value!");
} else if(msg == "DNS 2") {
alert("Error. DNS 2(Optional) is an illegal value!");	
} else if(msg == "DNS 3") {
alert("Error. DNS 3(Optional) is an illegal value!");	
}	
return false;
}
}
return true;
}
function makeRequest(url, content, fieldID, disableFieldID) {
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
http_request.onreadystatechange = function () {alertContents(fieldID, disableFieldID)};
http_request.open('POST', url, true);
http_request.send(content);
}
function alertContents(fieldID, disableFieldID) {
if (http_request.readyState == 4) {
if (http_request.status == 200) {
reWirteList(fieldID, disableFieldID, http_request.responseText);
} else {
}
}
}
function reWirteList(fieldID, disableFieldID, str)
{
stopToWait = true;
if (disableFieldID != "" && str != "")
objectDisplay(disableFieldID, "none")
if (fieldID != "")
document.getElementById(fieldID).innerHTML = str;
}
function fwUpgraceStatus(status, IPandMask)
{
docTemp = IPandMask;
index = docTemp.indexOf(','); //IP
currentIP = docTemp.substr(0, index);
if (status*1 == 1)
top.location.href = "http://" + currentIP + "/admin/upgrade.shtml";
}
function wpsStatus(status, mainPageName)
{
/*docTemp = IPandMask;
index = docTemp.indexOf(','); //IP
currentIP = docTemp.substr(0, index);*/
if (status*1 == 1)
{
if (mainPageName != "wps_status.shtml")
top.location.href = "/wireless/wps_status.shtml";
}
else if (mainPageName == "wps_status.shtml")
top.location.href = "/wireless/wireless_basic.shtml?wirelessConfigType=manual";
}
function style_display_on()
{
if (window.ActiveXObject) { // IE
return "block";
}
else if (window.XMLHttpRequest) { // Mozilla, Safari,...
return "table";
}
return "block";
}
function style_display_on_tr()
{
if (window.ActiveXObject) { // IE
return "block";
}
else if (window.XMLHttpRequest) { // Mozilla, Safari,...
return "table-row";
}
return "block";
}
function style_display_on_td()
{
if (window.ActiveXObject) { // IE
return "block";
}
else if (window.XMLHttpRequest) { // Mozilla, Safari,...
return "table-cell";
}
return "block";
}
function redirectTo(url)
{
top.location.href=url;
}
function is_number(value)
{
var str = value + "";
return str.match(/^-?\d*\.?\d+$/) ? true : false;
}
function is_port_valid(port)
{
return (is_number(port) && port >= 0 && port < 65536);
}
function isBlankString(StringValue)
{
return StringValue.replace(/^[\s\t]+/,"").length == 0;   
}
