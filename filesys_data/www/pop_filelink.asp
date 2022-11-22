<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="static/css/bootstrap.min.css" />
<link rel="stylesheet" href="static/css/pages.css" />
<link rel="stylesheet" href="static/css/app.css" />
<% ui_position("invmatch", "<!--"); %>
<link rel="stylesheet" type="text/css" href="static/css/rtl.css">
<% ui_position("invmatch", "-->"); %>
<style>
body { display: initial }
.col-md-right { overflow: auto; float: none; height: auto }
</style>
<script type="text/javascript" src="static/js/jquery.js"></script>
<script type="text/javascript" src="static/js/respond.js"></script>
<script type="text/javascript" src="common.js"></script>
<script language="javascript">
var MAINTITLE 	= 11; 
var MAINFUN2 	= 10;
/*Add for session key*/
var session_key = "<% nvram_get("session_key"); %>";
var close_session = "<% get_session_status(); %>";
/*End for session key*/
$(document).ready(function(){
var body = $('body');
body.removeAttr('bgColor');
});
</script>
<style>
body{
background-color: white;
display: block;
}
</style>