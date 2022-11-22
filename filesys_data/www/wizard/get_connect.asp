<!DOCTYPE html>
<html lang="en" class="gt-ie8">
<head>
<meta content=0 http-equiv=expires>
<meta content=no-cache http-equiv=cache-control>
<meta content=no-cache http-equiv=pragma>
<meta charset="utf-8" />
<title>Detection WAN</title>
<script type="text/javascript">
var flag="<% nvram_get("wizard_proto"); %>";
var close_session = "<% get_session_status(); %>";
var session_key="<% nvram_get("session_key");%>";
var wizard_wan_status="<% nvram_get("wizard_wan_status");%>";
function init()
{
var url;
if ( close_session == "1" )
{
if (wizard_wan_status == "CONNECTED")
url="/wizard/set_email.asp";
else
url="/wizard/connect_fail.asp";
}else
{
if (wizard_wan_status == "CONNECTED")
url="/wizard/set_email.asp?session_id="+session_key;
else
url="/wizard/connect_fail.asp?session_id="+session_key;
}
document.location.href=url;
}
</script>	
</head>
<body onLoad="init();">
<div style="heigth:50px">&nbsp;</div>
<!-- <div style="font-size:30px;color:red;text-align:center"> Auto Detection success</div>-->
</body>
</html>
