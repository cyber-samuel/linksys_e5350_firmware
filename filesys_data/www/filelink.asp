<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="static/css/bootstrap.min.css" />
<link rel="stylesheet" href="static/css/pages.css" />
<link rel="stylesheet" href="static/css/style.min.css" />
<link rel="stylesheet" href="static/css/app.css" />
<% ui_position("invmatch", "<!--"); %>
<link rel="stylesheet" type="text/css" href="static/css/rtl.css">
<% ui_position("invmatch", "-->"); %>
<script type="text/javascript" src="static/js/jquery.js"></script>
<script type="text/javascript" src="static/js/respond.js"></script>
<script type="text/javascript" src="common.js"></script>
<SCRIPT language="Javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capsec.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/share.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/help.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capapp.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capasg.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capsetup.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capstatus.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capwrt54g.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/capadmin.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/timezone.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/layout.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/storage.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="<% get_lang(); %>_lang_pack/ddns.js"></SCRIPT>
<script language="javascript">
/*********1*********2*********3*********4*********5
**************************************************/
var MAINTITLE 	= 11; 
var MAINFUN2 	= 10; 
var MAINFUN 	= 0; 
var SUBFUN 	= 1;
var ISHR 	= 2; 
var ISHRS 	= 3; 
var ISBLANK 	= 4; 
var ISTAIL 	= 5;
var ISHELP_TAIL = 6; 
var ISHELP_LINK = 7;
var ISHELP      = 8;
var ISHELP2      = 9;
var SelectItemIdx = 0;
var SelectSubGrup = 0;
var SelectSubItem = 0;
var DNAME = 0; 
var DLINK = 1; 
var DHELP = 2; 
var DMAIN = 3;
var DSUBT = 4;
var WFUN = 645; // fun width
var SFUN = 400;
/*Add for session key*/
var session_key = "<% nvram_get("session_key"); %>";
var close_session = "<% get_session_status(); %>";
var wan_proto = "<% nvram_get("wan_proto"); %>";
/*End for session key*/
if(wan_proto != "auto" && wan_proto != "wbridge")
{
var lang = '<% get_lang(); %>',
Menu = [
[
[ share.router,          'index.asp',              lang + '_help/Status_Router.asp', bmenu.sysstatus, bmenu.statu ]
,[ statopmenu.localnet,  'Status_Lan.asp',         lang + '_help/Status_Local_Network.asp' ]
,[ bmenu.wirelessnet,    'Status_Wireless.asp',    lang + '_help/Status_Wireless_Network.asp' ]
,[ newui.ports,          'Status_Ports.asp',       lang + '_help/Status_Ports.asp' ]
<% support_invmatch("PERFORMANCE_SUPPORT", "1", "/*"); %>
,[ 'System Performance', 'Status_Performance.asp', '' ]
<% support_invmatch("PERFORMANCE_SUPPORT", "1", "*/"); %>
],
[
[ topmenu.lansetup,         'Lan_Setup.asp',         lang + '_help/Lan_Setup.asp', bmenu.setup, share.conntivity ]
,[ topmenu.wansetup,         'Wan_Setup.asp',         lang + '_help/Wan_Setup.asp', bmenu.configuration ]
,[ topmenu.vlansetup,         'vlan.asp',                lang + '_help/VLAN_Setup.asp' ]
<% support_invmatch("IPV6_SUPPORT", "1", "/*"); %>
,[ topmenu.ipv6setup,         'index_ipv6.asp',          lang + '_help/IPv6_Setup.asp' ]
<% support_invmatch("IPV6_SUPPORT", "1", "*/"); %>
,[ topmenu.macaddrclone,      'WanMAC.asp',              lang + '_help/MAC_Address_Clone.asp' ]
,[ topmenu.advrouting,        'Routing.asp',             lang + '_help/Advanced_Routing.asp' ]
<% support_invmatch("HSIAB_SUPPORT", "1", "/*"); %>
,[ 'Hot Spot',                'HotSpot_Admin.asp',       '' ]
<% support_invmatch("HSIAB_SUPPORT", "1", "*/"); %>
,[ wlantopmenu.basicset,      'Wireless_Manual.asp',      lang + '_help/Basic_Wireless_Settings.asp', '', share.wifi ]
,[ wlantopmenu.wps,           'Wireless_WSC.asp',         lang + '_help/Wireless_WSC.asp' ]
,[ wlantopmenu.security,      'WL_WPATable.asp',         lang + '_help/Wireless_Security.asp' ]
,[ newui.gacs,                'Guest_Access.asp',        lang + '_help/Guest_Access.asp' ]
,[ wlantopmenu.macfilter,     'Wireless_MAC.asp',        lang + '_help/Wireless_MAC_Filter.asp' ]
,[ wlantopmenu.beamforming,	'WL_Beamforming.asp',	lang + '_help/Wireless_Beamforming.asp' ]
<% support_invmatch("STORAGE_SUPPORT", "1", "/*"); %>
,[ FUNST.Disk,                'Disk_Management.asp',     lang + '_help/Disk.asp', '', share.extstorage ]
<% support_invmatch("MEDIA_SERVER_SUPPORT", "1", "/*"); %>
,[ FUNST.MS,                  'Media_Server.asp',        lang + '_help/Media_Server.asp' ]
<% support_invmatch("MEDIA_SERVER_SUPPORT", "1", "*/"); %>
<% support_invmatch("FTP_SUPPORT", "1", "/*"); %>
,[ FUNST.FTP,                 'FTP_Server.asp',          lang + '_help/FTP_Server.asp' ]
<% support_invmatch("FTP_SUPPORT", "1", "*/"); %>
,[ bmenu.admin,               'NAS_Administration.asp',  lang + '_help/Storage_Administration.asp' ]
<% support_invmatch("STORAGE_SUPPORT", "1", "*/"); %>
,[ share.firewall,            'Firewall.asp',            lang + '_help/Firewall.asp',  '', bmenu.security ]
,[ share.dmz,                 'DMZ.asp',                 lang + '_help/DMZ.asp' ]
,[ share.ddns,                'DDNS.asp',                lang + '_help/DDNS.asp' ]
,[ secleftmenu.vpnpass,       'VPN.asp',                 lang + '_help/VPN.asp' ]
<% support_invmatch("UPNP_FORWARD_SUPPORT", "1", "/*"); %>
,[ 'UPnP Forward',            'Forward_UPnP.asp',        '' ]
<% support_invmatch("UPNP_FORWARD_SUPPORT", "1", "*/"); %>
<% support_invmatch("IPV6_SUPPORT", "1", "/*"); %>
,[ apptopmenu.ipv6_firewall,  'IPv6_Firewall.asp',       lang + '_help/IPv6_Firewall.asp' ]
<% support_invmatch("IPV6_SUPPORT", "1", "*/"); %>
<% support_invmatch("HW_QOS_SUPPORT", "1", "/*"); %>
,[ trigger2.qos,              'QoS.asp',                 lang + '_help/QoS.asp' ]
<% support_invmatch("HW_QOS_SUPPORT", "1", "*/"); %>
<% support_invmatch("SINGLE_FORWARD_SUPPORT", "1", "/*"); %>
,[ apptopmenu.singleport,     'SingleForward.asp',       lang + '_help/Single_Port_Forwarding.asp' ]
<% support_invmatch("SINGLE_FORWARD_SUPPORT", "1", "*/"); %>
,[ apptopmenu.portrange,      'Forward.asp',             lang + '_help/Port_Range_Forwarding.asp' ]
<% support_invmatch("PORT_TRIGGER_SUPPORT", "1", "/*"); %>
,[ trigger2.ptrigger,         'Triggering.asp',          lang + '_help/Port_Range_Triggering.asp' ]
<% support_invmatch("PORT_TRIGGER_SUPPORT", "1", "*/"); %>
,[ adtopmenu.lang,            'language.asp',    lang + '_help/Language.asp', '',bmenu.admin ]
,[ adtopmenu.passwd,            'admin_password.asp',    lang + '_help/admin_password.asp' ]
,[ share.timezone,            'time_setting.asp',    lang + '_help/time_setting.asp' ]
,[ adtopmenu.manage,          'remote_Management.asp',    lang + '_help/Management.asp' ]
,[ adtopmenu.Gateway,         'Gateway_Function.asp',    lang + '_help/Gateway_Function.asp' ]
,[ adtopmenu.backup,          'admin_backup.asp',    lang + '_help/admin_backup.asp' ]
,[ adtopmenu.facdef,          'Factory_Defaults.asp',    lang + '_help/Factory_Defaults.asp' ]
,[ adtopmenu.upgarde,         'Upgrade.asp',             '' ]
],
[
[ pctrl.pcontrol,   'PC_Filter.asp',    lang + '_help/Internet_Access_Policy.asp', pctrl.pcontrol, pctrl.pcontrol ]
],
[
[ adtopmenu.log,    'Log.asp',          lang + '_help/Log.asp',	bmenu.tublshoting, bmenu.tublshoting ]
,[ adtopmenu.diag,  'Diagnostics.asp',  lang + '_help/Diagnostics.asp' ]
]
];
}
else if(wan_proto == 'auto')
{
var lang = '<% get_lang(); %>',
Menu = [
[
[ share.router,          'index.asp',              lang + '_help/Status_Router.asp', bmenu.sysstatus, bmenu.statu ]
,[ statopmenu.localnet,  'Status_Lan.asp',         lang + '_help/Status_Local_Network.asp' ]
,[ bmenu.wirelessnet,    'Status_Wireless.asp',    lang + '_help/Status_Wireless_Network.asp' ]
,[ newui.ports,          'Status_Ports.asp',       lang + '_help/Status_Ports.asp' ]
<% support_invmatch("PERFORMANCE_SUPPORT", "1", "/*"); %>
,[ 'System Performance', 'Status_Performance.asp', '' ]
<% support_invmatch("PERFORMANCE_SUPPORT", "1", "*/"); %>
],
[
[ topmenu.wansetup,         'Wan_Setup.asp',         lang + '_help/Wan_Setup.asp', bmenu.configuration, share.conntivity ]
<% support_invmatch("HSIAB_SUPPORT", "1", "/*"); %>
,[ 'Hot Spot',                'HotSpot_Admin.asp',       '' ]
<% support_invmatch("HSIAB_SUPPORT", "1", "*/"); %>
,[ wlantopmenu.basicset,      'Wireless_Manual.asp',      lang + '_help/Basic_Wireless_Settings.asp', '', share.wifi ]
,[ wlantopmenu.wps,           'Wireless_WSC.asp',         lang + '_help/Wireless_WSC.asp' ]
,[ wlantopmenu.security,      'WL_WPATable.asp',         lang + '_help/Wireless_Security.asp' ]
,[ newui.gacs,                'Guest_Access.asp',        lang + '_help/Guest_Access.asp' ]
,[ wlantopmenu.macfilter,     'Wireless_MAC.asp',        lang + '_help/Wireless_MAC_Filter.asp' ]
,[ wlantopmenu.beamforming,     'WL_Beamforming.asp',   lang + '_help/Wireless_Beamforming.asp' ]
<% support_invmatch("STORAGE_SUPPORT", "1", "/*"); %>
,[ FUNST.Disk,                'Disk_Management.asp',     lang + '_help/Disk.asp', '', share.extstorage ]
<% support_invmatch("MEDIA_SERVER_SUPPORT", "1", "/*"); %>
,[ FUNST.MS,                  'Media_Server.asp',        lang + '_help/Media_Server.asp' ]
<% support_invmatch("MEDIA_SERVER_SUPPORT", "1", "*/"); %>
<% support_invmatch("FTP_SUPPORT", "1", "/*"); %>
,[ FUNST.FTP,                 'FTP_Server.asp',          lang + '_help/FTP_Server.asp' ]
<% support_invmatch("FTP_SUPPORT", "1", "*/"); %>
,[ bmenu.admin,               'NAS_Administration.asp',  lang + '_help/Storage_Administration.asp' ]
<% support_invmatch("STORAGE_SUPPORT", "1", "*/"); %>
,[ adtopmenu.lang,            'language.asp',    lang + '_help/Language.asp', '',bmenu.admin ]
,[ adtopmenu.passwd,            'admin_password.asp',    lang + '_help/admin_password.asp' ]
,[ share.timezone,            'time_setting.asp',    lang + '_help/time_setting.asp' ]
,[ adtopmenu.manage,          'remote_Management.asp',    lang + '_help/Management.asp' ]
,[ adtopmenu.Gateway,         'Gateway_Function.asp',    lang + '_help/Gateway_Function.asp' ]
,[ adtopmenu.backup,          'admin_backup.asp',    lang + '_help/admin_backup.asp' ]
,[ adtopmenu.facdef,          'Factory_Defaults.asp',    lang + '_help/Factory_Defaults.asp' ]
,[ adtopmenu.upgarde,         'Upgrade.asp',             '' ]
],
[
[ adtopmenu.diag,  'Diagnostics.asp',  lang + '_help/Diagnostics.asp' , bmenu.tublshoting, bmenu.tublshoting]
]
];
}
else if(wan_proto == 'wbridge')
{
var lang = '<% get_lang(); %>',
Menu = [
[
[ share.router,          'index.asp',              lang + '_help/Status_Router.asp', bmenu.sysstatus, bmenu.statu ]
,[ statopmenu.localnet,  'Status_Lan.asp',         lang + '_help/Status_Local_Network.asp' ]
,[ bmenu.wirelessnet,    'Status_Wireless.asp',    lang + '_help/Status_Wireless_Network.asp' ]
,[ newui.ports,          'Status_Ports.asp',       lang + '_help/Status_Ports.asp' ]
<% support_invmatch("PERFORMANCE_SUPPORT", "1", "/*"); %>
,[ 'System Performance', 'Status_Performance.asp', '' ]
<% support_invmatch("PERFORMANCE_SUPPORT", "1", "*/"); %>
],
[
[ topmenu.wansetup,         'Wan_Setup.asp',         lang + '_help/Wan_Setup.asp', bmenu.configuration, share.conntivity ]
,[ adtopmenu.lang,            'language.asp',    lang + '_help/Language.asp', '',bmenu.admin ]
,[ adtopmenu.passwd,            'admin_password.asp',    lang + '_help/admin_password.asp' ]
,[ share.timezone,            'time_setting.asp',    lang + '_help/time_setting.asp' ]
,[ adtopmenu.manage,          'remote_Management.asp',    lang + '_help/Management.asp' ]
,[ adtopmenu.Gateway,         'Gateway_Function.asp',    lang + '_help/Gateway_Function.asp' ]
,[ adtopmenu.backup,          'admin_backup.asp',    lang + '_help/admin_backup.asp' ]
,[ adtopmenu.facdef,          'Factory_Defaults.asp',    lang + '_help/Factory_Defaults.asp' ]
,[ adtopmenu.upgarde,         'Upgrade.asp',             '' ]
],
[
[ adtopmenu.diag,  'Diagnostics.asp',  lang + '_help/Diagnostics.asp' , bmenu.tublshoting, bmenu.tublshoting]
]
];
}
function getpos(surl)
{
var i,j,g;
<% support_invmatch("STORAGE_SUPPORT", "1", "/*"); %>
if(surl == "Claim_Disk.asp")
{
surl = "Disk_Management.asp";
}
<% support_invmatch("STORAGE_SUPPORT", "1", "*/"); %>
if((surl == "PC_settings.asp")||(surl == "PCAR.asp")||(surl == "Filters.asp"))
{
surl = "PC_Filter.asp";
}
for( i = 0 ; i < Menu.length ; i++ )
{
for ( j = 0 ; j < Menu[i].length ; j++ )
{
if( typeof Menu[i][j][DSUBT] != 'undefined' )
g = j;
if ( surl == Menu[i][j][DLINK] )
{
SelectItemIdx = i;
SelectSubGrup = g;
SelectSubItem = j;
break;
}
}	
}
if ( SelectItemIdx == -1 &&  surl == "/" )
{
SelectItemIdx = 0 ;
SelectSubGrup = 0 ;
SelectSubItem = 0 ;
}
}
var NOWPATH = document.location.pathname.substring(1,document.location.pathname.length);
var temp_path = "";
var num = NOWPATH.indexOf(";");
if (num > 0)
{
for (var i = 0; i < num; i++)
{
temp_path += NOWPATH.charAt(i); 
}
NOWPATH = temp_path;
}
if ( NOWPATH == "apply.cgi" ) NOWPATH = "<% get_web_page_name(); %>" ;
if ( NOWPATH == "storage/apply.cgi" ) NOWPATH = "<% get_web_page_name(); %>" ;
if(NOWPATH == "wps_connect_result.asp") NOWPATH = "Wireless_WSC.asp";
if(NOWPATH == "wps_search_device.asp") NOWPATH = "Wireless_WSC.asp";
getpos(NOWPATH);
</script>
<script type="text/javascript">
/* this SCRIPT block is KK add */
function showDialogHelp(link){
var title = Menu[SelectItemIdx][SelectSubItem][DNAME],
body = '<iframe id="helpIframe" src="' + link + '" sandbox="allow-same-origin allow-scripts allow-popups allow-forms" width="100%" height="auto" frameborder="0" scrolling="no" onload="resizeIframe(this)"></iframe>';
addClassName(document.body,'modal-open');
document.getElementById('helpModal').style.display = 'block';
if( typeof link == 'undefined' )
{
var t = document.getElementById('PageHelpTitle');
if( t )
title = t.innerHTML;
var b = document.getElementById('PageHelpBody');
if( !b ) return;
body = b.innerHTML;
}
document.getElementById('helpModalTitle').innerHTML = title;
document.getElementById('helpModalBody').innerHTML = body;
}
function hideDialogHelp(){
delClassName(document.body,'modal-open');
document.getElementById('helpModal').style.display = 'none';
}
function toggleLeftMenu(){
$('#leftMenu').toggleClass('open');
}
function getBrowserSize(){
var o = {
width:  0,
height: 0
};
if( typeof( window.innerWidth ) == 'number' ) {
o.width = window.innerWidth;
o.height = window.innerHeight;
} else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
o.width = document.documentElement.clientWidth;
o.height = document.documentElement.clientHeight;
} else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
o.width = document.body.clientWidth;
o.height = document.body.clientHeight;
}
return o;
}
function resizeContent(){
document.getElementById('rightContent').style.height = (getBrowserSize().height - ($('.nav-fixtop').height() + $('.footer-content').height())) + 'px';
}
$(document).ready(resizeContent);
$(window).resize(resizeContent);
</script>
