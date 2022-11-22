<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="/static/css/bootstrap.min.css" />
<link rel="stylesheet" href="/static/css/pages.css" />
<link rel="stylesheet" href="/static/css/app.css" />
<style>
body { display: initial }
.col-md-right { overflow: auto; float: none; height: auto }
</style>
<script type="text/javascript" src="/static/js/jquery.js"></script>
<script type="text/javascript" src="/static/js/respond.js"></script>
<script type="text/javascript" src="/common.js"></script>
<script language="javascript">
var MAINTITLE 	= 11; 
var MAINFUN2 	= 10;
/*Add for session key*/
var session_key = "<% nvram_get("session_key"); %>";
var close_session = "<% get_session_status(); %>";
/*End for session key*/
function page_load()
{
if ( close_session == "1" )
document.forms[0].action = "apply.cgi";
else
document.forms[0].action = "apply.cgi?session_id=" + session_key;
}
</script>
<style>
body{
background-color: white;
display: block;
}
.inputBlock{
padding-top: 30px;
}
.summary-line{
margin-bottom: 0;
margin-top: 0;
opacity: .1;
border: 1px solid #979797;
}
.summaryBlock{
padding-left: 30px;
}
.inputLabel {
font-family: Arial;
font-size: 14px;
font-weight: 400;
font-style: normal;
font-stretch: normal;
line-height: 1.43;
color: #8e8e8e;
}
.strong {
font-weight: 600;
}
</style>
