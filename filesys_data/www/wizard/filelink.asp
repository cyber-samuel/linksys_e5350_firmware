<script type="text/javascript">window.HANDLE_BLUR = false;</script>
<script type="text/javascript" src="bbs/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="bbs/js/main.js"></script>
<script type="text/javascript" src="bbs/js/app.js"></script>
<script type="text/javascript" src="bbs/js/jquery.reveal.js"></script>
<script type="text/javascript" src="bbs/js/jquery.placeholder.min.js"></script>
<script type="text/javascript" src="bbs/js/jQueryRotateCompressed.2.2.js"></script>
<script type="text/javascript" src="bbs/js/jquery.cookie.js"></script>
<script type="text/javascript" src="func.js"></script>
<script type="text/javascript" src="u-media.js"></script>
<script src="../common.js"></script>
<script src="../common_var_define.js"></script>
<script type="text/javascript" src="/load_lang.js"></script>
<script type="text/javascript">
$(document).ready(function(){
/* detect current user browser name and version */
var detect = (function(){
var ua = navigator.userAgent,
tmp, 
M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
if( /trident/i.test(M[1]) ){
tmp = /\brv[ :]+(\d+)/g.exec(ua) || [];
return {
name:		'IE',
version:	tmp[1] || ''
};
}
if( M[1] === 'Chrome' ){
tmp = ua.match(/\b(OPR|Edge)\/(\d+)/);
if( tmp != null ) return {
name:		tmp[1].replace('OPR', 'Opera'),
version:	tmp[2]
};
}
M = M[2] ? [M[1], M[2]]: [navigator.appName, navigator.appVersion, '-?'];
if((tmp= ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tmp[1]);
return {
name:		M[0],
version:	M[1]
};
})();
console.log(detect.name);
if( (detect.name || '').toLowerCase() != 'safari' ) return;
/* fix safari browser trigger save button and input blur will run save first issue */
$("[onblur]").each(function(){
var handler = $(this).prop("onblur");
$(this).removeProp("onblur");
$(this).blur(function(){
window.HANDLE_BLUR = true;
handler.apply(this, arguments);
window.HANDLE_BLUR = false;
});
/*cancel the blur and select event, those event will effect do multi-validation*/
this.focus = function(){};
this.select = function(){};
});
$(".wpr-layout-pageaction-button").each(function(){
var handler = $(this).prop("onclick");
$(this).removeProp("onclick");
$(this).click(function(){
if( window.HANDLE_BLUR ) return false;
handler.apply(this, arguments);
});
});
});
</script>
