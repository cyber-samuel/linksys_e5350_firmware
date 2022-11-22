<% web_include_file("copyright.asp"); %>
<HTML <% ui_position("dir", ""); %>>
<HEAD>
<% no_cache(); %>
<% charset(); %>
<% web_include_file("wizard/wizard_filelink.asp"); %>
<SCRIPT language="Javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capsec.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/share.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/help.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capapp.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capasg.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capsetup.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capwrt54g.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/capstatus.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript" src="/<% get_lang(); %>_lang_pack/layout.js"></SCRIPT>
<style>
p {
line-height: 17px;
margin: 0 0 18px;
}
em {
color: black;
}
ul, ol {
font-size: 13px;
font-size: 1.3rem;
margin-bottom: 18px;
}
ul {
list-style: none outside;
}
ol {
list-style: decimal;
}
ol, ul.disc {
margin-left: 30px;
}
li {
margin-bottom: 12px;
}
</style>
<SCRIPT language="javascript">
setFormActions({
'wiz.liceagree': 'javascript:goto_next()'
});
document.title = wiz.lice;
function goto_next()
{
showWait();
window.parent.document.getElementById("lice_ch").value="1";	
if ( close_session == "1" )
document.location.replace("/wizard/index.asp");
else
document.location.replace("/wizard/index.asp?session_id="+session_key);
}
</SCRIPT>
</HEAD>
<BODY onload="alignright('arRight')">
<form method="<% get_http_method(); %>" action="/apply.cgi" name="wz_lice">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<% web_include_file("wizard/wizard_Top.asp"); %>
<div id=arRight>
<div class="wiz-content-title"><script>Capture(wiz.liceagment)</script></div>
<div class="wiz-content-text"><script>Capture(wiz.licemsg1)</script></div>
<div style="height:300px; border: 1px solid #8e9ca7; padding:0px 20px; overflow-y: scroll; overflow-x: hidden;">
<p style="text-align: center;"><strong><script>Capture(wiz.licelinksys_products)</script></strong></p>
<p style="text-align: center;"><strong><script>Capture(wiz.licemsg2)</script></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg3)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg4)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg5)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg6)</script></p>
<p><strong><em><script>Capture(wiz.licemsg7)</script></em></strong></p>
<ul style="list-style-type: disc; padding-left: 40px;">
<li><script>Capture(wiz.licemsg8)</script></li>
<li><script>Capture(wiz.licemsg9)</script></li>
<li><script>Capture(wiz.licemsg10)</script></li>
<li><script>Capture(wiz.licemsg11)</script></li>
</ul>
<p style="text-align: justify;"><script>Capture(wiz.licemsg12)</script></p>
<p><strong><em><script>Capture(wiz.licemsg13)</script></em></strong></p>
<ul style="list-style-type: disc; padding-left: 40px;">
<li><script>Capture(wiz.licemsg14)</script></li>
<li><script>Capture(wiz.licemsg15)</script> </li>
<li><script>Capture(wiz.licemsg16)</script></li>
<li><script>Capture(wiz.licemsg17)</script></li>
<li><script>Capture(wiz.licemsg18)</script></li>
<li><script>Capture(wiz.licemsg19)</script></li>
</ul>
<p style="text-align: justify;"><script>Capture(wiz.licemsg20)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg21)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg22)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg23)</script></p> 
<p style="text-align: justify;"><script>Capture(wiz.licemsg24)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg25)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg26)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg27)</script></p>
<ul style="list-style-type: disc; padding-left: 40px;">
<li><script>Capture(wiz.licemsg28)</script></li>
<li><script>Capture(wiz.licemsg29)</script></li>
</ul>
<p><strong><em><script>Capture(wiz.licemsg30)</script></em></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg31)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg32)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg33)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg34)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg35)</script></p>
<ul style="list-style-type: disc; padding-left: 40px;">
<li><script>Capture(wiz.licemsg36)</script></li>
<li><script>Capture(wiz.licemsg37)</script></li>
<li><script>Capture(wiz.licemsg38)</script></li>
<li><script>Capture(wiz.licemsg39)</script>
<ol style="list-style-type: lower-alpha; padding-left: 40px;">
<li> <script>Capture(wiz.licemsg40)</script></li>
<li><script>Capture(wiz.licemsg41)</script></li>
<li><script>Capture(wiz.licemsg42)</script></li>
</ol>
<script>Capture(wiz.licemsg43)</script>
</li>
<li><script>Capture(wiz.licemsg44)</script></li>
</ul>
<p style="text-align: justify;"><script>Capture(wiz.licemsg45)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg46)</script></p>
<ol style="list-style-type: lower-roman; padding-left: 40px;">
<li><script>Capture(wiz.licemsg47)</script></li>
<li><script>Capture(wiz.licemsg48)</script></li>
<li><script>Capture(wiz.licemsg49)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg50)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg51)</script></p>
<p><strong><em><script>Capture(wiz.licemsg52)</script></em></strong></p>
<p><strong><script>Capture(wiz.licemsg53)</script></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg54)</script></p>
<p style="text-align: justify;"><strong><script>Capture(wiz.licemsg55)</script></strong></p>
<p style="text-align: justify;"><strong><script>Capture(wiz.licemsg56)</script></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg57)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg58)</script></p>
<p style="text-align: justify;"><strong><em><script>Capture(wiz.licemsg59)</script></em></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg60)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.licemsg61)</script></p></p>
<p style="text-align: justify;"><script>Capture(wiz.copyrightl);</script></p>
</div>
</div>
<% web_include_file("wizard/wizard_Bottom.asp"); %>
</FORM></BODY></HTML>
