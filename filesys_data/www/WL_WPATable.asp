<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Wireless Security</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="javascript">
setFormActions({
save:    true,
cancel:	 true
});
re1 = /<br>/gi;
re2 = /&nbsp;/gi
str = wlantopmenu.security.replace(re1," ");
str1 = str.replace(re2, "");
document.title = str1;
var close_session = "<% get_session_status(); %>";
var security_mode2;
var b_stopwsc = false;
function valid_range2(I,start,end,M, idx)
{
if (M=="IP")
{
if (I.value == "0")
return true;
}
return valid_range(I,start,end,M);
}
function disable_value(smode_1,smode_0){                           
var F = document.forms[0];                       
if(smode_1 == "wpa_wpa2_mixed"||smode_1 == "wpa2_personal")
{                                                          
F.wl1_radius_ipaddr.disabled = "true";            
F.wl1_radius_ipaddr_0.disabled = "true";          
F.wl1_radius_ipaddr_1.disabled = "true";          
F.wl1_radius_ipaddr_2.disabled = "true";          
F.wl1_radius_ipaddr_3.disabled = "true";          
F.wl1_radius_port.disabled = "true";               
F.wl1_radius_key.disabled = "true";                
F.wl1_wep_bit.disabled = "true";                   
F.wl1_passphrase.disabled = "true";                
F.generateButton1.disabled = "true";               
F.wl1_key1.disabled = "true";                      
F.wl1_key2.disabled = "true";
F.wl1_key3.disabled = "true";
F.wl1_key4.disabled = "true";
F.wl1_WEP_key.disabled = "true";                   
F.wl1_wep.disabled = "true";                         
F.wl1_key.disabled = "true"; 
F.wl1_wpa_psk.disabled = "";	                        
}
if(smode_1 == "wpa_wpa2_enterprise"||smode_1 == "wpa2_enterprise")
{
F.wl1_radius_ipaddr.disabled = "";            
F.wl1_radius_ipaddr_0.disabled = "";          
F.wl1_radius_ipaddr_1.disabled = "";          
F.wl1_radius_ipaddr_2.disabled = "";          
F.wl1_radius_ipaddr_3.disabled = "";          
F.wl1_radius_port.disabled = "";               
F.wl1_radius_key.disabled = "";
F.wl1_wep_bit.disabled = "true";                   
F.wl1_passphrase.disabled = "true";                
F.generateButton1.disabled = "true";               
F.wl1_key1.disabled = "true";                      
F.wl1_key2.disabled = "true";
F.wl1_key3.disabled = "true";
F.wl1_key4.disabled = "true";
F.wl1_WEP_key.disabled = "true";                   
F.wl1_wep.disabled = "true";                         
F.wl1_key.disabled = "true";
F.wl1_wpa_psk.disabled = "true";
}
if(smode_1 == "wep")
{
F.wl1_radius_ipaddr.disabled = "true";            
F.wl1_radius_ipaddr_0.disabled = "true";          
F.wl1_radius_ipaddr_1.disabled = "true";          
F.wl1_radius_ipaddr_2.disabled = "true";          
F.wl1_radius_ipaddr_3.disabled = "true";          
F.wl1_radius_port.disabled = "true";               
F.wl1_radius_key.disabled = "true";                
F.wl1_wep_bit.disabled = "";                   
F.wl1_passphrase.disabled = "";                
F.generateButton1.disabled = "";                 
F.wl1_key1.disabled = "";                        
F.wl1_WEP_key.disabled = "";                     
F.wl1_wep.disabled = "";                         
F.wl1_wpa_psk.disabled = "true";
}
if(smode_1 == "disabled")
{
F.wl1_radius_ipaddr.disabled = "true";            
F.wl1_radius_ipaddr_0.disabled = "true";          
F.wl1_radius_ipaddr_1.disabled = "true";          
F.wl1_radius_ipaddr_2.disabled = "true";          
F.wl1_radius_ipaddr_3.disabled = "true";          
F.wl1_radius_port.disabled = "true";               
F.wl1_radius_key.disabled = "true";                
F.wl1_wep_bit.disabled = "true";                   
F.wl1_passphrase.disabled = "true";                
F.generateButton1.disabled = "true";               
F.wl1_key1.disabled = "true";
F.wl1_key2.disabled = "true";
F.wl1_key3.disabled = "true";
F.wl1_key4.disabled = "true";                      
F.wl1_WEP_key.disabled = "true";                   
F.wl1_wep.disabled = "true";                         
F.wl1_key.disabled = "true"; 
F.wl1_wpa_psk.disabled = "true"; 
}
if(smode_0 == "wpa_wpa2_mixed"|| smode_0 == "wpa2_personal")       
{                                                          
F.wl0_radius_ipaddr.disabled = "true";            
F.wl0_radius_ipaddr_0.disabled = "true";          
F.wl0_radius_ipaddr_1.disabled = "true";          
F.wl0_radius_ipaddr_2.disabled = "true";          
F.wl0_radius_ipaddr_3.disabled = "true";          
F.wl0_radius_port.disabled = "true";               
F.wl0_radius_key.disabled = "true";                
F.wl0_wep_bit.disabled = "true";                   
F.wl0_passphrase.disabled = "true";                
F.generateButton0.disabled = "true";                 
F.wl0_key1.disabled = "true";
F.wl0_key2.disabled = "true";
F.wl0_key3.disabled = "true";
F.wl0_key4.disabled = "true";                        
F.wl0_WEP_key.disabled = "true";                     
F.wl0_wep.disabled = "true";                         
F.wl0_key.disabled = "true";     
F.wl0_wpa_psk.disabled = "";                   
}
if(smode_0 == "wpa_wpa2_enterprise"||smode_0 == "wpa2_enterprise")
{
F.wl0_radius_ipaddr.disabled = "";            
F.wl0_radius_ipaddr_0.disabled = "";          
F.wl0_radius_ipaddr_1.disabled = "";          
F.wl0_radius_ipaddr_2.disabled = "";          
F.wl0_radius_ipaddr_3.disabled = "";          
F.wl0_radius_port.disabled = "";               
F.wl0_radius_key.disabled = "";
F.wl0_wep_bit.disabled = "true";                   
F.wl0_passphrase.disabled = "true";                
F.generateButton0.disabled = "true";               
F.wl0_key1.disabled = "true";                      
F.wl0_key2.disabled = "true";
F.wl0_key3.disabled = "true";
F.wl0_key4.disabled = "true";
F.wl0_WEP_key.disabled = "true";                   
F.wl0_wep.disabled = "true";                         
F.wl0_key.disabled = "true";
F.wl0_wpa_psk.disabled = "true";
}
if(smode_0 == "wep")
{
F.wl0_radius_ipaddr.disabled = "true";            
F.wl0_radius_ipaddr_0.disabled = "true";          
F.wl0_radius_ipaddr_1.disabled = "true";          
F.wl0_radius_ipaddr_2.disabled = "true";          
F.wl0_radius_ipaddr_3.disabled = "true";          
F.wl0_radius_port.disabled = "true";               
F.wl0_radius_key.disabled = "true";                
F.wl0_wep_bit.disabled = "";                   
F.wl0_passphrase.disabled = "";                
F.generateButton0.disabled = "";                 
F.wl0_WEP_key.disabled = "";                     
F.wl0_wep.disabled = "";                         
F.wl0_wpa_psk.disabled = "true";
}
if(smode_0 == "disabled")
{
F.wl0_radius_ipaddr.disabled = "true";            
F.wl0_radius_ipaddr_0.disabled = "true";          
F.wl0_radius_ipaddr_1.disabled = "true";          
F.wl0_radius_ipaddr_2.disabled = "true";          
F.wl0_radius_ipaddr_3.disabled = "true";          
F.wl0_radius_port.disabled = "true";               
F.wl0_radius_key.disabled = "true";                
F.wl0_wep_bit.disabled = "true";                   
F.wl0_passphrase.disabled = "true";                
F.generateButton0.disabled = "true";                 
F.wl0_key1.disabled = "true";                        
F.wl0_key2.disabled = "true";
F.wl0_key3.disabled = "true";
F.wl0_key4.disabled = "true";
F.wl0_WEP_key.disabled = "true";                     
F.wl0_wep.disabled = "true";                         
F.wl0_key.disabled = "true";     
F.wl0_wpa_psk.disabled = "true";
}
}
function SelMode1(num,F)
{	
var net_mode = "<% nvram_get("wl1_net_mode"); %>";
var wps_mode = "<% nvram_get("wps_mode"); %>";
var wps_version2 = "<% nvram_get("wps_version2"); %>";
var net_mode_24g = "<% nvram_get("net_mode_5g"); %>";
var closed_24g = "<% nvram_get("closed_24g"); %>";
document.getElementById('Passphrase').style.display = "none";
document.getElementById('Server').style.display = "none";
document.getElementById('Port').style.display = "none";
document.getElementById('Key').style.display = "none";
document.getElementById('enc').style.display = "none";
document.getElementById('passphrase1').style.display = "none";
document.getElementById('key1').style.display = "none";	
document.getElementById('key2').style.display = "none";
document.getElementById('key3').style.display = "none";
document.getElementById('key4').style.display = "none";
document.getElementById('txkey1').style.display = "none";
if(F.wl1_security_mode.value == "wpa_wpa2_mixed"){
document.getElementById('Passphrase').style.display = "";
}
if(F.wl1_security_mode.value == "wpa2_personal"){
document.getElementById('Passphrase').style.display = "";
}
if(F.wl1_security_mode.value == "wpa_wpa2_enterprise"){	
document.getElementById('Server').style.display = "";
document.getElementById('Port').style.display = "";
document.getElementById('Key').style.display = "";
}
if(F.wl1_security_mode.value == "wpa2_enterprise"){	
document.getElementById('Server').style.display = "";
document.getElementById('Port').style.display = "";
document.getElementById('Key').style.display = "";	
}
if(F.wl1_security_mode.value == "wep"){	
document.getElementById('enc').style.display = "";
document.getElementById('passphrase1').style.display = "";
keyMode_1(document.forms[0].wl1_wep_bit.selectedIndex);
}
if(wps_version2 == "enabled" && F.wl1_security_mode.value == "wpa_wpa2_enterprise")
{
if(confirm(wlanwscpopup.disable)==false)
{
F.wl1_security_mode.value = "<% nvram_get("wl1_security_mode"); %>";
document.getElementById('Passphrase').style.display = "none";
document.getElementById('Server').style.display = "none";
document.getElementById('Port').style.display = "none";
document.getElementById('Key').style.display = "none";
document.getElementById('enc').style.display = "none";
document.getElementById('passphrase1').style.display = "none";
document.getElementById('key1').style.display = "none"; 
document.getElementById('key2').style.display = "none";
document.getElementById('key3').style.display = "none";
document.getElementById('key4').style.display = "none";
document.getElementById('txkey1').style.display = "none";
if(F.wl1_security_mode.value == "wpa_wpa2_mixed"){
document.getElementById('Passphrase').style.display = "";
}
if(F.wl1_security_mode.value == "wpa2_personal"){
document.getElementById('Passphrase').style.display = "";
}
if(F.wl1_security_mode.value == "wpa_wpa2_enterprise"){ 
document.getElementById('Server').style.display = "";
document.getElementById('Port').style.display = "";
document.getElementById('Key').style.display = "";
}
if(F.wl1_security_mode.value == "wpa2_enterprise"){     
document.getElementById('Server').style.display = "";
document.getElementById('Port').style.display = "";
document.getElementById('Key').style.display = "";      
}
if(F.wl1_security_mode.value == "wep"){ 
document.getElementById('enc').style.display = "";
document.getElementById('passphrase1').style.display = "";
keyMode_1(document.forms[0].wl1_wep_bit.selectedIndex);
}               
disable_value(F.wl1_security_mode.value,F.wl0_security_mode.value);
return;
}
}
if((wps_mode == "enabled" && F.wl1_security_mode.value == "wpa2_enterprise") && (F.wl0_security_mode.value == "wpa2_enterprise" || net_mode_24g == "disabled" || closed_24g == "1"))
{
if(confirm(wlanwscpopup.disable)==false)
{
F.wl1_security_mode.value = "<% nvram_get("wl1_security_mode"); %>";
document.getElementById('Passphrase').style.display = "none";
document.getElementById('Server').style.display = "none";
document.getElementById('Port').style.display = "none";
document.getElementById('Key').style.display = "none";
document.getElementById('enc').style.display = "none";
document.getElementById('passphrase1').style.display = "none";
document.getElementById('key1').style.display = "none"; 
document.getElementById('key2').style.display = "none";
document.getElementById('key3').style.display = "none";
document.getElementById('key4').style.display = "none";
document.getElementById('txkey1').style.display = "none";
if(F.wl1_security_mode.value == "wpa_wpa2_mixed"){
document.getElementById('Passphrase').style.display = "";
}
if(F.wl1_security_mode.value == "wpa2_personal"){
document.getElementById('Passphrase').style.display = "";
}
if(F.wl1_security_mode.value == "wpa_wpa2_enterprise"){ 
document.getElementById('Server').style.display = "";
document.getElementById('Port').style.display = "";
document.getElementById('Key').style.display = "";
}
if(F.wl1_security_mode.value == "wpa2_enterprise"){     
document.getElementById('Server').style.display = "";
document.getElementById('Port').style.display = "";
document.getElementById('Key').style.display = "";      
}
if(F.wl1_security_mode.value == "wep"){ 
document.getElementById('enc').style.display = "";
document.getElementById('passphrase1').style.display = "";
keyMode_1(document.forms[0].wl1_wep_bit.selectedIndex);
}               
disable_value(F.wl1_security_mode.value,F.wl0_security_mode.value);
return;
}
}
if(wps_version2 == "enabled" && F.wl1_security_mode.value == "wep")
{
if(confirm(wlanwscpopup.disable)==false)
{
F.wl1_security_mode.value = "<% nvram_get("wl1_security_mode"); %>";
document.getElementById('Passphrase').style.display = "none";
document.getElementById('Server').style.display = "none";
document.getElementById('Port').style.display = "none";
document.getElementById('Key').style.display = "none";
document.getElementById('enc').style.display = "none";
document.getElementById('passphrase1').style.display = "none";
document.getElementById('key1').style.display = "none"; 
document.getElementById('key2').style.display = "none";
document.getElementById('key3').style.display = "none";
document.getElementById('key4').style.display = "none";
document.getElementById('txkey1').style.display = "none";
if(F.wl1_security_mode.value == "wpa_wpa2_mixed"){
document.getElementById('Passphrase').style.display = "";
}
if(F.wl1_security_mode.value == "wpa2_personal"){
document.getElementById('Passphrase').style.display = "";
}
if(F.wl1_security_mode.value == "wpa_wpa2_enterprise"){ 
document.getElementById('Server').style.display = "";
document.getElementById('Port').style.display = "";
document.getElementById('Key').style.display = "";
}
if(F.wl1_security_mode.value == "wpa2_enterprise"){     
document.getElementById('Server').style.display = "";
document.getElementById('Port').style.display = "";
document.getElementById('Key').style.display = "";      
}
if(F.wl1_security_mode.value == "wep"){ 
document.getElementById('enc').style.display = "";
document.getElementById('passphrase1').style.display = "";
keyMode_1(document.forms[0].wl1_wep_bit.selectedIndex);
}		
disable_value(F.wl1_security_mode.value,F.wl0_security_mode.value);
return;
}
}
if (net_mode == "mixed")
{
if(F.wl1_security_mode.value == "wep")
{
if (confirm(errmsg.mixedmodesecurity) == false)
{
F.wl1_security_mode.value = "<% nvram_get("wl1_security_mode"); %>";
document.getElementById('Passphrase').style.display = "none";
document.getElementById('Server').style.display = "none";
document.getElementById('Port').style.display = "none";
document.getElementById('Key').style.display = "none";
document.getElementById('enc').style.display = "none";
document.getElementById('passphrase1').style.display = "none";
document.getElementById('key1').style.display = "none"; 
document.getElementById('key2').style.display = "none";
document.getElementById('key3').style.display = "none";
document.getElementById('key4').style.display = "none";
document.getElementById('txkey1').style.display = "none";
if(F.wl1_security_mode.value == "wpa_wpa2_mixed"){
document.getElementById('Passphrase').style.display = "";
}
if(F.wl1_security_mode.value == "wpa2_personal"){
document.getElementById('Passphrase').style.display = "";
}
if(F.wl1_security_mode.value == "wpa_wpa2_enterprise"){ 
document.getElementById('Server').style.display = "";
document.getElementById('Port').style.display = "";
document.getElementById('Key').style.display = "";
}
if(F.wl1_security_mode.value == "wpa2_enterprise"){     
document.getElementById('Server').style.display = "";
document.getElementById('Port').style.display = "";
document.getElementById('Key').style.display = "";      
}
if(F.wl1_security_mode.value == "wep"){ 
document.getElementById('enc').style.display = "";
document.getElementById('passphrase1').style.display = "";
keyMode_1(document.forms[0].wl1_wep_bit.selectedIndex);
} 
disable_value(F.wl1_security_mode.value,F.wl0_security_mode.value);     
return;
}
}
}	
F.wl1_crypto.value = "aes"
disable_value(F.wl1_security_mode.value,F.wl0_security_mode.value);	
}			
function SelMode(num,F){
document.getElementById('trPassphrase').style.display = "none";
document.getElementById('trServer').style.display = "none";
document.getElementById('trPort').style.display = "none";
document.getElementById('trKey').style.display = "none";
document.getElementById('trenc').style.display = "none";
document.getElementById('trpassphrase0').style.display = "none";
document.getElementById('trkey0').style.display = "none"; 
document.getElementById('trkey1').style.display = "none";
document.getElementById('trkey2').style.display = "none";
document.getElementById('trkey3').style.display = "none";
document.getElementById('txkey0').style.display = "none";
if(F.wl0_security_mode.value == "wpa_wpa2_mixed")
document.getElementById('trPassphrase').style.display = "";
if(F.wl0_security_mode.value == "wpa2_personal")       
document.getElementById('trPassphrase').style.display = "";
if(F.wl0_security_mode.value == "wpa_wpa2_enterprise"){
document.getElementById('trServer').style.display = "";
document.getElementById('trPort').style.display = "";
document.getElementById('trKey').style.display = "";
}
if(F.wl0_security_mode.value == "wpa2_enterprise"){       
document.getElementById('trServer').style.display = "";
document.getElementById('trPort').style.display = "";
document.getElementById('trKey').style.display = "";      
}
if(F.wl0_security_mode.value == "wep"){       
document.getElementById('trenc').style.display = "";
document.getElementById('trpassphrase0').style.display = "";
keyMode_0(document.forms[0].wl0_wep_bit.selectedIndex);
}
var net_mode = "<% nvram_get("wl0_net_mode"); %>";
var wps_version2 = "<% nvram_get("wps_version2"); %>";
var wps_mode = "<% nvram_get("wps_mode"); %>";
var net_mode_5g = "<% nvram_get("net_mode_5g"); %>";
var closed_5g = "<% nvram_get("closed_5g"); %>";
if(wps_version2 == "enabled" && F.wl0_security_mode.value == "wpa_wpa2_enterprise")
{
if(confirm(wlanwscpopup.disable)==false){
F.wl0_security_mode.value = "<% nvram_get("wl0_security_mode"); %>";
document.getElementById('trPassphrase').style.display = "none";
document.getElementById('trServer').style.display = "none";     
document.getElementById('trPort').style.display = "none";
document.getElementById('trKey').style.display = "none";
document.getElementById('trenc').style.display = "none";
document.getElementById('trpassphrase0').style.display = "none";
document.getElementById('trkey0').style.display = "none";
document.getElementById('trkey1').style.display = "none";
document.getElementById('trkey2').style.display = "none";
document.getElementById('trkey3').style.display = "none";
document.getElementById('txkey0').style.display = "none";
if(F.wl0_security_mode.value == "wpa_wpa2_mixed")
document.getElementById('trPassphrase').style.display = "";
if(F.wl0_security_mode.value == "wpa2_personal")       
document.getElementById('trPassphrase').style.display = "";
if(F.wl0_security_mode.value == "wpa_wpa2_enterprise"){
document.getElementById('trServer').style.display = "";
document.getElementById('trPort').style.display = "";
document.getElementById('trKey').style.display = "";
}
if(F.wl0_security_mode.value == "wpa2_enterprise"){       
document.getElementById('trServer').style.display = "";
document.getElementById('trPort').style.display = "";
document.getElementById('trKey').style.display = "";      
}
if(F.wl0_security_mode.value == "wep"){       
document.getElementById('trenc').style.display = "";
document.getElementById('trpassphrase0').style.display = "";
keyMode_0(document.forms[0].wl0_wep_bit.selectedIndex);
}
disable_value(F.wl1_security_mode.value,F.wl0_security_mode.value);
return;
}
}
if(wps_mode == "enabled" && F.wl0_security_mode.value == "wpa2_enterprise")
{ 
if(F.wl1_security_mode.value == "wpa2_enterprise" || net_mode_5g == "disabled" || closed_5g == "1")
{
if(confirm(wlanwscpopup.disable)==false) {
F.wl0_security_mode.value = "<% nvram_get("wl0_security_mode"); %>";
document.getElementById('trPassphrase').style.display = "none";
document.getElementById('trServer').style.display = "none";     
document.getElementById('trPort').style.display = "none";
document.getElementById('trKey').style.display = "none";
document.getElementById('trenc').style.display = "none";
document.getElementById('trpassphrase0').style.display = "none";
document.getElementById('trkey0').style.display = "none";
document.getElementById('trkey1').style.display = "none";
document.getElementById('trkey2').style.display = "none";
document.getElementById('trkey3').style.display = "none";
document.getElementById('txkey0').style.display = "none";
if(F.wl0_security_mode.value == "wpa_wpa2_mixed")
document.getElementById('trPassphrase').style.display = "";
if(F.wl0_security_mode.value == "wpa2_personal")       
document.getElementById('trPassphrase').style.display = "";
if(F.wl0_security_mode.value == "wpa_wpa2_enterprise"){
document.getElementById('trServer').style.display = "";
document.getElementById('trPort').style.display = "";
document.getElementById('trKey').style.display = "";
}
if(F.wl0_security_mode.value == "wpa2_enterprise"){       
document.getElementById('trServer').style.display = "";
document.getElementById('trPort').style.display = "";
document.getElementById('trKey').style.display = "";      
}
if(F.wl0_security_mode.value == "wep"){       
document.getElementById('trenc').style.display = "";
document.getElementById('trpassphrase0').style.display = "";
keyMode_0(document.forms[0].wl0_wep_bit.selectedIndex);
}
disable_value(F.wl1_security_mode.value,F.wl0_security_mode.value);
return;
}
}
}
if(wps_version2 == "enabled" && F.wl0_security_mode.value == "wep")
{
if(confirm(wlanwscpopup.disable)==false){
F.wl0_security_mode.value = "<% nvram_get("wl0_security_mode"); %>";
document.getElementById('trPassphrase').style.display = "none";
document.getElementById('trServer').style.display = "none";	
document.getElementById('trPort').style.display = "none";
document.getElementById('trKey').style.display = "none";
document.getElementById('trenc').style.display = "none";
document.getElementById('trpassphrase0').style.display = "none";
document.getElementById('trkey0').style.display = "none";
document.getElementById('trkey1').style.display = "none";
document.getElementById('trkey2').style.display = "none";
document.getElementById('trkey3').style.display = "none";
document.getElementById('txkey0').style.display = "none";
if(F.wl0_security_mode.value == "wpa_wpa2_mixed")
document.getElementById('trPassphrase').style.display = "";
if(F.wl0_security_mode.value == "wpa2_personal")       
document.getElementById('trPassphrase').style.display = "";
if(F.wl0_security_mode.value == "wpa_wpa2_enterprise"){
document.getElementById('trServer').style.display = "";
document.getElementById('trPort').style.display = "";
document.getElementById('trKey').style.display = "";
}
if(F.wl0_security_mode.value == "wpa2_enterprise"){       
document.getElementById('trServer').style.display = "";
document.getElementById('trPort').style.display = "";
document.getElementById('trKey').style.display = "";      
}
if(F.wl0_security_mode.value == "wep"){       
document.getElementById('trenc').style.display = "";
document.getElementById('trpassphrase0').style.display = "";
keyMode_0(document.forms[0].wl0_wep_bit.selectedIndex);
}
disable_value(F.wl1_security_mode.value,F.wl0_security_mode.value);
return;
}
}
if (net_mode == "mixed")
{
if (F.wl0_security_mode.value == "wep")
{
if (confirm(errmsg.mixedmodesecurity) == false)
{
F.wl0_security_mode.value = "<% nvram_get("wl0_security_mode"); %>";
document.getElementById('trPassphrase').style.display = "none";
document.getElementById('trServer').style.display = "none";     
document.getElementById('trPort').style.display = "none";
document.getElementById('trKey').style.display = "none";
document.getElementById('trenc').style.display = "none";
document.getElementById('trpassphrase0').style.display = "none";
document.getElementById('trkey0').style.display = "none";
document.getElementById('trkey1').style.display = "none";
document.getElementById('trkey2').style.display = "none";
document.getElementById('trkey3').style.display = "none";
document.getElementById('txkey0').style.display = "none";
if(F.wl0_security_mode.value == "wpa_wpa2_mixed")
document.getElementById('trPassphrase').style.display = "";
if(F.wl0_security_mode.value == "wpa2_personal")       
document.getElementById('trPassphrase').style.display = "";
if(F.wl0_security_mode.value == "wpa_wpa2_enterprise"){
document.getElementById('trServer').style.display = "";
document.getElementById('trPort').style.display = "";
document.getElementById('trKey').style.display = "";
}
if(F.wl0_security_mode.value == "wpa2_enterprise"){       
document.getElementById('trServer').style.display = "";
document.getElementById('trPort').style.display = "";
document.getElementById('trKey').style.display = "";      
}
if(F.wl0_security_mode.value == "wep"){       
document.getElementById('trenc').style.display = "";
document.getElementById('trpassphrase0').style.display = "";
keyMode_0(document.forms[0].wl0_wep_bit.selectedIndex);
}
disable_value(F.wl1_security_mode.value,F.wl0_security_mode.value);	
return;
}
}
}       
F.wl0_crypto.value = "aes";
disable_value(F.wl1_security_mode.value,F.wl0_security_mode.value);
}
function SelMode1_init(num,F)
{       
var net_mode = "<% nvram_get("wl1_net_mode"); %>";
var wps_version2 = "<% nvram_get("wps_version2"); %>";
if(F.wl1_security_mode.value == "wpa_wpa2_mixed"){
document.getElementById('Passphrase').style.display = "";
}
if(F.wl1_security_mode.value == "wpa2_personal"){
document.getElementById('Passphrase').style.display = "";
}
if(F.wl1_security_mode.value == "wpa_wpa2_enterprise"){ 
document.getElementById('Server').style.display = "";
document.getElementById('Port').style.display = "";
document.getElementById('Key').style.display = "";
}
if(F.wl1_security_mode.value == "wpa2_enterprise"){     
document.getElementById('Server').style.display = "";
document.getElementById('Port').style.display = "";
document.getElementById('Key').style.display = "";      
}
if(F.wl1_security_mode.value == "wep"){ 
document.getElementById('enc').style.display = "";
document.getElementById('passphrase1').style.display = "";
}
disable_value(F.wl1_security_mode.value,F.wl0_security_mode.value);
}
function SelMode_init(num,F){
if(F.wl0_security_mode.value == "wpa_wpa2_mixed")
document.getElementById('trPassphrase').style.display = "";
if(F.wl0_security_mode.value == "wpa2_personal")       
document.getElementById('trPassphrase').style.display = "";
if(F.wl0_security_mode.value == "wpa_wpa2_enterprise"){
document.getElementById('trServer').style.display = "";
document.getElementById('trPort').style.display = "";
document.getElementById('trKey').style.display = "";
}
if(F.wl0_security_mode.value == "wpa2_enterprise"){       
document.getElementById('trServer').style.display = "";
document.getElementById('trPort').style.display = "";
document.getElementById('trKey').style.display = "";      
}
if(F.wl0_security_mode.value == "wep"){       
document.getElementById('trenc').style.display = "";
document.getElementById('trpassphrase0').style.display = "";
}
disable_value(F.wl1_security_mode.value,F.wl0_security_mode.value);	
}
function to_submit(F)
{
/*Jemmy modify issue: not check 5G settings 2008.5.20 */
if(F.wl1_security_mode.value == 'wpa2_enterprise')
{
if(F.wl1_radius_ipaddr_0.value == "0")
{
alert(errmsg.err14 + '['+ 1 + ' - ' + 223 +'].');
F.wl1_radius_ipaddr_0.value = F.wl1_radius_ipaddr_0.defaultValue;
F.wl1_radius_ipaddr_0.focus();
return;
}
if(F.wl1_radius_ipaddr_3.value == "0")
{
alert(errmsg.err14 + '['+ 1 + ' - ' + 254 +'].');
F.wl1_radius_ipaddr_3.value = F.wl1_radius_ipaddr_3.defaultValue;
F.wl1_radius_ipaddr_3.focus();
return;
}
}
if(F.wl0_security_mode.value == 'wpa2_enterprise')
{
if(F.wl0_radius_ipaddr_0.value == "0")
{
alert(errmsg.err14 + '['+ 1 + ' - ' + 223 +'].');
F.wl0_radius_ipaddr_0.value = F.wl0_radius_ipaddr_0.defaultValue;
F.wl0_radius_ipaddr_0.focus();
return;
}
if(F.wl0_radius_ipaddr_3.value == "0")
{
alert(errmsg.err14 + '['+ 1 + ' - ' + 254 +'].');
F.wl0_radius_ipaddr_3.value = F.wl0_radius_ipaddr_3.defaultValue;
F.wl0_radius_ipaddr_3.focus();
return;
}
}
/*Wenxuan add edge need*/
var userAgent = navigator.userAgent;
var isEdge = userAgent.indexOf("Edge") > -1;
if(isEdge)
{
if(F.wl1_security_mode.value == "wpa2_enterprise"){
if(!valid_range(F.wl1_radius_ipaddr_0,1,254,'IP') || !valid_range(F.wl1_radius_ipaddr_1,0,255,'IP') || !valid_range(F.wl1_radius_ipaddr_2,0,255,'IP') || !valid_range(F.wl1_radius_ipaddr_3,1,254,'IP') || !valid_range(F.wl1_radius_port,1,65535,'Port'))
return;
}
if(F.wl0_security_mode.value == "wpa2_enterprise"){
if(!valid_range(F.wl0_radius_ipaddr_0,1,223,'IP') || !valid_range(F.wl0_radius_ipaddr_1,0,255,'IP') || !valid_range(F.wl0_radius_ipaddr_2,0,255,'IP') || !valid_range(F.wl0_radius_ipaddr_3,1,254,'IP') || !valid_range(F.wl0_radius_port,1,65535,'Port'))
return;
}
}
/*Wenxuan add edge need*/	
if(valid_value(F) && valid_value_1(F))
{
/*Jemmy fix alerting two same warn message when page switch ftom Manual to WSC 2010.6.21*/
var smode = "<% nvram_get("wl0_security_mode"); %>", smode1 = "<% nvram_get("wl1_security_mode"); %>";
var security_mode = "<% nvram_get("wsc_security_auto"); %>";
/*		if ( (security_mode == "1") && 
(smode1 == "wpa2_enterprise" || smode1 == "wpa_wpa2_enterprise") && 
(smode == "wpa2_enterprise" || smode == "wpa_wpa2_enterprise"))
{
alert(errmsg.err70);
F.wsc_security_auto.value = "0";
}
*/
/*
if(b_stopwsc)
{
F.wl_wsc_mode.value = "disabled";
F.wsc_security_auto.value = "0";
}
else
{
F.wl_wsc_mode.value = "<% nvram_get("wl_wsc_mode"); %>";
F.wsc_security_auto.value = "<% nvram_get("wsc_security_auto"); %>";
}
*/
F.wl1_wpa_psk.defaultValue = F.wl1_wpa_psk.value;
F.wl0_wpa_psk.defaultValue = F.wl0_wpa_psk.value;
F.submit_button.value = "WL_WPATable";
F.gui_action.value = "Apply";
ajaxSubmit(12,"false");
}
}
function valid_value(F)
{
if(F.wl0_security_mode.value == "disabled")	return true;
if(!valid_wpa_psk_0(F) || !valid_wep_0(F) || !valid_radius_0(F))	return false;
else	return true;
}
function valid_value_1(F)
{
if(F.wl1_security_mode.value == "disabled")	return true;
if(!valid_wpa_psk_1(F) || !valid_wep_1(F) || !valid_radius_1(F))	return false;
else	return true;
}
function valid_radius_0(F)
{
if(F.wl0_security_mode.value == "wpa2_enterprise" || F.wl0_security_mode.value == "wpa_wpa2_enterprise"){
if(F.wl0_radius_key.value == ""){
alert(errmsg2.err3);
F.wl0_radius_key.focus();
return false;
}
if(!valid_ip(F,"F.wl0_radius_ipaddr","Radius%20Server%20Address",ZERO_NO|MASK_NO))
return false;
F.wsc_nwkey0.value = F.wl0_radius_key.value;
}
return true;
}
function valid_radius_1(F)
{
if(F.wl1_security_mode.value == "wpa2_enterprise" || F.wl1_security_mode.value == "wpa_wpa2_enterprise"){
if(F.wl1_radius_key.value == ""){
alert(errmsg2.err3);
F.wl1_radius_key.focus();
return false;
}
if(!valid_ip(F,"F.wl1_radius_ipaddr","Radius%20Server%20Address",ZERO_NO|MASK_NO))
return false;
F.wsc_nwkey1.value = F.wl1_radius_key.value;
}
return true;
}
function isxdigit1(I,M)
{
for(i=0 ; i<I.value.length; i++){
ch = I.value.charAt(i).toLowerCase();
if(ch >= '0' && ch <= '9' || ch >= 'a' && ch <= 'f'){}
else{
alert(M + errmsg2.err4);
I.value = I.defaultValue;	
return false;
}
}
return true;
}
function valid_wpa_psk_0(F)
{
if(F.wl0_security_mode.value == "wpa2_personal" || F.wl0_security_mode.value == "wpa_wpa2_mixed"){
if(F.wl0_wpa_psk.value == "")
{
alert(wiz.wirelessPasswd24)
return false;
}
if(F.wl0_wpa_psk.value.length == 64){
if(!isxdigit1(F.wl0_wpa_psk, F.wl0_wpa_psk.value)) return false;
}	
else if(F.wl0_wpa_psk.value.length >=8 && F.wl0_wpa_psk.value.length <= 63 ){
if(!isascii(F.wl0_wpa_psk,F.wl0_wpa_psk.value)) return false;
}
else{
alert(errmsg2.err5);
return false;
}
F.wsc_nwkey0.value = F.wl0_wpa_psk.value;
}
/*
if(F.wl0_security_mode.value == "wpa_enterprise" || F.wl0_security_mode.value == "wpa2_enterprise")
{
F.wl0_crypto.value = F.wl_crypto_0.value;
}
*/
return true;	
}
function valid_wpa_psk_1(F)
{
if(F.wl1_security_mode.value == "wpa2_personal" || F.wl1_security_mode.value == "wpa_wpa2_mixed"){
if(F.wl1_wpa_psk.value == "")
{
alert(wiz.wirelessPasswd5)
return false;
}
if(F.wl1_wpa_psk.value.length == 64){
if(!isxdigit1(F.wl1_wpa_psk, F.wl1_wpa_psk.value)) return false;
}	
else if(F.wl1_wpa_psk.value.length >=8 && F.wl1_wpa_psk.value.length <= 63 ){
if(!isascii(F.wl1_wpa_psk,F.wl1_wpa_psk.value)) return false;
}
else{
alert(errmsg2.err5);
return false;
}
F.wsc_nwkey1.value = F.wl1_wpa_psk.value;
}
/*	
if(F.wl1_security_mode.value == "wpa_enterprise" || F.wl1_security_mode.value == "wpa2_enterprise")
{
F.wl1_crypto.value = F.wl_crypto_1.value;
}
*/
return true;	
}
function valid_wep_0(F)
{
if(document.forms[0].wl0_security_mode.value == "wpa2_personal" || document.forms[0].wl0_security_mode.value == "wpa2_enterprise" || document.forms[0].wl0_security_mode.value == "wpa_wpa2_enterprise" || document.forms[0].wl0_security_mode.value == "wpa_wpa2_mixed")	return true;
if(document.forms[0].wl0_security_mode.value == "wep")
{
if (ValidateKey(F.wl0_key1, F.wl0_wep_bit.options[F.wl0_wep_bit.selectedIndex].value,1) == false || ValidateKey(F.wl0_key2, F.wl0_wep_bit.options[F.wl0_wep_bit.selectedIndex].value,2) == false || ValidateKey(F.wl0_key3, F.wl0_wep_bit.options[F.wl0_wep_bit.selectedIndex].value,3) == false || ValidateKey(F.wl0_key4, F.wl0_wep_bit.options[F.wl0_wep_bit.selectedIndex].value,4) == false)
return false;  
}
/*
if (ValidateKey(F.wl0_key3, F.wl0_wep_bit.options[F.wl0_wep_bit.selectedIndex].value,3) == false)
return false;
if (ValidateKey(F.wl0_key4, F.wl0_wep_bit.options[F.wl0_wep_bit.selectedIndex].value,4) == false)
return false;
*/
var val = F.wl0_key.value;
aaa = eval("F.wl0_key"+val).value;
if(aaa == ""){
alert(errmsg2.err6);
return false;
}
F.wsc_nwkey0.value = aaa;
return true;
}
function valid_wep_1(F)
{
if(document.forms[0].wl1_security_mode.value == "wpa2_personal" || document.forms[0].wl1_security_mode.value == "wpa2_enterprise" || document.forms[0].wl1_security_mode.value == "wpa_wpa2_enterprise" || document.forms[0].wl1_security_mode.value == "wpa_wpa2_mixed")	return true;
if(document.forms[0].wl1_security_mode.value == "wep")
{
if (ValidateKey(F.wl1_key1, F.wl1_wep_bit.options[F.wl1_wep_bit.selectedIndex].value,1) == false || ValidateKey(F.wl1_key2, F.wl1_wep_bit.options[F.wl1_wep_bit.selectedIndex].value,2) == false || ValidateKey(F.wl1_key3, F.wl1_wep_bit.options[F.wl1_wep_bit.selectedIndex].value,3) == false || ValidateKey(F.wl1_key4, F.wl1_wep_bit.options[F.wl1_wep_bit.selectedIndex].value,4) == false)
return false; 
}
/*
if (ValidateKey(F.wl1_key3, F.wl1_wep_bit.options[F.wl1_wep_bit.selectedIndex].value,3) == false)
return false;
if (ValidateKey(F.wl1_key4, F.wl1_wep_bit.options[F.wl1_wep_bit.selectedIndex].value,4) == false)
return false;
*/
var val = F.wl1_key.value;
aaa = eval("F.wl1_key"+val).value;
if(aaa == ""){
alert(errmsg2.err6);
return false;
}
F.wsc_nwkey1.value = aaa;
return true;
}
function ValidateKey(key, bit, index)
{
if(bit == 64){
switch(key.value.length){
case 0: break;
case 10: if(!isxdigit(key,key.value)) return false; break;
default: alert(errmsg2.err7); return false;
}
}
else{
switch(key.value.length){
case 0: break;
case 26: if(!isxdigit(key,key.value)) return false; break;
default: alert(errmsg2.err7); return false;
}
}
return true;
}
function keyMode_0(num)
{
var keylength;
var key1='';
var key2='';
var key3='';
var key4='';
var F = document.forms[0];
document.getElementById('trkey0').style.display = "none";
document.getElementById('trkey1').style.display = "none";
document.getElementById('trkey2').style.display = "none";
document.getElementById('trkey3').style.display = "none";
document.getElementById('txkey0').style.display = "none";
if(num == 0 || num == 64){
keylength = 40 /4;
document.getElementById('trkey0').style.display = "";
document.getElementById('trkey1').style.display = "";
document.getElementById('trkey2').style.display = "";
document.getElementById('trkey3').style.display = "";
document.getElementById('txkey0').style.display = "";
F.wl0_key.disabled = "";
F.wl0_key1.disabled = "";
F.wl0_key2.disabled = "";
F.wl0_key3.disabled = "";
F.wl0_key4.disabled = "";
}
else{
keylength = 104 /4;
document.getElementById('trkey0').style.display = "";
F.wl0_key1.disabled = "";
F.wl0_key.disabled = "";
F.wl0_key2.disabled = "true";
F.wl0_key3.disabled = "true";
F.wl0_key4.disabled = "true";
}
if(document.forms[0].wl0_security_mode.value == "wep")
{
document.forms[0].wl0_key1.maxLength = keylength;
document.forms[0].wl0_key2.maxLength = keylength;
document.forms[0].wl0_key3.maxLength = keylength;
document.forms[0].wl0_key4.maxLength = keylength;
}
/*document.forms[0].wl0_key3.maxLength = keylength;
document.forms[0].wl0_key4.maxLength = keylength;*/
for (var i=0; i<keylength; i++)
{
if(document.forms[0].wl0_security_mode.value == "wep")
key1 +=  document.forms[0].wl0_key1.value.charAt(i);
else
key2 +=  document.forms[0].wl0_key2.value.charAt(i);
/*key3 +=  document.forms[0].wl0_key3.value.charAt(i);
key4 +=  document.forms[0].wl0_key4.value.charAt(i);*/
}
if(document.forms[0].wl0_security_mode.value == "wep")
document.forms[0].wl0_key1.value = key1;
else
document.forms[0].wl0_key2.value = key2;
/*document.forms[0].wl0_key3.value = key3;
document.forms[0].wl0_key4.value = key4;*/
}
function keyMode_1(num)
{
var F = document.forms[0];
var keylength;
var key1='';
var key2='';
var key3='';
var key4='';
document.getElementById('key1').style.display = "none";
document.getElementById('key2').style.display = "none";
document.getElementById('key3').style.display = "none";
document.getElementById('key4').style.display = "none";
document.getElementById('txkey1').style.display = "none";
if(num == 0 || num == 64){
keylength = 40 /4;
document.getElementById('key1').style.display = "";
document.getElementById('key2').style.display = "";
document.getElementById('key3').style.display = "";
document.getElementById('key4').style.display = "";
document.getElementById('txkey1').style.display = "";
F.wl1_key.disabled = "";
F.wl1_key1.disabled = "";
F.wl1_key2.disabled = "";
F.wl1_key3.disabled = "";
F.wl1_key4.disabled = "";
}
else{
keylength = 104 /4;
document.getElementById('key1').style.display = "";
F.wl1_key.disabled = "";
F.wl1_key1.disabled = "";
F.wl1_key2.disabled = "true";
F.wl1_key3.disabled = "true";
F.wl1_key4.disabled = "true";
}
if(document.forms[0].wl1_security_mode.value == "wep")
{
document.forms[0].wl1_key1.maxLength = keylength;
document.forms[0].wl1_key2.maxLength = keylength;
document.forms[0].wl1_key3.maxLength = keylength;
document.forms[0].wl1_key4.maxLength = keylength;
}
/*document.forms[0].wl1_key3.maxLength = keylength;
document.forms[0].wl1_key4.maxLength = keylength;*/
for (var i=0; i<keylength; i++)
{
if(document.forms[0].wl1_security_mode.value == "wep")
key1 +=  document.forms[0].wl1_key1.value.charAt(i);
else
key2 +=  document.forms[0].wl1_key2.value.charAt(i);
/*key3 +=  document.forms[0].wl1_key3.value.charAt(i);
key4 +=  document.forms[0].wl1_key4.value.charAt(i);*/
}
if(document.forms[0].wl1_security_mode.value == "wep")
document.forms[0].wl1_key1.value = key1;
else
document.forms[0].wl1_key2.value = key2;
/*document.forms[0].wl1_key3.value = key3;
document.forms[0].wl1_key4.value = key4;*/
}
function generateKey0(F)
{		
if (F.wl0_passphrase.value == "")
{
alert(errmsg2.err8);
F.wl0_passphrase.focus();
return false;
}
F.submit_button.value = "WL_WPATable";
F.change_action.value = "gozila_cgi";
if(F.wl0_wep_bit.value == 64)
F.submit_type.value = "key_64_0";
else
F.submit_type.value = "key_128_0";
F.submit();
}
function generateKey1(F)
{		
if (F.wl1_passphrase.value == "")
{
alert(errmsg2.err8);
F.wl1_passphrase.focus();
return false;
}
F.submit_button.value = "WL_WPATable";
F.change_action.value = "gozila_cgi";
if(F.wl1_wep_bit.value == 64)
F.submit_type.value = "key_64_1";
else
F.submit_type.value = "key_128_1";
F.submit();
}
function init(){
/*
var security_mode = "<% nvram_selget("wl0_security_mode"); %>";
var wsc_mode = "<% nvram_get("wsc_security_auto"); %>";
if ( (wsc_mode == "1") && ( security_mode == "wpa_enterprise" || security_mode == "wpa2_enterprise"))
{
b_stopwsc = true;
if(!confirm(errmsg.err71))
{
var F = document.forms[0];
F.submit_button.value = "WL_WPATable";
F.change_action.value = "gozila_cgi";
F.security_mode2.value= "<% nvram_get("security_mode2"); %>";
F.submit();
}
}
*/
var wl1_security_mode = "<% nvram_selget("wl1_security_mode"); %>";
var wl0_security_mode = "<% nvram_selget("wl0_security_mode"); %>";
SelMode1_init(document.wpa.wl1_security_mode.selectedIndex,document.wpa);	
SelMode_init(document.wpa.wl0_security_mode.selectedIndex,document.wpa)	
if(document.forms[0].wl0_security_mode.value == "wep")
keyMode_0(document.wpa.wl0_wep_bit.value);
if(document.forms[0].wl1_security_mode.value == "wep")
keyMode_1(document.wpa.wl1_wep_bit.value);
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
var wl0_security_mode_nvram = "<% nvram_get("wl0_security_mode"); %>";
var wl1_security_mode_nvram = "<% nvram_get("wl1_security_mode"); %>";
if(wl0_security_mode_nvram == wl0_security_mode && wl1_security_mode_nvram == wl1_security_mode)
{
setInitFormData(function(){
to_submit(document.forms[0])
});
}
}
</SCRIPT>
</HEAD>
<BODY onload="init()">
<FORM name="wpa" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="security_mode_last" />
<input type="hidden" name="wl_wep_last" />
<input type="hidden" name="wait_time" value="3" />
<input type="hidden" name="wsc_nwkey0" />
<input type="hidden" name="wsc_nwkey1" />
<input type="hidden" name="wl0_crypto" value="<% nvram_gozila_get("wl0_crypto"); %>" />
<input type="hidden" name="wl1_crypto" value="<% nvram_gozila_get("wl1_crypto"); %>" />
<input type="hidden" name="wsc_security_auto" value="<% nvram_get("wsc_security_auto"); %>" />
<!--
<input type="hidden" name="wl_wsc_mode">
<input type="hidden" name="wsc_security_auto" >
-->
<% web_include_file("Top.asp"); %>
<script>draw_table(MAINFUN2,wlansec.hgmenu);</script>
<table class="table table-info">
<tbody>
<% nvram_invmatch("wl1_net_mode", "n-only", "<!--"); %>
<tr>
<td><script>Capture(wlansec.secmode)</script></td>
<td>
<script>
(function(){
var str = [hwlsec2.wpa2personal, hwlsec2.wpa2enterprise, share.disabled],
val = ['wpa2_personal', 'wpa2_enterprise', 'disabled'];
draw_select('wl1_security_mode', str, val, 'SelMode1(this.form.wl1_security_mode.selectedIndex,this.form)', '<% nvram_selget("wl1_security_mode"); %>');
})();
</script>
</td>
</tr>
<% nvram_invmatch("wl1_net_mode", "n-only", "-->"); %>
<% nvram_match("wl1_net_mode", "n-only", "<!--"); %>
<tr>
<td><script>Capture(wlansec.secmode)</script></td>
<td>
<script>
(function(){
var str = [hwlsec2.wpa2personal, hwlsec2.wpa2enterprise, share.disabled],
val = ['wpa2_personal', 'wpa2_enterprise', 'disabled'],
sel = '<% nvram_selget("wl1_security_mode"); %>';
draw_select('wl1_security_mode', str, val, 'SelMode1(this.form.wl1_security_mode.selectedIndex,this.form)', sel);
})();
</script>
</td>
</tr>
<% nvram_match("wl1_net_mode", "n-only", "-->"); %>
<tr style=display:none id="Passphrase">
<td><script>Capture(wlansec.passphrase)</script></td>
<td>
<input type="text" size="26" name="wl1_wpa_psk" value="<% nvram_get("wl1_wpa_psk"); %>" maxlength="64" />
</td>
</tr>
<tr style=display:none id=Server>
<td><script>Capture(wlansec.radiussrv)</script></td>
<td>
<input type="hidden" name="wl1_radius_ipaddr" value="4" />
<input type="text" style="width:40px" maxlength="3" name="wl1_radius_ipaddr_0" value="<% get_single_ip("wl1_radius_ipaddr","0"); %>" onBlur="valid_range2(this,1,223,'IP')" class="num" /> .
<input type="text" style="width:40px" maxlength="3" name="wl1_radius_ipaddr_1" value="<% get_single_ip("wl1_radius_ipaddr","1"); %>" onBlur="valid_range(this,0,255,'IP')" class="num" /> .
<input type="text" style="width:40px" maxlength="3" name="wl1_radius_ipaddr_2" value="<% get_single_ip("wl1_radius_ipaddr","2"); %>" onBlur="valid_range(this,0,255,'IP')" class="num" /> .
<input type="text" style="width:40px" maxlength="3" name="wl1_radius_ipaddr_3" value="<% get_single_ip("wl1_radius_ipaddr","3"); %>" onBlur="valid_range2(this,1,254,'IP')" class="num" />
</td>
</tr>
<tr style=display:none id=Port>
<td><script>Capture(wlansec.radiusport)</script></td>
<td>
<input type="text" style="width:50px" name="wl1_radius_port" value="<% get_web_valueex("wl1_radius_port"); %>" maxlength="5" onBlur="valid_range(this,1,65535,'Port')" />
</td>
</tr>
<tr style=display:none id=Key>
<td><script>Capture(wlansec.sharekey)</script></td>
<td>
<input type="text" size="26" name="wl1_radius_key" value="<% get_web_valueex("wl1_radius_key"); %>" maxlength="79" />
</td>
</tr>
<tr style=display:none id=enc>
<td><script>Capture(wlansec.enc)</script></td>
<td>
<script>
(function(){
var str = [wlansec.tenhex, wlansec.twentysixhex],
val = ['64', '128'];
draw_select('wl1_wep_bit', str, val, 'keyMode_1(this.form.wl1_wep_bit.selectedIndex)', '<% nvram_selget("wl1_wep_bit"); %>');
})();
</script>
</td>
</tr>
<tr style=display:none id=passphrase1>
<td><script>Capture(wlansec.passphrase)</script></td>
<td>
<input type="text" maxLength="32" name="wl1_passphrase" size="26" />
<input type="hidden" value="Null" name="generateButton1" />
<script>draw_button("javascript:generateKey1(this.form)", wlanbutton.generate, 'wepGenerate1')</script>
</td>
</tr>		
<tr style=display:none id=key1>
<td>
<script>
Capture(wlansec.key1);
</script>
</td>
<td>
<script>
document.write('<input type="text" size="26" name="wl1_key1" value="<% get_wep_value("key1", 1); %>" />');
</script>
</td>
</tr>		
<tr style=display:none id=key2>
<td>
<script>
Capture(wlansec.key2);
</script>
</td>
<td>
<script>
document.write('<input type="text" size="26" name="wl1_key2" value="<% get_wep_value("key2", 1); %>" />');                                      
</script>
</td>
</tr>
<tr style=display:none id=key3>
<td>
<script>
Capture(wlansec.key3);
</script>
</td>
<td>
<script>
document.write('<input type="text" size="26" name="wl1_key3" value="<% get_wep_value("key3", 1); %>" />');                                      
</script>
</td>
</tr>
<tr style=display:none id=key4>
<td>
<script>
Capture(wlansec.key4);
</script>
</td>
<td>
<script>
document.write('<input type="text" size="26" name="wl1_key4" value="<% get_wep_value("key4", 1); %>" />');                                      
</script>
</td>
</tr>
<tr style=display:none id=txkey1>
<td><script>Capture(wlansec.txkey)</script></td>
<td>
<input type="hidden" name="wl1_WEP_key" />
<input type="hidden" name="wl1_wep" value="restricted" />
<script>
(function(){
var str = ['1', '2', '3', '4'],
val = ['1', '2', '3', '4'];
draw_select('wl1_key', str, val, '', '<% nvram_get("wl1_key"); %>');
})();
</script>
</td>
</tr>		
</tbody>
</table>
<!-- 2.4G wireless setting over -->
<script>draw_table(MAINFUN2,wlansec.lgmenu);</script>
<table class="table table-info">
<tbody>
<% nvram_invmatch("wl0_net_mode", "n-only", "<!--"); %>
<tr>
<td><script>Capture(wlansec.secmode)</script></td>
<td>
<script>
(function(){
var str = [hwlsec2.wpa2personal, hwlsec2.wpa2enterprise, share.disabled],
val = ['wpa2_personal', 'wpa2_enterprise', 'disabled'];
draw_select('wl0_security_mode', str, val, 'SelMode(this.form.wl0_security_mode.selectedIndex,this.form)', '<% nvram_selget("wl0_security_mode"); %>');
})();
</script>
</td>
</tr>
<% nvram_invmatch("wl0_net_mode", "n-only", "-->"); %>
<% nvram_match("wl0_net_mode", "n-only", "<!--"); %>
<tr>
<td><script>Capture(wlansec.secmode)</script></td>
<td>
<script>
(function(){
var str = [hwlsec2.wpa2personal, hwlsec2.wpa2enterprise, share.disabled],
val = ['wpa2_personal', 'wpa2_enterprise', 'disabled'],
sel = '<% nvram_selget("wl0_security_mode"); %>';
draw_select('wl0_security_mode', str, val, 'SelMode(this.form.wl0_security_mode.selectedIndex,this.form)', sel);
})();
</script>
</td>
</tr>
<% nvram_match("wl0_net_mode", "n-only", "-->"); %>
<tr style=display:none id="trPassphrase">
<td><script>Capture(wlansec.passphrase)</script></td>
<td>
<input type="text" size="26" name="wl0_wpa_psk" value="<% nvram_get("wl0_wpa_psk"); %>" maxlength="64" />
</td>
</tr>
<tr style=display:none id=trServer>
<td><script>Capture(wlansec.radiussrv)</script></td>
<td>
<input type="hidden" name="wl0_radius_ipaddr" value="4" />
<input type="text" style="width:40px" maxlength="3" name="wl0_radius_ipaddr_0" value="<% get_single_ip("wl0_radius_ipaddr","0"); %>" onBlur="valid_range2(this,1,223,'IP')" class="num" /> .
<input type="text" style="width:40px" maxlength="3" name="wl0_radius_ipaddr_1" value="<% get_single_ip("wl0_radius_ipaddr","1"); %>" onBlur="valid_range(this,0,255,'IP')" class="num" /> .
<input type="text" style="width:40px" maxlength="3" name="wl0_radius_ipaddr_2" value="<% get_single_ip("wl0_radius_ipaddr","2"); %>" onBlur="valid_range(this,0,255,'IP')" class="num" /> .
<input type="text" style="width:40px" maxlength="3" name="wl0_radius_ipaddr_3" value="<% get_single_ip("wl0_radius_ipaddr","3"); %>" onBlur="valid_range2(this,1,254,'IP')" class="num" />
</td>
</tr>
<tr style=display:none id=trPort>
<td><script>Capture(wlansec.radiusport)</script></td>
<td>
<input type="text" style="width:50px" name="wl0_radius_port" value="<% get_web_valueex("wl0_radius_port"); %>" maxlength="5" onBlur="valid_range(this,1,65535,'Port')" />
</td>
</tr>
<tr style=display:none id=trKey>
<td><script>Capture(wlansec.sharekey)</script></td>
<td>
<input type="text" size="26" name="wl0_radius_key" value="<% get_web_valueex("wl0_radius_key"); %>" maxlength="79" />
</td>
</tr>	
<tr style=display:none id=trenc>
<td><script>Capture(wlansec.enc)</script></td>
<td>
<script>
(function(){
var str = [wlansec.tenhex, wlansec.twentysixhex],
val = ['64', '128'];
draw_select('wl0_wep_bit', str, val, 'keyMode_0(this.form.wl0_wep_bit.selectedIndex)', '<% nvram_selget("wl0_wep_bit"); %>');
})();
</script>
</td>
</tr>
<tr style=display:none id=trpassphrase0>
<td><script>Capture(wlansec.passphrase)</script></td>
<td>
<input type="text" maxLength="32" name="wl0_passphrase" size="26" />
<input type="hidden" value="Null" name="generateButton0" />
<script>draw_button("javascript:generateKey0(this.form)", wlanbutton.generate, 'wepGenerate0')</script>
</td>
</tr>	
<tr style=display:none id=trkey0>
<td>
<script>
Capture(wlansec.key1);
</script>
</td>
<td>
<script>
document.write('<input type="text" size="26" name="wl0_key1" value="<% get_wep_value("key1", 0); %>" />');
</script>
</td>
</tr>
<tr style=display:none id=trkey1>
<td>
<script>
Capture(wlansec.key2);
</script>
</td>
<td>
<script>
document.write('<input type="text" size="26" name="wl0_key2" value="<% get_wep_value("key2", 0); %>" />');
</script>
</td>
</tr>
<tr style=display:none id=trkey2>
<td>
<script>
Capture(wlansec.key3);
</script>
</td>
<td>
<script>
document.write('<input type="text" size="26" name="wl0_key3" value="<% get_wep_value("key3", 0); %>" />');
</script>
</td>
</tr>
<tr style=display:none id=trkey3>
<td>
<script>
Capture(wlansec.key4);
</script>
</td>
<td>
<script>
document.write('<input type="text" size="26" name="wl0_key4" value="<% get_wep_value("key4", 0); %>" />');
</script>
</td>
</tr>
<tr style=display:none id=txkey0>
<td><script>Capture(wlansec.txkey)</script></td>
<td>
<input type="hidden" name="wl0_WEP_key" />
<input type="hidden" name="wl0_wep" value="restricted" />
<script>
(function(){
var str = ['1', '2', '3', '4'],
val = ['1', '2', '3', '4'];
draw_select('wl0_key', str, val, '', '<% nvram_get("wl0_key"); %>');
})();
</script>
</td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
