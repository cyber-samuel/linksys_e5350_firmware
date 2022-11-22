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
window.parent.document.getElementById("lice_ch1").value="1";	
window.parent.document.getElementById("wizard_email_ck").value="1";	
if ( close_session == "1" )
document.location.replace("/wizard/set_email.asp");
else
document.location.replace("/wizard/set_email.asp?session_id="+session_key);
}
</SCRIPT>
</HEAD>
<BODY onload="alignright('arRight')">
<form method="<% get_http_method(); %>" action="/apply.cgi" name="PrivacyPolicy">
<input type="hidden" name="submit_button" />
<input type="hidden" name="change_action" />
<input type="hidden" name="submit_type" />
<% web_include_file("wizard/wizard_Top.asp"); %>
<div id=arRight>
<div class="wiz-content-title"><script>Capture(wiz.privacy)</script></div>
<div class="wiz-content-text"><script>Capture(wiz.privacy0)</script></div>
<div style="height:300px; border: 1px solid #8e9ca7; padding:0px 20px; overflow-y: scroll; overflow-x: hidden;">
<Br>
<p style="text-align: justify;"><script>Capture(wiz.privacy1)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy2)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy3)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy4)</script></p>
<p><strong><em><script>Capture(wiz.privacy5)</script></em></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy6)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy7)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy8)</script></p>
<p><strong><em><script>Capture(wiz.privacy9)</script></em></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy10)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy11)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy12)</script></p>
<ul style="list-style-type: disc; padding-left: 40px;">
<li><script>Capture(wiz.privacy13)</script></li>
<li><script>Capture(wiz.privacy14)</script></li>
<li><script>Capture(wiz.privacy15)</script></li>
<li><script>Capture(wiz.privacy16)</script></li>
<li><script>Capture(wiz.privacy17)</script></li>
<li><script>Capture(wiz.privacy18)</script></li>
</ul>
<p style="text-align: justify;"><script>Capture(wiz.privacy19)</script></p>
<p><strong><em><script>Capture(wiz.privacy20)</script></em></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy21)</script></p>
<ul style="list-style-type: disc; padding-left: 40px;">
<li><script>Capture(wiz.privacy22)</script></li>
<li><script>Capture(wiz.privacy23)</script></li>
<li><script>Capture(wiz.privacy24)</script></li>
<li><script>Capture(wiz.privacy25)</script></li>
<li><script>Capture(wiz.privacy26)</script></li>
<li><script>Capture(wiz.privacy27)</script></li>
<li><script>Capture(wiz.privacy28)</script></li>
<li><script>Capture(wiz.privacy29)</script></li>
<li><script>Capture(wiz.privacy30)</script></li>
<li><script>Capture(wiz.privacy31)</script></li>
<li><script>Capture(wiz.privacy32)</script></li>
<li><script>Capture(wiz.privacy33)</script></li>
<li><script>Capture(wiz.privacy34)</script></li>
<li><script>Capture(wiz.privacy35)</script></li>
<li><script>Capture(wiz.privacy36)</script></li>
<li><script>Capture(wiz.privacy37)</script></li>
<li><script>Capture(wiz.privacy38)</script></li>
<li><script>Capture(wiz.privacy39)</script></li>
<li><script>Capture(wiz.privacy40)</script></li>
<li><script>Capture(wiz.privacy41)</script></li>
</ul>
<p><strong><em><script>Capture(wiz.privacy42)</script></em></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy43)</script></p>
<ul style="list-style-type: disc; padding-left: 40px;">
<li><script>Capture(wiz.privacy44)</script></li>
<li><script>Capture(wiz.privacy45)</script></li>
<li><script>Capture(wiz.privacy46)</script></li>
<li><script>Capture(wiz.privacy47)</script></li>
<li><script>Capture(wiz.privacy48)</script></li>
<li><script>Capture(wiz.privacy49)</script></li>
</ul>
<p style="text-align: justify;"><script>Capture(wiz.privacy50)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy51)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy52)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy53)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy54)</script></p>
<p><strong><em><script>Capture(wiz.privacy55)</script></em></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy56)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy57)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy58)</script></p>
<p><strong><em><script>Capture(wiz.privacy59)</script></em></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy60)</script></p>
<p><strong><em><script>Capture(wiz.privacy61)</script></em></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy62)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy63)</script></p>
<p><strong><em><script>Capture(wiz.privacy64)</script></em></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy65)</script></p>
<ul style="list-style-type: disc; padding-left: 40px;">
<li><script>Capture(wiz.privacy66)</script></li>
<li><script>Capture(wiz.privacy67)</script></li>
<li><script>Capture(wiz.privacy68)</script></li>
</ul>
<p style="text-align: justify;"><script>Capture(wiz.privacy69)</script></p>
<ul style="list-style-type: disc; padding-left: 40px;">
<li><script>Capture(wiz.privacy70)</script></li>
<li><script>Capture(wiz.privacy71)</script></li>
<li><script>Capture(wiz.privacy72)</script></li>
<li><script>Capture(wiz.privacy73)</script></li>
</ul>
<p style="text-align: justify;"><script>Capture(wiz.privacy74)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy75)</script></p>
<p><strong><em><script>Capture(wiz.privacy76)</script></em></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy77)</script></p>
<p><strong><em><script>Capture(wiz.privacy78)</script></em></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy79)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy80)</script></p>
<ul style="list-style-type: disc; padding-left: 40px;">
<li><script>Capture(wiz.privacy81)</script></li>
<li><script>Capture(wiz.privacy82)</script></li>
<li><script>Capture(wiz.privacy83)</script></li>
<li><script>Capture(wiz.privacy84)</script></li>
<li><script>Capture(wiz.privacy85)</script></li>
<li><script>Capture(wiz.privacy86)</script></li>
<li><script>Capture(wiz.privacy87)</script></li>
<li><script>Capture(wiz.privacy88)</script></li>
</ul>
<p style="text-align: justify;"><script>Capture(wiz.privacy89)</script></p>
<ul style="list-style-type: disc; padding-left: 40px;">
<li><script>Capture(wiz.privacy90)</script></li>
<li><script>Capture(wiz.privacy91)</script></li>
<li><script>Capture(wiz.privacy92)</script></li>
</ul>
<p style="text-align: justify;"><script>Capture(wiz.privacy93)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy94)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy95)</script></p>
<p><strong><em><script>Capture(wiz.privacy96)</script></em></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy97)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy98)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy99)</script></p>
<p><strong><em><script>Capture(wiz.privacy100)</script></em></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy101)</script></p>
<p><strong><em><script>Capture(wiz.privacy102)</script></em></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy103)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy104)</script></p>
<p><strong><em><script>Capture(wiz.privacy105)</script></em></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy106)</script></p>
<p><strong><em><script>Capture(wiz.privacy107)</script></em></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy108)</script></p>
<p><strong><em><script>Capture(wiz.privacy109)</script></em></strong></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy110)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy111)</script></p>
<p style="text-align: justify;"><script>Capture(wiz.privacy112)</script></p>
</div>
</div>
<% web_include_file("wizard/wizard_Bottom.asp"); %>
</FORM></BODY></HTML>
