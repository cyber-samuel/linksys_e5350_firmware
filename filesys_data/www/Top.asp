<script>
function logout()
{
if(window.parent.document.forms[0].name !=  "firmware")
{
document.forms[0].action="login.cgi";
document.forms[0].submit_button.value="logout";
document.forms[0].submit();
}
else
{
if ( close_session == "1" )
window.location.href='Upgrade_logout.asp';
else
window.location.href='Upgrade_logout.asp?session_id=<% nvram_get("session_key"); %>';
}
}
</script>
<CENTER>
<div class="container nav-fixtop">
<div id="mobile-bar">
<a class="menu-button" id="menuButton" onclick="toggleLeftMenu()"></a>
<a class="logo"></a>
</div>
<div id="header">
<div class="row">
<div class="col-md-12 col-sm-12 col-xs-12">
<div style="height: 10px">&nbsp;</div>
<div class="text-right" style="height: 15px;">
<a class="Logout" href='javascript:logout()'><script>Capture(share.logout)</script></a>
<script>
(function(){
if( typeof Menu == 'undefined' )
return;
var help = Menu[SelectItemIdx][SelectSubItem][DHELP];
if( !help )
return;
if( close_session != "1" )
help += '?session_id=' + session_key;
document.write('<a data-toggle="modal" data-target="#helpModal" class="Logout Help" href="javascript:showDialogHelp(\'' + help + '\')">' + share.help + '</a>');
})();
(function(){
if( !document.getElementById('PageHelpBody') )
return;
document.write('<a data-toggle="modal" data-target="#helpModal" class="Logout Help" href="javascript:showDialogHelp()">' + share.help + '</a>');
})();
</script>
<!--<a class="Logout">Log Out</a> <a data-toggle="modal" data-target="#helpModal" class="Logout Help">Help</a>-->
</div>
<div style="height: 10px">&nbsp;</div>
</div>
<div class="col-md-12 col-sm-12 col-xs-12" style="height:20px">
<p class="linksys-Version"><script>Capture(share.firmwarever)</script>: <% get_firmware_version(); %></p>
</div>
<div class="col-md-3 col-sm-4 col-xs-6" style="height:22px">
<a href="http://www.linksys.com/" target="_newtab">
<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAJEAAAAUCAYAAACNpd9IAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA+xpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYxIDY0LjE0MDk0OSwgMjAxMC8xMi8wNy0xMDo1NzowMSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ1dWlkOjVEMjA4OTI0OTNCRkRCMTE5MTRBODU5MEQzMTUwOEM4IiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOkI4M0Y4REU0RjMzNDExRTI4RkQ1RTE1MDE4MDM0OTQ1IiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOkI4M0Y4REUzRjMzNDExRTI4RkQ1RTE1MDE4MDM0OTQ1IiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIElsbHVzdHJhdG9yIENTNSI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjA1ODAxMTc0MDcyMDY4MTE4MDgzOTE0NTkxNTU3Qjc3IiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjA1ODAxMTc0MDcyMDY4MTE4MDgzOTE0NTkxNTU3Qjc3Ii8+IDxkYzp0aXRsZT4gPHJkZjpBbHQ+IDxyZGY6bGkgeG1sOmxhbmc9IngtZGVmYXVsdCI+TE9HT19MaW5rc3lzX0ZpbmFsPC9yZGY6bGk+IDwvcmRmOkFsdD4gPC9kYzp0aXRsZT4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz6hdM0iAAADIUlEQVR42uRai3GjMBDFmRSgDo4S7AoCHcQdiA7sCgIVMKkAXEHSgekAd3DuwHTgk5JVToNZfZDE525nNE4wLIv09r1d4eg+bEnkwZif84Dv3OAcbi0bxPJ+fTtbXEvvuP1mYwvn5Wzc7n6M+4oV/hLD2GNF3ARGdfdnCfjja9Q+Rcs1vmhnsXghjQOIfVTI1xc2dpvN5sInjv39xgbxdW/m98o+CuTryjCRsNgz+OTJRD1P2wnifo8WzETCbqZAGsNEmgz9YUNFtjsxkcE8lJr4D6rrFN87MZEcw5KZSBgJxUjALFiG1mykjCk6+P818HMekeMHLKk5sIEZ+yaz20voBXqO1mECSHu2qI0H8BCQAAwYNbtPNhDDkNQdHUK5SrLG5bJAQMFZZYccH4prL4GfIAlycoj7opOApclZ36iLnEGR2Sr8l4jv3KVwt5izVid9cN6r4XnaNXC1pcoZz5ROUWzSkQsUQ5GJSWPGMvg487NnyPE3iF9m0geGYPHnUwe8VDk7fVX93wtOECBxCagtALRV+BMAqi3jJCNZu+PyhXRrKlnjwEkVHWJmeP9fI+O+QjeplYAlyFkiFl6zJ1OZyJnGz83keQN0OWfBLJayVpnImOTnw3Pc5cO2w5JBZAskZKGoBkCm2wchWvxWxZye/NAAcZeravGB9ncPHcFfo31GChTH1UIujDdUsfoOnrtwrKOE5Nee4z7IbLSGfSKxgKkGSB+KSUyRQl1sHSSGcQhfn4rC39Zixf1yxTMLK7D6SvKTAdAanwmwGjmzbM/RFtxAFmnoZBjTbmtkrZ0iiXUYWQUTSRnVSUzgWxarKYA0Mu7CVsamtFWBSACJjf0YnTeQxUr3rmomaxQAm92eFQXfWJ8Xacs9JJgyiJHagpBdx4HEa6gEKxoHXnuIzcrYIWwy9QJD90nmAJFLNqaeC7ggQOJxKl7AUvB77CUERTYBl2wlkiz/r5wpOo+x12KySKFzC80ezQqnvZNLgtWDSGq9swAg3AYGUuPjVwkz2LvM0P8EiDwAqdYAqfX8e6YOOq79yqaZNyZZ/yXvHwEGABsLnGPV1hUCAAAAAElFTkSuQmCC" class="linksyslogo" />
</a>
</div>
<div class="col-md-9 col-sm-8 col-xs-6" style="height:22px">
<p class="linksys-Name"><% get_wifi_mode(); %> Wi-Fi Router<span class="linksys-ModelName"><% get_model_name(); %></span></p>
</div>
<div class="col-md-12 col-sm-12 col-xs-12">
<div style="height: 15px">&nbsp;</div>
</div>
</div>
</div>
<div class="row first-Menu" style="height:40px">
<!-- Header Nav -->
<script>
(function(){
var i,
sel = '',
link = '',
text = '';
for( i = 0 ; i < Menu.length ; i++ )
{
sel = '';
link = Menu[i][0][DLINK];
text = Menu[i][0][DMAIN];
if ( i == SelectItemIdx )
sel = 'first-Menu-Sel';
if( close_session != "1" )
link += '?session_id=' + session_key;
<% support_invmatch("STORAGE_SUPPORT", "1", "/*"); %>
wi=["10%","10%","10%","10%","15%","20%","15%","10%"];
<% support_invmatch("STORAGE_SUPPORT", "1", "*/"); %>
<% support_match("STORAGE_SUPPORT", "1", "/*"); %>
wi=["15%","15%","14%","11%","14%","16%","15%"];
<% support_match("STORAGE_SUPPORT", "1", "*/"); %>
document.write('<A class="first-Menu-No-Sel col-md-2dot4 ' + sel + '" href="' + link + '"><span>' + text + '</span></A>');
}
})();
</script>
<!-- End Header Nav -->
</div>
</div>
<div class="container content-t">
<div class="row content-color">
<div class="col-md-left" id="leftarea">
<div id="leftMenu" class="left-menu" style="background-color: rgb(165, 165, 165); height: 782px;">
<!-- Left Nav -->
<ul class="main-menu">
<script>
(function(){
var sel = '',
link = '',
text = '';
for( i = 0 ; i < Menu.length ; i++ )
{
sel = '';
link = Menu[i][0][DLINK];
text = Menu[i][0][DMAIN];
if ( i == SelectItemIdx )
sel = 'v-link-active';
if( close_session != "1" )
link += '?session_id=' + session_key;
document.write('<li><a href="' + link + '" class="' + sel + '">' + text + '</a></li>');
}
})();
</script>
</ul>
<div>
<script>
(function(){
var sel = '',
link = '',
text = '';
for( i = 0 ; i < Menu[SelectItemIdx].length ; i++ )
{
sel = i == SelectSubGrup;
link = Menu[SelectItemIdx][i][DLINK];
if( close_session != "1" )
link += '?session_id=' + session_key;
if( Menu[SelectItemIdx][i].length == 5 )
{
document.write('\
<a class="top-menu-link ' + (sel ? 'top-menu-link-active' : '') + '" href="' + link + '">\
<span class="left-menu-tri"></span>\
<nobr>&nbsp;' + Menu[SelectItemIdx][i][DSUBT] + '</nobr>\
</a>\
');
}
if( i != SelectSubGrup )
continue;
document.write('<div class="submenu-area">');
for( j = i ; j < Menu[SelectItemIdx].length ; j++ )
{
if( j > i && Menu[SelectItemIdx][j].length == 5 )
break;
sel = '';
link = Menu[SelectItemIdx][j][DLINK];
text = Menu[SelectItemIdx][j][DNAME];
if ( j == SelectSubItem )
sel = 'submenu-selected';
if( close_session != "1" )
link += '?session_id=' + session_key;
document.write('\
<div class="submenu-td">\
<div class="submenu-link">\
<a class="submenu-unselected ' + sel + '" href="' + link + '">\
<span width="12px"></span>' + text + '\
</a>\
</div>\
</div>\
');
}
document.write('</div>');
}
})();
</script>
</div>
<!-- End Left Nav -->
</div>
</div>
<script>
if( Menu[SelectItemIdx][SelectSubGrup].length != 5 )
document.getElementById('leftarea').style.display = 'none';
</script>
<div style="overflow-y:auto; height:100%">
<div class="col-md-right expand-transition" id="rightContent">
<div class="alert alert-info" id="alertArea" style="display:none">
<a class="close" onclick="javascript:hideAlert()">&#215;</a>
<h4>&nbsp;</h4>
<p>&nbsp;</p>
</div>
<div class="TitleofContent" id="rightContentTitle"><script>Capture(Menu[SelectItemIdx][SelectSubItem][DNAME])
</script></div>
<script>
if( Menu[SelectItemIdx][SelectSubItem][DLINK] == 'Quick_Start.asp' )
document.getElementById('rightContentTitle').style.display = 'none';
</script>
<div class="right-content">
