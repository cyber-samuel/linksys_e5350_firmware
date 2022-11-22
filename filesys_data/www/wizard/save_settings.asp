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
function init()
{
var url;
if ( close_session == "1" )
url="/wizard/ck_internet.asp";
else
url="/wizard/ck_internet.asp?session_id="+session_key;
document.location.href=url;
}
</script>	
</head>
<body onLoad="init();">
<div style="heigth:50px">&nbsp;</div>
<!-- <div style="font-size:30px;color:red;text-align:center"> Auto Detection success</div>-->
</body>
</html>
