<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>><HEAD><TITLE>Access Policy</TITLE>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("filelink.asp"); %>
<SCRIPT language="JavaScript">
setFormActions({
save:   true,
cancel: true
});
document.title = pactrl.pactrl;
var close_session = "<% get_session_status(); %>";
var sel_dev = "";
var MAX_DEV_NUM = 5;
var MAX_URL_NUM = 8;
var dev_infos = [
<% get_dev_info();%>
["",""] ];
var block_dev_info = [
<% get_block_dev(); %>
["",""]];/*policy,mac*/
var block_time_info = [
<% get_block_time();%>
["","","","","",""] /*policy, block_time_status,sc_time_start,sc_time_end,wd_time_start,wd_time_end*/
];
var block_url_info = [
<% get_block_url(); %>
["","","","","","","","",""]	/*policy,url1,url2,url3,url4,url5,url6,url7,url8*/
];
var policy_list= new Array();
function add_policy_info(mac,block_tm_status,sc_tm_st,sc_tm_end,wd_tm_st,wd_tm_end,url0,url1,url2,url3,url4,url5,url6,url7)
{
this.mac = mac;
this.block_tm_status = block_tm_status;
this.sc_tm_st = sc_tm_st;
this.sc_tm_end = sc_tm_end;
this.wd_tm_st = wd_tm_st;
this.wd_tm_end = wd_tm_end;
this.url0 = url0;
this.url1 = url1;
this.url2 = url2;
this.url3 = url3;
this.url4 = url4;
this.url5 = url5;
this.url6 = url6;
this.url7 = url7;
}
function init_policy_array()
{
for(var i = 0; i < 14; i++)
{
if(i < block_dev_info.length - 1)
policy_list[policy_list.length++] = new add_policy_info(block_dev_info[i][1],block_time_info[i][1],block_time_info[i][2],block_time_info[i][3],block_time_info[i][4],block_time_info[i][5],block_url_info[i][1],block_url_info[i][2],block_url_info[i][3],block_url_info[i][4],block_url_info[i][5],block_url_info[i][6],block_url_info[i][7],block_url_info[i][8]); 
else
policy_list[policy_list.length++] = new add_policy_info("","0","18","13","24","13","","","","","","","","");
}
}
function timeblockset(flag)
{
if(flag == "2")
{
document.forms[0].hnd_time_status[2].checked = true;
document.forms[0].hnd_sc_start_time.disabled = false;
document.forms[0].hnd_sc_end_time.disabled = false;
document.forms[0].hnd_wd_start_time.disabled = false;
document.forms[0].hnd_wd_end_time.disabled = false;		
}
else if(flag == "1")
{
document.forms[0].hnd_time_status[1].checked = true;
document.forms[0].hnd_sc_start_time.disabled = true;
document.forms[0].hnd_sc_end_time.disabled = true;
document.forms[0].hnd_wd_start_time.disabled = true;
document.forms[0].hnd_wd_end_time.disabled = true;		
}
else
{
document.forms[0].hnd_time_status[0].checked = true;
document.forms[0].hnd_sc_start_time.disabled = true;
document.forms[0].hnd_sc_end_time.disabled = true;
document.forms[0].hnd_wd_start_time.disabled = true;
document.forms[0].hnd_wd_end_time.disabled = true;		
}
update_checked(document.forms[0].hnd_time_status);
update_selected(document.forms[0].hnd_sc_start_time);
update_selected(document.forms[0].hnd_sc_end_time);
update_selected(document.forms[0].hnd_wd_start_time);
update_selected(document.forms[0].hnd_wd_end_time);
}
function set_block_url(id)
{
var f = document.forms[0];
for(var i = 0; i < 8; i++)
eval("f.url"+i).value = eval("policy_list["+id+"].url"+i);
}
function set_block_time(id)
{
timeblockset(eval("policy_list["+id+"].block_tm_status"));	
document.forms[0].hnd_sc_start_time.selectedIndex = eval("policy_list["+id+"].sc_tm_st");
document.forms[0].hnd_sc_end_time.selectedIndex = eval("policy_list["+id+"].sc_tm_end");
document.forms[0].hnd_wd_start_time.selectedIndex = eval("policy_list["+id+"].wd_tm_st");
document.forms[0].hnd_wd_end_time.selectedIndex = eval("policy_list["+id+"].wd_tm_end");
update_selected(document.forms[0].hnd_sc_start_time);
update_selected(document.forms[0].hnd_sc_end_time);
update_selected(document.forms[0].hnd_wd_start_time);
update_selected(document.forms[0].hnd_wd_end_time);
}
function exist_add_dev()//Add by seal 110129 to fix the JIRA P3 E1200-98
{
var exist = 0;
for(var i = 0; i <dev_infos.length -1; i++)
{
exist = 0;
for(var j = 0; j< document.forms[0].dev_list.options.length;j++)
{
if(dev_infos[i][0] == document.forms[0].dev_list.options[j].value)
exist = 1;
}
if(exist == 0)
break;
}	
return exist;
}
function add_dev()
{	if( close_session == "1")
showPopout('PC_adddev.asp', '420px');
else
showPopout('PC_adddev.asp?session_id=<% nvram_get("session_key"); %>', '420px');
return;
if ( close_session == "1" )
{
self.open('PC_adddev.asp','DHCPResTable','alwaysRaised,resizable,scrollbars,width=650,height=400').focus();
}
else
{
self.open('PC_adddev.asp?session_id=<% nvram_get("session_key"); %>','DHCPResTable','alwaysRaised,resizable,scrollbars,width=650,height=400').focus();
}
}
function set_sel_value()
{
for(var i = 0; i<policy_list.length; i++)
{
if(sel_dev == policy_list[i].mac)
{
set_block_url(i);
set_block_time(i);
break;
}
}
}
function select_dev(I)
{
if(document.forms[0].dev_list.options.length == 0)
{
return;
}
sel_dev = I.value;
document.forms[0].removedev.disabled = false;
document.forms[0].renamedev.disabled = false;
set_sel_value();
}
function set_block_value(I,M)
{
if(M >= 0 && M <= 7)
valid_name(I,"URL");
for(var i = 0; i < MAX_DEV_NUM; i++)
{
if(sel_dev == policy_list[i].mac)
{
switch(M)
{
/*block url*/
case 0:
policy_list[i].url0 = I.value.replace(/^\[/,"").replace(/\]$/,"");
break;
case 1:
policy_list[i].url1 = I.value.replace(/^\[/,"").replace(/\]$/,"");
break;
case 2:
policy_list[i].url2 = I.value.replace(/^\[/,"").replace(/\]$/,"");
break;
case 3:
policy_list[i].url3 = I.value.replace(/^\[/,"").replace(/\]$/,"");
break;
case 4:
policy_list[i].url4 = I.value.replace(/^\[/,"").replace(/\]$/,"");
break;
case 5:
policy_list[i].url5 = I.value.replace(/^\[/,"").replace(/\]$/,"");
break;
case 6:
policy_list[i].url6 = I.value.replace(/^\[/,"").replace(/\]$/,"");
break;
case 7:
policy_list[i].url7 = I.value.replace(/^\[/,"").replace(/\]$/,"");
break;
/* block time*/
case 8:
policy_list[i].sc_tm_st = I.value;
break;
case 9:
policy_list[i].sc_tm_end = I.value;
break;
case 10:
policy_list[i].wd_tm_st = I.value;
break;
case 11:
policy_list[i].wd_tm_end = I.value;
break;				
case 12:
policy_list[i].block_tm_status = I.value;
if(I.value != 2)
{
policy_list[i].sc_tm_st = "18";
policy_list[i].sc_tm_end = "13";
policy_list[i].wd_tm_st = "24";
policy_list[i].wd_tm_end = "13";
}
set_block_time(i)
break;	
}
break;
}
}
}
function add_option(text,value)
{
var count = document.forms[0].dev_list.options.length;
var item = new Option(text,value);
document.forms[0].dev_list.options[count] = item;
document.forms[0].dev_list.selectedIndex = count;
enable_web_ui();
for(var i = 0; i < MAX_DEV_NUM; i++)
{
if(policy_list[i].mac.length == 0)
{
policy_list[i].mac = value;
policy_list[i].block_tm_status = "0";
policy_list[i].sc_tm_st = "18";
policy_list[i].sc_tm_end = "13";
policy_list[i].wd_tm_st = "24";
policy_list[i].wd_tm_end = "13";	
policy_list[i].url0 = "";
policy_list[i].url1 = "";
policy_list[i].url2 = "";
policy_list[i].url3 = "";
policy_list[i].url4 = "";
policy_list[i].url5 = "";
policy_list[i].url6 = "";
policy_list[i].url7 = "";
break;
}
}
sel_dev = value;
set_sel_value();
if(document.forms[0].dev_list.options.length >= MAX_DEV_NUM)
{
document.forms[0].adddev.disabled = true;
}
if(exist_add_dev())	//Add by seal 110129 to fix the JIRA P3 E1200-98
{
document.forms[0].adddev.disabled = true;
}
}
function disable_web_ui()
{
var f = document.forms[0];
f.removedev.disabled = true;
f.renamedev.disabled = true;
f.url0.disabled = true;
f.url1.disabled = true;
f.url2.disabled = true;
f.url3.disabled = true;
f.url4.disabled = true;
f.url5.disabled = true;
f.url6.disabled = true;
f.url7.disabled = true;
f.hnd_time_status[0].checked = true;
f.hnd_time_status[0].disabled = true;
f.hnd_time_status[1].disabled = true;
f.hnd_time_status[2].disabled = true;
f.hnd_sc_start_time.disabled = true;
f.hnd_sc_end_time.disabled = true;
f.hnd_wd_start_time.disabled = true;
f.hnd_wd_end_time.disabled = true;
update_checked(f.hnd_time_status);
update_selected(f.hnd_sc_start_time);
update_selected(f.hnd_sc_end_time);
update_selected(f.hnd_wd_start_time);
update_selected(f.hnd_wd_end_time);
}
function enable_web_ui()
{
var f = document.forms[0];
f.removedev.disabled = false;
f.renamedev.disabled = false;
f.url0.disabled = false;
f.url1.disabled = false;
f.url2.disabled = false;
f.url3.disabled = false;
f.url4.disabled = false;
f.url5.disabled = false;
f.url6.disabled = false;
f.url7.disabled = false;
f.hnd_time_status[0].checked = true;
f.hnd_time_status[0].disabled = false;
f.hnd_time_status[1].disabled = false;
f.hnd_time_status[2].disabled = false;
f.hnd_sc_start_time.disabled = false;
f.hnd_sc_end_time.disabled = false;
f.hnd_wd_start_time.disabled = false;
f.hnd_wd_end_time.disabled = false;
update_checked(f.hnd_time_status);
update_selected(f.hnd_sc_start_time);
update_selected(f.hnd_sc_end_time);
update_selected(f.hnd_wd_start_time);
update_selected(f.hnd_wd_end_time);	
}
function remove_dev()
{
if(sel_dev == "")
{
alert(pctrl.seladev);
}
else
{
var f = document.PC;
count = f.dev_list.options.length;
for(var i = 0; i < count; i++)
{
if(sel_dev == f.dev_list.options[i].value)
{
document.PC.dev_list.remove(i);
break;
}
}	
for(var i=0; i< MAX_DEV_NUM;i++)
{
if(sel_dev == policy_list[i].mac)
{
policy_list[i].mac = "";
policy_list[i].block_tm_status = "0";
policy_list[i].sc_tm_st = "18";
policy_list[i].sc_tm_end = "13";
policy_list[i].wd_tm_st = "24";
policy_list[i].wd_tm_end = "13";	
policy_list[i].url0 = "";
policy_list[i].url1 = "";
policy_list[i].url2 = "";
policy_list[i].url3 = "";
policy_list[i].url4 = "";
policy_list[i].url5 = "";
policy_list[i].url6 = "";
policy_list[i].url7 = "";
break;
}
}
if(f.dev_list.options.length == 0)
{
disable_web_ui();
}
else
{
sel_dev = f.dev_list.options[0].value;
f.dev_list.selectedIndex = 0;
set_sel_value();
}
document.forms[0].adddev.disabled = false;
}
}
function rename_dev()
{
if(sel_dev == "")
{
alert(pctrl.seladev);
}
else
{	if( close_session == "1")
showPopout('PC_renamedev.asp', '450px');
else
showPopout('PC_renamedev.asp?session_id=<% nvram_get("session_key"); %>', '450px');
return;
var f = document.forms[0];
if ( close_session == "1" )
{
self.open('PC_renamedev.asp','DHCPResTable','alwaysRaised,resizable,scrollbars,width=680,height=350').focus();
}
else
{
self.open('PC_renamedev.asp?session_id=' + session_key,'DHCPResTable','alwaysRaised,resizable,scrollbars,width=680,height=350').focus();
}
}
}
function rename_device(new_name)
{
var f = document.forms[0];
f.setdevnameflag.value = "1";
f.dev_list.options[f.dev_list.selectedIndex].text = new_name;	
}
/*
function sel_pc(flag)
{
var f = document.forms[0];
f.submit_button.value = "PC_settings";
f.change_action.value = "gozila_cgi";
if(flag == "1")
{
f.next_page.value = "PCAR.asp";	
}
else
{
f.next_page.value = "Filters.asp";	
}
f.submit();	
}*/
var set_passwd = "<% get_pc_passwd_status();%>";
function to_submit(f)
{
for(var i=0; i<8; i++)
{
if(eval("f.url"+i+".value").indexOf('..') != -1)
{
alert(ddnsm.tzo_notfqdn);
eval("f.url"+i).focus();
return;
}
}
var count = f.dev_list.options.length;
if(f._tmsss_enabled.checked == true)	f.tmsss_enabled.value = 1;
else					f.tmsss_enabled.value = 0;	
if(f._tmsss_enabled.checked == false)	//disabled
/*{
if(hnd_filter_enabled != "1")
{
f.submit_button.value = "PCAR";
f.gui_action.value = "Apply";
ajaxSubmit(0,false);
return;
}
else*/
if ( close_session == "1" )
{
showPopout('PC_passwd.asp', '500px');
}
else
{
showPopout('PC_passwd.asp?session_id=<% nvram_get("session_key"); %>', '500px');	
}
f.pcblockdev.value = count;
for(var i = 0; i< count; i++)
{
eval("f.dev_mac_"+i).value = f.dev_list.options[i].value;
eval("f.dev_name_"+i).value = f.dev_list.options[i].text;
eval("f.pcblockpolicy"+i).value = f.dev_list.options[i].text;
}
for(var i = 0; i < MAX_DEV_NUM; i++)
{
var match  = 0;
if(i >= count)
break;
for(var j = 0; j < MAX_DEV_NUM; j++)
{
if(eval("f.dev_mac_"+i).value == eval("policy_list["+j+"].mac"))
{
eval("f.hnd_time_status"+i).value = eval("policy_list["+j+"].block_tm_status");				
eval("f.hnd_sc_start_time"+i).value = eval("policy_list["+j+"].sc_tm_st");				
eval("f.hnd_sc_end_time"+i).value = eval("policy_list["+j+"].sc_tm_end");				
eval("f.hnd_wd_start_time"+i).value = eval("policy_list["+j+"].wd_tm_st");				
eval("f.hnd_wd_end_time"+i).value = eval("policy_list["+j+"].wd_tm_end");				
var block_url="";
for(var k = 0; k < MAX_URL_NUM; k++)
{
if(eval("policy_list["+j+"].url"+k+".length")>0)
{
block_url += eval("policy_list["+j+"].url"+k) + "<&nbsp;>";
}
}
eval("f.pcblockurl_policy"+i).value = block_url;
match = 1;
break;
}	
}
if(match != 1)
{
eval("f.hnd_time_status"+i).value = "0";				
eval("f.hnd_sc_start_time"+i).value = "0";				
eval("f.hnd_sc_end_time"+i).value = "0";				
eval("f.hnd_wd_start_time"+i).value = "0";				
eval("f.hnd_wd_end_time"+i).value = "0"				
eval("f.pcblockurl_policy"+i).value = "";
}
}
if(doInitFormData)
{	
to_submit_post();
return;
}	
if(set_passwd == "0")
{	if ( close_session == "1")
showPopout('PC_set.asp', '600px');
else
showPopout('PC_set.asp?session_id=<% nvram_get("session_key"); %>', '600px');
return;
if ( close_session == "1" )
{
self.open('PC_set.asp','DHCPResTable','alwaysRaised,resizable,scrollbars,width=680,height=450').focus();
}
else
{
self.open('PC_set.asp?session_id=' + session_key,'DHCPResTable','alwaysRaised,resizable,scrollbars,width=680,height=450').focus();
}	
}
else
{
if(close_session == "1")
showPopout('PC_passwd.asp', '500px');
else
showPopout('PC_passwd.asp?session_id=<% nvram_get("session_key"); %>', '500px');
return;
if ( close_session == "1" )
{
self.open('PC_passwd.asp','DHCPResTable','alwaysRaised,resizable,scrollbars,width=660,height=350').focus();
}
else
{
self.open('PC_passwd.asp?session_id=' + session_key,'DHCPResTable','alwaysRaised,resizable,scrollbars,width=660,height=350').focus();
}
}
}
function to_submit_post()
{
var f = document.PC;
f.submit_button.value = "PCAR";
f.gui_action.value = "Apply";
ajaxSubmit(0, "afterSave" ,"",function(){
set_passwd = 1;
});
}
function enable_disable_all(F, I)
{
var start = '';
var end = '';
var total = F.elements.length;
for(i=0 ; i < total ; i++)
{
if(F.elements[i].name == "dev_list")  
start = i;
if(F.elements[i].name == "url7")  
end = i;
}
if(start == '' || end == '')    
return true;
if(F._tmsss_enabled.checked == false) 
{
for(i = start; i<=end ;i++)
choose_disable(F.elements[i]);
choose_disable(F.pcblockdev);
choose_disable(F.pcblockurl);
choose_disable(F.pcblocktime);
}
else 
{
for(i = start; i<=end ;i++)
choose_enable(F.elements[i]);
choose_enable(F.pcblockdev);
choose_enable(F.pcblockurl);
choose_enable(F.pcblocktime);
if(F.dev_list.options.length == 0)
{
disable_web_ui();
}
else if(F.dev_list.options.length >= MAX_DEV_NUM)
{
choose_disable(F.adddev);
}
else
{
if((F.hnd_time_status[0].checked)||(F.hnd_time_status[1].checked))
{
choose_disable(F.hnd_sc_start_time);
choose_disable(F.hnd_sc_end_time);
choose_disable(F.hnd_wd_start_time);
choose_disable(F.hnd_wd_end_time);		
}
}
if(exist_add_dev())	//Add by seal 110129 to fix the JIRA P3 E1200-98
{
choose_disable(F.adddev);
}
}
}
function init()
{
var swmode = '<% nvram_get("switch_mode");%>';
if( swmode == 1)
alert(share.brdgmwn);
var bridge_mode = "<% nvram_get("wbridge_mode");%>";
if(bridge_mode == "1")
alert(wlanbridge.warn);
var f = document.forms[0];
init_policy_array();
for(var i = 0; i< block_dev_info.length - 1; i++)
{
for(var j = 0; j< dev_infos.length - 1; j++)
{
if(dev_infos[j][0] == block_dev_info[i][1])
{
if(dev_infos[j][1].length == 0)
var dev_name = pctrl.nwdev;
else
var dev_name = dev_infos[j][1];
var item = new Option(dev_name,dev_infos[j][0]);
f.dev_list.options[f.dev_list.options.length] = item;
break;
}
}
}
for(var i = 0; i <32 ; i++)
{
eval("f.dev_mac_"+i).value = "";
eval("f.dev_name_"+i).value = "";
}
for(var i = 0; i< MAX_DEV_NUM; i++)
{
eval("f.pcblockurl_policy"+i).value = "";
eval("f.hnd_time_status"+i).value = "";
eval("f.hnd_sc_start_time"+i).value = "";
eval("f.hnd_sc_end_time"+i).value = "";
eval("f.hnd_wd_start_time"+i).value = "";
eval("f.hnd_wd_end_time"+i).value = "";
}
if(f.dev_list.options.length == 0)
disable_web_ui();
else
{
sel_dev = f.dev_list.options[0].value;
f.dev_list.selectedIndex = 0;
set_sel_value();
}
if(document.forms[0].dev_list.options.length >= MAX_DEV_NUM)
{
document.forms[0].adddev.disabled = true;
}
set_block_url(0);
enable_disable_all(document.PC,'<% nvram_get("tmsss_enabled"); %>');
var close_session = "<% get_session_status(); %>";
if ( close_session == "1" )
{
document.forms[0].action= "apply.cgi";
}
else
{
document.forms[0].action= "apply.cgi?session_id=<% nvram_get("session_key"); %>";
}
/*setInitFormData(function(){
to_submit(document.forms[0])
});*/
}
</SCRIPT>
</HEAD>
<BODY onload="init()" onbeforeunload = "return checkFormChanged(document.PC)">
<FORM name="PC" method="<% get_http_method(); %>" action="apply.cgi">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<input type="hidden" name="gui_action" />
<input type="hidden" name="next_page" />
<input type="hidden" name="pcblockdev" />
<input type="hidden" name="pcblocktime" />
<input type="hidden" name="pcblockurl" />
<input type="hidden" name="pcblockurl_policy0" />
<input type="hidden" name="pcblockurl_policy1" />
<input type="hidden" name="pcblockurl_policy2" />
<input type="hidden" name="pcblockurl_policy3" />
<input type="hidden" name="pcblockurl_policy4" />
<input type="hidden" name="pcblockurl_policy5" />
<input type="hidden" name="pcblockurl_policy6" />
<input type="hidden" name="pcblockurl_policy7" />
<input type="hidden" name="pcblockurl_policy8" />
<input type="hidden" name="pcblockurl_policy9" />
<input type="hidden" name="pcblockurl_policy10" />
<input type="hidden" name="pcblockurl_policy11" />
<input type="hidden" name="pcblockurl_policy12" />
<input type="hidden" name="pcblockurl_policy13" />
<input type="hidden" name="pcblockpolicy" />
<input type="hidden" name="pcblockpolicy0" />
<input type="hidden" name="pcblockpolicy1" />
<input type="hidden" name="pcblockpolicy2" />
<input type="hidden" name="pcblockpolicy3" />
<input type="hidden" name="pcblockpolicy4" />
<input type="hidden" name="pcblockpolicy5" />
<input type="hidden" name="pcblockpolicy6" />
<input type="hidden" name="pcblockpolicy7" />
<input type="hidden" name="pcblockpolicy8" />
<input type="hidden" name="pcblockpolicy9" />
<input type="hidden" name="pcblockpolicy10" />
<input type="hidden" name="pcblockpolicy11" />
<input type="hidden" name="pcblockpolicy12" />
<input type="hidden" name="pcblockpolicy13" />
<input type="hidden" name="hnd_time_status0" />
<input type="hidden" name="hnd_sc_start_time0" />
<input type="hidden" name="hnd_sc_end_time0" />
<input type="hidden" name="hnd_wd_start_time0" />
<input type="hidden" name="hnd_wd_end_time0" />
<input type="hidden" name="hnd_time_status1" />
<input type="hidden" name="hnd_sc_start_time1" />
<input type="hidden" name="hnd_sc_end_time1" />
<input type="hidden" name="hnd_wd_start_time1" />
<input type="hidden" name="hnd_wd_end_time1" />
<input type="hidden" name="hnd_time_status2" />
<input type="hidden" name="hnd_sc_start_time2" />
<input type="hidden" name="hnd_sc_end_time2" />
<input type="hidden" name="hnd_wd_start_time2" />
<input type="hidden" name="hnd_wd_end_time2" />
<input type="hidden" name="hnd_time_status3" />
<input type="hidden" name="hnd_sc_start_time3" />
<input type="hidden" name="hnd_sc_end_time3" />
<input type="hidden" name="hnd_wd_start_time3" />
<input type="hidden" name="hnd_wd_end_time3" />
<input type="hidden" name="hnd_time_status4" />
<input type="hidden" name="hnd_sc_start_time4" />
<input type="hidden" name="hnd_sc_end_time4" />
<input type="hidden" name="hnd_wd_start_time4" />
<input type="hidden" name="hnd_wd_end_time4" />
<input type="hidden" name="hnd_time_status5" />
<input type="hidden" name="hnd_sc_start_time5" />
<input type="hidden" name="hnd_sc_end_time5" />
<input type="hidden" name="hnd_wd_start_time5" />
<input type="hidden" name="hnd_wd_end_time5" />
<input type="hidden" name="hnd_time_status6" />
<input type="hidden" name="hnd_sc_start_time6" />
<input type="hidden" name="hnd_sc_end_time6" />
<input type="hidden" name="hnd_wd_start_time6" />
<input type="hidden" name="hnd_wd_end_time6" />
<input type="hidden" name="hnd_time_status7" />
<input type="hidden" name="hnd_sc_start_time7" />
<input type="hidden" name="hnd_sc_end_time7" />
<input type="hidden" name="hnd_wd_start_time7" />
<input type="hidden" name="hnd_wd_end_time7" />
<input type="hidden" name="hnd_time_status8" />
<input type="hidden" name="hnd_sc_start_time8" />
<input type="hidden" name="hnd_sc_end_time8" />
<input type="hidden" name="hnd_wd_start_time8" />
<input type="hidden" name="hnd_wd_end_time8" />
<input type="hidden" name="hnd_time_status9" />
<input type="hidden" name="hnd_sc_start_time9" />
<input type="hidden" name="hnd_sc_end_time9" />
<input type="hidden" name="hnd_wd_start_time9" />
<input type="hidden" name="hnd_wd_end_time9" />
<input type="hidden" name="hnd_time_status10" />
<input type="hidden" name="hnd_sc_start_time10" />
<input type="hidden" name="hnd_sc_end_time10" />
<input type="hidden" name="hnd_wd_start_time10" />
<input type="hidden" name="hnd_wd_end_time10" />
<input type="hidden" name="hnd_time_status11" />
<input type="hidden" name="hnd_sc_start_time11" />
<input type="hidden" name="hnd_sc_end_time11" />
<input type="hidden" name="hnd_wd_start_time11" />
<input type="hidden" name="hnd_wd_end_time11" />
<input type="hidden" name="hnd_time_status12" />
<input type="hidden" name="hnd_sc_start_time12" />
<input type="hidden" name="hnd_sc_end_time12" />
<input type="hidden" name="hnd_wd_start_time12" />
<input type="hidden" name="hnd_wd_end_time12" />
<input type="hidden" name="hnd_time_status13" />
<input type="hidden" name="hnd_sc_start_time13" />
<input type="hidden" name="hnd_sc_end_time13" />
<input type="hidden" name="hnd_wd_start_time13" />
<input type="hidden" name="hnd_wd_end_time13" />
<input type="hidden" name="setdevnameflag" value="0" />
<input type="hidden" name="dev_mac_0" />
<input type="hidden" name="dev_mac_1" />
<input type="hidden" name="dev_mac_2" />
<input type="hidden" name="dev_mac_3" />
<input type="hidden" name="dev_mac_4" />
<input type="hidden" name="dev_mac_5" />
<input type="hidden" name="dev_mac_6" />
<input type="hidden" name="dev_mac_7" />
<input type="hidden" name="dev_mac_8" />
<input type="hidden" name="dev_mac_9" />
<input type="hidden" name="dev_mac_10" />
<input type="hidden" name="dev_mac_11" />
<input type="hidden" name="dev_mac_12" />
<input type="hidden" name="dev_mac_13" />
<input type="hidden" name="dev_mac_14" />
<input type="hidden" name="dev_mac_15" />
<input type="hidden" name="dev_mac_16" />
<input type="hidden" name="dev_mac_17" />
<input type="hidden" name="dev_mac_18" />
<input type="hidden" name="dev_mac_19" />
<input type="hidden" name="dev_mac_20" />
<input type="hidden" name="dev_mac_21" />
<input type="hidden" name="dev_mac_22" />
<input type="hidden" name="dev_mac_23" />
<input type="hidden" name="dev_mac_24" />
<input type="hidden" name="dev_mac_25" />
<input type="hidden" name="dev_mac_26" />
<input type="hidden" name="dev_mac_27" />
<input type="hidden" name="dev_mac_28" />
<input type="hidden" name="dev_mac_29" />
<input type="hidden" name="dev_mac_30" />
<input type="hidden" name="dev_mac_31" />
<input type="hidden" name="dev_name_0" />
<input type="hidden" name="dev_name_1" />
<input type="hidden" name="dev_name_2" />
<input type="hidden" name="dev_name_3" />
<input type="hidden" name="dev_name_4" />
<input type="hidden" name="dev_name_5" />
<input type="hidden" name="dev_name_6" />
<input type="hidden" name="dev_name_7" />
<input type="hidden" name="dev_name_8" />
<input type="hidden" name="dev_name_9" />
<input type="hidden" name="dev_name_10" />
<input type="hidden" name="dev_name_11" />
<input type="hidden" name="dev_name_12" />
<input type="hidden" name="dev_name_13" />
<input type="hidden" name="dev_name_14" />
<input type="hidden" name="dev_name_15" />
<input type="hidden" name="dev_name_16" />
<input type="hidden" name="dev_name_17" />
<input type="hidden" name="dev_name_18" />
<input type="hidden" name="dev_name_19" />
<input type="hidden" name="dev_name_20" />
<input type="hidden" name="dev_name_21" />
<input type="hidden" name="dev_name_22" />
<input type="hidden" name="dev_name_23" />
<input type="hidden" name="dev_name_24" />
<input type="hidden" name="dev_name_25" />
<input type="hidden" name="dev_name_26" />
<input type="hidden" name="dev_name_27" />
<input type="hidden" name="dev_name_28" />
<input type="hidden" name="dev_name_29" />
<input type="hidden" name="dev_name_30" />
<input type="hidden" name="dev_name_31" />
<input type="hidden" name="start" />
<input type="hidden" name="tmsss_enabled" />
<% web_include_file("Top.asp"); %>
<table class="table table-info">
<tbody>
<tr>
<td>
<!--	<script>draw_radio('tmsss_enabled', share.enabled, '1', "enable_disable_all(this.form,'1')" <% nvram_match("tmsss_enabled","1",", 0"); %>);</script>
<script>draw_radio('tmsss_enabled', share.disabled, '0', "enable_disable_all(this.form,'0')" <% nvram_match("tmsss_enabled","0",", 0"); %>);</script> -->
<script>draw_checkbox('_tmsss_enabled', pctrl.pcontrol, '1', "enable_disable_all(this.form,'1')" <% nvram_match("tmsss_enabled","1",", 1"); %>);</script>
</td>
</tr>
</tbody>
</table>
<script>draw_table(MAINFUN2,pctrl.tgdev);</script>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(pctrl.rsinet)</script></td>
<td>
<select name="dev_list" size="7" style="width:300px" onchange="select_dev(this)"></select>
</td>
</tr>
<tr>
<td>&nbsp;</td>
<td>
<script>draw_button("javascript:add_dev()", portsrv.add, 'adddev')</script>
<script>draw_button("javascript:remove_dev()", sbutton.remove, 'removedev')</script>
<script>draw_button("javascript:rename_dev()", pctrl.rename, 'renamedev')</script>
</td>
</tr>
</tbody>
</table>
<script>draw_table(MAINFUN2,filter.schedule);</script>
<table class="table table-info">
<tbody>
<tr>
<td><script>Capture(pctrl.bkinetac)</script></td>
<td>
<table>
<tbody>
<tr>
<td colspan="4">
<script>draw_radio('hnd_time_status', pctrl.nev, '0', 'set_block_value(this,12)', 0);</script>
<script>draw_radio('hnd_time_status', wlanadv.always, '1', 'set_block_value(this,12)');</script>
<script>draw_radio('hnd_time_status', pctrl.sptime, '2', 'set_block_value(this,12)');</script>
</td>
</tr>
<tr>
<td><script>Capture(pctrl.scnig)</script></td>
<td style="padding:0 5px">
<select id="hnd_sc_start_time_opts" style="display:none" readonly="readonly">
<% hnd_tod_get("sc_start_hour_12pm"); %>
</select>
<script>
(function(){
draw_select('hnd_sc_start_time', [], [], 'set_block_value(this,8)').width('110px');
var sel = document.getElementById('hnd_sc_start_time'),
tmp = document.getElementById('hnd_sc_start_time_opts'),
idx = tmp.selectedIndex;
while( tmp.options.length )
sel.appendChild(tmp.options[0]);
sel.selectedIndex = idx;
update_selected(sel);
tmp.parentElement.removeChild(tmp);
})();
</script>
</td>
<td><script>Capture(portforward.to)</script></td>
<td style="padding:0 5px">
<select id="hnd_sc_end_time_opts" style="display:none" readonly="readonly">
<% hnd_tod_get("sc_end_hour_12am"); %>
</select>
<script>
(function(){
draw_select('hnd_sc_end_time', [], [], 'set_block_value(this,9)').width('110px');
var sel = document.getElementById('hnd_sc_end_time'),
tmp = document.getElementById('hnd_sc_end_time_opts'),
idx = tmp.selectedIndex;
while( tmp.options.length )
sel.appendChild(tmp.options[0]);
sel.selectedIndex = idx;
update_selected(sel);
tmp.parentElement.removeChild(tmp);
})();
</script>
</td>
</tr>
<tr>
<td><script>Capture(pctrl.wd)</script></td>
<td style="padding:0 5px">
<select id="hnd_wd_start_time_opts" style="display:none" readonly="readonly">
<% hnd_tod_get("wd_start_hour_12pm"); %>
</select>
<script>
(function(){
draw_select('hnd_wd_start_time', [], [], 'set_block_value(this,10)').width('110px');
var sel = document.getElementById('hnd_wd_start_time'),
tmp = document.getElementById('hnd_wd_start_time_opts'),
idx = tmp.selectedIndex;
while( tmp.options.length )
sel.appendChild(tmp.options[0]);
sel.selectedIndex = idx;
update_selected(sel);
tmp.parentElement.removeChild(tmp);
})();
</script>
</td>
<td><script>Capture(portforward.to)</script></td>
<td style="padding:0 5px">
<select id="hnd_wd_end_time_opts" style="display:none" readonly="readonly">
<% hnd_tod_get("wd_end_hour_12am"); %>
</select>
<script>
(function(){
draw_select('hnd_wd_end_time', [], [], 'set_block_value(this,11)').width('110px');
var sel = document.getElementById('hnd_wd_end_time'),
tmp = document.getElementById('hnd_wd_end_time_opts'),
idx = tmp.selectedIndex;
while( tmp.options.length )
sel.appendChild(tmp.options[0]);
sel.selectedIndex = idx;
update_selected(sel);
tmp.parentElement.removeChild(tmp);
})();
</script>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<script>draw_table(MAINFUN2,pctrl.bkspsite);</script>
<table class="table table-info">
<tbody>
<tr>
<td>URL 1:&nbsp;<input class="num" size="36" maxlength="63" name="url0" onBlur="set_block_value(this,0)" />
</td>
</tr>
<tr>
<td>URL 2:&nbsp;<input class="num" size="36" maxlength="63" name="url1" onBlur="set_block_value(this,1)" />
</td>
</tr>
<tr>
<td>URL 3:&nbsp;<input class="num" size="36" maxlength="63" name="url2" onBlur="set_block_value(this,2)" />
</td>
</tr>
<tr>
<td>URL 4:&nbsp;<input class="num" size="36" maxlength="63" name="url3" onBlur="set_block_value(this,3)" />
</td>
</tr>
<tr>
<td>URL 5:&nbsp;<input class="num" size="36" maxlength="63" name="url4" onBlur="set_block_value(this,4)" />
</td>
</tr>
<tr>
<td>URL 6:&nbsp;<input class="num" size="36" maxlength="63" name="url5" onBlur="set_block_value(this,5)" />
</td>
</tr>
<tr>
<td>URL 7:&nbsp;<input class="num" size="36" maxlength="63" name="url6" onBlur="set_block_value(this,6)" />
</td>
</tr>
<tr>
<td>URL 8:&nbsp;<input class="num" size="36" maxlength="63" name="url7" onBlur="set_block_value(this,7)" />
</td>
</tr>
</tbody>
</table>
<% web_include_file("Bottom.asp"); %>
</FORM></BODY></HTML>
