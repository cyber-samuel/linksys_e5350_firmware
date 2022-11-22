<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Advanced Routing</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="javascript">
setFormActions({
save:    true,
cancel:  true
});
document.title = topmenu.advrouting;
var close_session = "<% get_session_status(); %>";
var route_win = null;
var del_route = new Array("0","0","0","0","0","0","0","0","0","0",
"0","0","0","0","0","0","0","0","0","0");
var route_names = [ <% static_route_setting("all_name","");%> ];
var route_infos = [ <% static_route_setting("all_route","");%> ];
function ViewRoute()
{	if(close_session == "1")
showPopout('RouteTable.asp');
else
showPopout('RouteTable.asp?session_id=<% nvram_get("session_key"); %>');
return;
if ( close_session == "1" )
{
route_win = self.open('RouteTable.asp', 'Route', 'alwaysRaised,resizable,scrollbars,width=700,height=360');
}
else
{
route_win = self.open('RouteTable.asp?session_id=<% nvram_get("session_key"); %>', 'Route', 'alwaysRaised,resizable,scrollbars,width=700,height=360');
}
route_win.focus();
}
function DeleteEntry(F)
{
/*
F.submit_button.value = "Routing";
F.change_action.value = "gozila_cgi";
F.submit_type.value = 'del';
F.submit();
*/
var selected = F.route_page.selectedIndex;
del_route[selected] = "1";
route_names[selected] = "";
route_infos[selected] = "0.0.0.0:0.0.0.0:0.0.0.0:0:br0";
F.route_page.options[F.route_page.selectedIndex].text = (F.route_page.selectedIndex+1) + " ( )";
F.route_name.value = "";
F.route_ipaddr_0.value = 0;
F.route_ipaddr_1.value = 0;
F.route_ipaddr_2.value = 0;
F.route_ipaddr_3.value = 0;
F.route_netmask_0.value = 0;
F.route_netmask_1.value = 0;
F.route_netmask_2.value = 0;
F.route_netmask_3.value = 0;
F.route_gateway_0.value = 0;
F.route_gateway_1.value = 0;
F.route_gateway_2.value = 0;
F.route_gateway_3.value = 0;
F.route_ifname.selectedIndex = 0;
}
function SelNAT(num,F)
{
if(F._wk_mode.checked == true){
F._dr_setting.checked = false;
choose_disable(F._dr_setting);
}
else {
choose_enable(F._dr_setting);
}
}
function valid_gateway(F)
{
var wan_ip = "<% nvram_get("wan_ipaddr"); %>";
var lan_ip = "<% nvram_get("lan_ipaddr"); %>";
var lan_mask = "<% nvram_get("lan_netmask"); %>";
var wan_mask = "<% nvram_get("wan_netmask"); %>";
var lan_ip1 = new Array(4); 
lan_ip1 = lan_ip.split('.');
var wan_ip1 = new Array(4); 
wan_ip1 = wan_ip.split('.');
var lan_mask1 = new Array(4); 
lan_mask1 = lan_mask.split('.');
var wan_mask1 = new Array(4); 
wan_mask1 = wan_mask.split('.');
var gateway_ip = F.route_gateway_0.value + "." + F.route_gateway_1.value+ "." + F.route_gateway_2.value+ "." + F.route_gateway_3.value;
var dest_ip = F.route_ipaddr_0.value + "." + F.route_ipaddr_1.value+ "." + F.route_ipaddr_2.value+ "." + F.route_ipaddr_3.value;
var dest_mask = F.route_netmask_0.value + "." + F.route_netmask_1.value+ "." + F.route_netmask_2.value+ "." + F.route_netmask_3.value;
if(dest_ip == "0.0.0.0") 
{
if((dest_mask == "0.0.0.0") 
&& (gateway_ip == "0.0.0.0"))
{
return true;
}
else
{
alert(errmsg.err76);	
return false;
}
}
if((wan_ip == "0.0.0.0") 
&& (F.route_ifname.options[F.route_ifname.selectedIndex].value == "wan"))
{
alert(errmsg.err76);	
return false;
}
if(((lan_ip1[0] & lan_mask1[0]) == (F.route_ipaddr_0.value & lan_mask1[0])) 
&& ((lan_ip1[1] & lan_mask1[1]) == (F.route_ipaddr_1.value & lan_mask1[1]))
&& ((lan_ip1[2] & lan_mask1[2]) == (F.route_ipaddr_2.value & lan_mask1[2]))
&& ((lan_ip1[3] & lan_mask1[3]) == (F.route_ipaddr_3.value & lan_mask1[3])))
{
alert(errmsg.err76);	
return false;
}
if(((lan_ip1[0] & F.route_netmask_0.value) == (F.route_ipaddr_0.value & F.route_netmask_0.value)) 
&& ((lan_ip1[1] & F.route_netmask_1.value) == (F.route_ipaddr_1.value & F.route_netmask_1.value))
&& ((lan_ip1[2] & F.route_netmask_2.value) == (F.route_ipaddr_2.value & F.route_netmask_2.value))
&& ((lan_ip1[3] & F.route_netmask_3.value) == (F.route_ipaddr_3.value & F.route_netmask_3.value)))
{
alert(errmsg.err76);	
return false;
}
if(wan_ip != "0.0.0.0")
{
if(((wan_ip1[0] & wan_mask1[0]) == (F.route_ipaddr_0.value & wan_mask1[0])) 
&& ((wan_ip1[1] & wan_mask1[1]) == (F.route_ipaddr_1.value & wan_mask1[1]))
&& ((wan_ip1[2] & wan_mask1[2]) == (F.route_ipaddr_2.value & wan_mask1[2]))
&& ((wan_ip1[3] & wan_mask1[3]) == (F.route_ipaddr_3.value & wan_mask1[3])))
{
alert(errmsg.err76);	
return false;
}
if(((wan_ip1[0] & F.route_netmask_0.value) == (F.route_ipaddr_0.value & F.route_netmask_0.value)) 
&& ((wan_ip1[1] & F.route_netmask_1.value) == (F.route_ipaddr_1.value & F.route_netmask_1.value))
&& ((wan_ip1[2] & F.route_netmask_2.value) == (F.route_ipaddr_2.value & F.route_netmask_2.value))
&& ((wan_ip1[3] & F.route_netmask_3.value) == (F.route_ipaddr_3.value & F.route_netmask_3.value)))
{
alert(errmsg.err76);		
return false;
}
}
if(F.route_ifname.options[F.route_ifname.selectedIndex].value == "lan")
{
if(gateway_ip == lan_ip)
{
alert(errmsg.err76);	
return false;
}
if(((lan_ip1[0] & lan_mask1[0]) != (F.route_gateway_0.value & lan_mask1[0])) 
|| ((lan_ip1[1] & lan_mask1[1]) != (F.route_gateway_1.value & lan_mask1[1]))
|| ((lan_ip1[2] & lan_mask1[2]) != (F.route_gateway_2.value & lan_mask1[2]))
|| ((lan_ip1[3] & lan_mask1[3]) != (F.route_gateway_3.value & lan_mask1[3])))
{
alert(errmsg.err76);	
return false;
}
}
else 
{
if(gateway_ip == wan_ip)
{
alert(errmsg.err76);	
return false;
}
if(((wan_ip1[0] & wan_mask1[0]) != (F.route_gateway_0.value & wan_mask1[0])) 
|| ((wan_ip1[1] & wan_mask1[1]) != (F.route_gateway_1.value & wan_mask1[1]))
|| ((wan_ip1[2] & wan_mask1[2]) != (F.route_gateway_2.value & wan_mask1[2]))
|| ((wan_ip1[3] & wan_mask1[3]) != (F.route_gateway_3.value & wan_mask1[3])))
{
alert(errmsg.err76);	
return false;
}
}
return true;
}
function to_submit(F)
{
/*Wenxuan add edge need*/
var userAgent = navigator.userAgent;
var isEdge = userAgent.indexOf("Edge") > -1;
if(isEdge)
{
if(!valid_range(F.route_ipaddr_0,0,223,'IP') || !valid_range(F.route_ipaddr_1,0,255,'IP') || !valid_range(F.route_ipaddr_2,0,255,'IP') || !valid_range(F.route_ipaddr_3,0,254,'IP') || !valid_range(F.route_netmask_0,0,255,'IP') || !valid_range(F.route_netmask_1,0,255,'IP') || !valid_range(F.route_netmask_2,0,255,'IP') || !valid_range(F.route_netmask_3,0,255,'IP') || !valid_range(F.route_gateway_0,0,223,'IP') || !valid_range(F.route_gateway_1,0,255,'IP') || !valid_range(F.route_gateway_2,0,255,'IP') || !valid_range(F.route_gateway_3,0,254,'IP'))
return;
}
/*Wenxuan add edge need*/
if(!chk_static_entry(F)) return;
if(valid_value(F) && valid_gateway(F)){
if( (F._wk_mode.checked == true && '<% nvram_get("wk_mode"); %>' == "router") || F._wk_mode.checked == false && '<% nvram_get("wk_mode"); %>' == "gateway") {
if(F._wk_mode.checked == false && !confirm(gn.nat))
{
F._wk_mode.checked = true;
SelNAT('gateway',F);
update_checked(F._wk_mode);
return false;
}
F.need_reboot.value = "1";
F.wait_time.value = "10";
}
if(F._wk_mode.checked == true)		F.wk_mode.value = "gateway";
else					F.wk_mode.value = "router";
if(F._dr_setting.checked == true) 	F.dr_setting.value = "3";
else					F.dr_setting.value = "0";
F.submit_button.value = "Routing";
F.gui_action.value = "Apply";
F.delete_route.value = del_route.toString();
var wk_mode = "<% nvram_get("wk_mode"); %>";
var dr_setting = "<% nvram_get("dr_setting"); %>";
if((wk_mode == F.wk_mode.value && dr_setting == F.dr_setting.value) || (dr_setting == "" && wk_mode == F.wk_mode.value))
{
ajaxSubmit(0,"false");
}
else
{
ajaxSubmit(70,"afterSuccess");
}
}
}
function valid_route_name(F, name)
{
var i = 0;
var rt_page = F.route_page.selectedIndex ;
var static_route_name = "<% nvram_get("static_route_name"); %>";
var cur_route_name = eval(name).value;
var temp_route_name = "$NAME:" + cur_route_name + "$$";
var rt_name = new Array();
rt_name = static_route_name.split(" ");
for(i = 0; i < rt_name.length; i++){
if((rt_name[i] == temp_route_name) && (rt_page != i))
{
alert(errmsg.err76);
return false;
}
}
return true;
}
function valid_value(F)
{
if(!valid_route_name(F,"F.route_name"))
return false;
if(!valid_ip(F,"F.route_ipaddr","IP",0))
return false;
if(!valid_mask(F,"F.route_netmask",ZERO_OK))
return false;
if(!valid_ip(F,"F.route_gateway","Gateway",MASK_NO))
return false;
return true;
}
function SelRoute(num,F)
{
var route_info = route_infos[num].split(":");
var ipaddr = route_info[0].split(".");
var netmask = route_info[1].split(".");
var gateway = route_info[2].split(".");
var lan_str = "<% nvram_get("lan_ifname"); %>";
F.route_name.value = route_names[num];
if(ipaddr[0] == "0")
F.route_ipaddr_0.defaultValue = 0;
else
F.route_ipaddr_0.defaultValue = ipaddr[0];
if(ipaddr[1] == "0")
F.route_ipaddr_1.defaultValue = 0;
else
F.route_ipaddr_1.defaultValue = ipaddr[1];
if(ipaddr[2] == "0")
F.route_ipaddr_2.defaultValue = 0;
else
F.route_ipaddr_2.defaultValue = ipaddr[2];
if(ipaddr[3] == "0")
F.route_ipaddr_3.defaultValue = 0;
else
F.route_ipaddr_3.defaultValue = ipaddr[3];
if(netmask[0] == "0")
F.route_netmask_0.defaultValue = 0;
else
F.route_netmask_0.defaultValue = netmask[0];
if(netmask[1] == "0")
F.route_netmask_1.defaultValue = 0;
else
F.route_netmask_1.defaultValue = netmask[1];
if(netmask[2] == "0")
F.route_netmask_2.defaultValue = 0;
else
F.route_netmask_2.defaultValue = netmask[2];
if(netmask[3] == "0")
F.route_netmask_3.defaultValue = 0;
else
F.route_netmask_3.defaultValue = netmask[3];
if(gateway[0] == "0")
F.route_gateway_0.defaultValue = 0;
else
F.route_gateway_0.defaultValue = gateway[0];
if(gateway[1] == "0")
F.route_gateway_1.defaultValue = 0;
else
F.route_gateway_1.defaultValue = gateway[1];
if(gateway[2] == "0")
F.route_gateway_2.defaultValue = 0;
else
F.route_gateway_2.defaultValue = gateway[2];
if(gateway[3] == "0")
F.route_gateway_3.defaultValue = 0;
else
F.route_gateway_3.defaultValue = gateway[3];
F.route_ipaddr_0.value = ipaddr[0];
F.route_ipaddr_1.value = ipaddr[1];
F.route_ipaddr_2.value = ipaddr[2];
F.route_ipaddr_3.value = ipaddr[3];
F.route_netmask_0.value = netmask[0];
F.route_netmask_1.value = netmask[1];
F.route_netmask_2.value = netmask[2];
F.route_netmask_3.value = netmask[3];
F.route_gateway_0.value = gateway[0];
F.route_gateway_1.value = gateway[1];
F.route_gateway_2.value = gateway[2];
F.route_gateway_3.value = gateway[3];
if ( route_info[4] == lan_str )
F.route_ifname.value = "lan";
else
F.route_ifname.value = "wan";
F.route_page.value=F.route_page.options[num].value;
}
function exit()
{
closeWin(route_win);
}
function chk_ip_gw(lanip,wanip,lanmask,wanmask,data)
{
var sip = data[0].split(".");
var mask = data[1].split(".");
var gw = data[2].split(".");
var i,lanflg=0; 
var wdip = wanip.split(".");
var wdmask = wanmask.split(".");
var ldip = lanip.split(".");
var ldmask = lanmask.split(".");
/*add by michael to fix IR-B0015237 dst ip can be 0.1.1.0*/
if(sip[0] == 0 && (sip[1]!= 0 || sip[2]!=0 || sip[3]!= 0))
return true;
for(i=0; i<4; i++)
{
if((sip[i]&ldmask[i])==ldip[i]) lanflg+=1;
if( lanflg == 3 ) return true ;  // Dest IP Address cannot the same as LAN subnet
if( sip[i] != (mask[i] & sip[i])) return true ; 
if ( data[3] == "wan" ) //John zhu@2008.04.09,fix the bug:cannot save wan routes
{
if ( (gw[i] & wdmask[i]) != ( wdmask[i] & wdip[i] ) ) return true ; 
}
else 
if ( (gw[i] & ldmask[i]) != ( ldmask[i] & ldip[i] ) ) return true ; 
}
return false ; 
}
function i_data(F,data,k,isend,item)
{
var i , idata="";
if ( item == 0 )
{
idata = eval(data).value ;
return idata ;
}
for(i=0; i<k; i++)
{
idata = idata + eval(data+i).value ;
if ( i == k-1 )
{
if ( !isend )idata = idata + ":";
}
else
idata = idata + ".";
}
return idata ;
}
function chk_static_entry(F)
{
var data = new Array();
var sdata = new Array();
var ddata = new Array();
var i,j,k,idata="",returnvalue = "";
var lanip = "<% nvram_get("lan_ipaddr"); %>";
var wanip = "<% nvram_get("wan_ipaddr"); %>";
var lanmask = "<% nvram_get("lan_netmask"); %>";
var wanmask = "<% nvram_get("wan_netmask"); %>";
data = "<% nvram_get("static_route"); %>".split(" ");
idata = idata + i_data(F,"F.route_ipaddr_",4,0,1);
idata = idata + i_data(F,"F.route_netmask_",4,0,1);
idata = idata + i_data(F,"F.route_gateway_",4,0,1);
idata = idata + i_data(F,"F.route_ifname",1,1,0);
if(F.route_ipaddr_0.value == "0" && F.route_ipaddr_1.value == "0" && F.route_ipaddr_2.value == "0" && F.route_ipaddr_3.value == "0" && F.route_netmask_0.value == "0" && F.route_netmask_1.value == "0" && F.route_netmask_2.value == "0" && F.route_netmask_3.value == "0" && F.route_gateway_0.value == "0" && F.route_gateway_1.value == "0" && F.route_gateway_2.value == "0" && F.route_gateway_3.value == "0") {                 return true;         } 
for(i=0; i<data.length; i++)
{
sdata = data[i].split(":");
ddata = idata.split(":");
k=0;
returnvalue = chk_ip_gw(lanip,wanip,lanmask,wanmask,ddata);
if ( (ddata[3]=="lan" && ddata[2] == lanip) || (ddata[3]=="wan" && ddata[2] == wanip) || returnvalue == true)
{
alert(errmsg.err76);
return false ;
}
if( F.route_page.selectedIndex != i )
{
for(j=0; j<2; j++)
{
if ( sdata[j] == ddata[j] )
k++;
}
if ( k==2 )
{
alert(errmsg.err76);
return false ;
}
}
}
return true ;
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
SelNAT('<% nvram_get("wk_mode"); %>',document.route_static);
SelRoute(0, document.route_static);
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
</SCRIPT>
</HEAD>
<BODY onunload="exit()" onload="init()" onbeforeunload = "return checkFormChanged(document.route_static)">
<DIV align="center">
<FORM name="route_static" action="apply.cgi" method="<% get_http_method(); %>">
<input type="hidden" name="submit_button" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="change_action" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="static_route" />
<input type="hidden" name="delete_route" />
<input type="hidden" name="wk_mode" />
<input type="hidden" name="dr_setting" />
<input type="hidden" name="need_reboot" value="0" />
<input type="hidden" name="wait_time" value="2" />
<% web_include_file("Top.asp"); %>
<script>draw_table(MAINFUN2,topmenu.advrouting);</script>
<table class="table table-info">
<tbody>
<tr>
<td><!--
<script>draw_radio('wk_mode', share.enabled, 'gateway', "SelNAT('gateway',this.form)" <% nvram_match("wk_mode","gateway",", 0"); %>);</script>
<script>draw_radio('wk_mode', share.disabled, 'router', "SelNAT('router',this.form)" <% nvram_match("wk_mode","router",", 0"); %>);</script>-->
<script>draw_checkbox('_wk_mode', share.nat, 'gateway', "SelNAT('gateway',this.form)" <% nvram_match("wk_mode","gateway",", 1"); %>);</script>
</td>
</tr>
</tbody>
</table>
<script>draw_table(MAINFUN2,hrouting.phase4);</script>
<table class="table table-info">
<tbody>
<tr>
<td><!--
<script>draw_radio('dr_setting', share.enabled, '3', '' <% nvram_match("dr_setting","3",", 0"); %>);</script>
<script>draw_radio('dr_setting', share.disabled, '0', '' <% nvram_match("dr_setting","0",", 0"); %>);</script>
-->
<script>draw_checkbox('_dr_setting', share.enabled, '3', '' <% nvram_match("dr_setting","3",", 1"); %>);</script>
</td>
</tr>
</tbody>
</table>
<script>draw_table(MAINFUN2,lefemenu.staticroute);</script>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(advroute.routeentries)</script></td>
<td>
<select id="route_page_opts" style="display:none" readonly="readonly">
<% static_route_table("select"); %>
</select>
<script>
(function(){
draw_select('route_page', [], [], 'SelRoute(this.selectedIndex,this.form)').width('auto');
var sel = document.getElementById('route_page'),
tmp = document.getElementById('route_page_opts'),
idx = tmp.selectedIndex;
while( tmp.options.length )
sel.appendChild(tmp.options[0]);
sel.selectedIndex = idx;
update_selected(sel);
tmp.parentElement.removeChild(tmp);
})();
</script>
<script>draw_button("javascript:DeleteEntry(this.form)", advroute.delentries, 'delentry')</script>
</td>
</tr>
<tr>
<td><script>Capture(advroute.routename)</script></td>
<td>
<input type="text" name="route_name" size="26" maxlength="20" onBlur="valid_name1(this,'Route%20Name')" class="num" />
</td>
</tr>
<tr>
<td><script>Capture(advroute.deslanip)</script></td>
<td>
<input type="hidden" name="route_ipaddr" value="4" />
<input type="text" name="route_ipaddr_0" maxlength="3" onBlur="valid_range(this,1,223,'IP')" class="num" style="width:40px" /> .
<input type="text" name="route_ipaddr_1" maxlength="3" onBlur="valid_range(this,0,255,'IP')" class="num" style="width:40px" /> .
<input type="text" name="route_ipaddr_2" maxlength="3" onBlur="valid_range(this,0,255,'IP')" class="num" style="width:40px" /> .
<input type="text" name="route_ipaddr_3" maxlength="3" onBlur="valid_range(this,1,254,'IP')" class="num" style="width:40px" />
</td>
</tr>
<tr>
<td><script>Capture(share.submask)</script></td>
<td>
<input type="hidden" name="route_netmask" value="4">
<input type="text" name="route_netmask_0" maxlength="3" onBlur="valid_range(this,0,255,'IP')" class="num" style="width:40px" /> .
<input type="text" name="route_netmask_1" maxlength="3" onBlur="valid_range(this,0,255,'IP')" class="num" style="width:40px" /> .
<input type="text" name="route_netmask_2" maxlength="3" onBlur="valid_range(this,0,255,'IP')" class="num" style="width:40px" /> .
<input type="text" name="route_netmask_3" maxlength="3" onBlur="valid_range(this,0,255,'IP')" class="num" style="width:40px" />
</td>
</tr>
<tr>
<td><script>Capture(share.gateway)</script></td>
<td>
<input type="hidden" name="route_gateway" value="4">
<input type="text" name="route_gateway_0" maxlength="3" onBlur="valid_range(this,1,223,'IP')" class="num" style="width:40px" /> .
<input type="text" name="route_gateway_1" maxlength="3" onBlur="valid_range(this,0,255,'IP')" class="num" style="width:40px" /> .
<input type="text" name="route_gateway_2" maxlength="3" onBlur="valid_range(this,0,255,'IP')" class="num" style="width:40px" /> .
<input type="text" name="route_gateway_3" maxlength="3" onBlur="valid_range(this,1,254,'IP')" class="num" style="width:40px" />
</td>
</tr>
<tr>
<td><script>Capture(share.inter_face)</script></td>
<td>
<script>
(function(){
var str = [share.lanwireless, advroute.waninternet],
val = ['lan', 'wan'];
draw_select('route_ifname', str, val);
})();
</script>
</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>
<script>draw_button("javascript:ViewRoute()", advroute.showroutetbl, 'button2')</script>
</td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></DIV></HTML>
