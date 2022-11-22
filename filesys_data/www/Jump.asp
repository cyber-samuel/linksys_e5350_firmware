<!--This html is used to add session key for index.asp when user login to DUT from the Router_Login.asp-->
<html>
<body>
<script type="text/javascript">
var close_session = "<% get_session_status(); %>";
if ( close_session == "1" )
{
document.location.href = "index.asp";	
}
else
{
document.location.href = "index.asp?session_id=<% nvram_get("session_key"); %>";
}
</script>
</body>
</html>
