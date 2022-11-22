<script>
var i , j,funw;
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
var close_session = "<% get_session_status(); %>";
document.write("<TABLE class=HEADER_TABLE cellspacing=0>");
document.write("<TR class=FUN_LINE><TD class=FUN_TITLE rowspan=4 colspan=2>"+Menu[SelectItemIdx][0][DMAIN]+"</TD>");
document.write("<TD class=PRODUCTNAME>");
document.write("<% get_firmware_title(); %>");
document.write("</TD><TD class=MODELNAME><% get_model_name(); %></TD></TR>");
document.write("<TR><TD colspan=2 class=FUN_LINE></TD></TR>");
document.write("<TR><TD colspan=2 class=NOSPACE cellspacing=0><TABLE style='width:100%'><TR>");
funw = parseInt(645/Menu.length);
for (i=0; i<Menu.length; i++)
{
if ( i== Menu.length-1 ) funw = funw + parseInt(645%Menu.length);
if(i < 4)
funw = funw - 10;
else
funw = funw + 20;
document.write("<TD class=");
if ( i == SelectItemIdx )
document.write("PIC_SELECT_FUN");
else
document.write("PIC_OPTION_FUN");
document.write("></TD>");
}
document.write("</TR><TR>");
for (i=0; i<Menu.length; i++)
{
if(i < 4)
funw = funw - 10;
else
funw = funw + 20;
<% support_invmatch("STORAGE_SUPPORT", "1", "/*"); %>
wi=["11%","11%","11%","11%","15%","15%","15%","11%"];
<% support_invmatch("STORAGE_SUPPORT", "1", "*/"); %>
<% support_match("STORAGE_SUPPORT", "1", "/*"); %>
wi=["15%","15%","14%","11%","14%","16%","15%"];
<% support_match("STORAGE_SUPPORT", "1", "*/"); %>
document.write("<TD width="+wi[i]+" class=");
if ( i == SelectItemIdx )
document.write("OPTION_FUN_SEL>");
else
document.write("OPTION_FUN>");
if ( close_session == "1" )
{
document.write("<A href="+Menu[i][0][DLINK] +">"+Menu[i][0][DMAIN]+"</A>");
}
else
{
document.write("<A href="+Menu[i][0][DLINK] + "?session_id=" + session_key +">"+Menu[i][0][DMAIN]+"</A>");
}
document.write("</TD>");
}
document.write("</TR></TABLE></TD></TR><TR><TD colspan=2><TABLE cellspacing=0><TR><TD class=SUBFUN><TABLE><TR>");
for(i=0; i<Menu[SelectItemIdx].length; i++)
{
document.write("<TD class=BLANKSPAN>");
if ( i != SelectSubItem )
{
document.write("<font class=small>");
if ( close_session == "1" )
{
document.write("<A href="+Menu[SelectItemIdx][i][DLINK]+">");
}
else
{
document.write("<A href="+Menu[SelectItemIdx][i][DLINK]+ "?session_id=" + session_key +">");
}
}
document.write(Menu[SelectItemIdx][i][DNAME]);
if ( i != SelectSubItem ) document.write("</A></FONT>");
document.write("</TD>");
if ( i != Menu[SelectItemIdx].length -1 ) document.write("<TD class=SUBFUN_DIV>|</TD>");
}
document.write("</TR></TABLE></TD></TR></TABLE></TD></TR>");
document.write("<TR><TD class=FUN_FRANG></TD><TD class=FUN_FRANG1></TD><TD class=FUN_FRANG2 colspan=2></TD></TR>");
document.write("</TABLE>");
</script>
