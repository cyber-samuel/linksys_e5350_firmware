<script>
(function(){
if( !hasFormActions() ) return;
var text = '';
document.write('<div class="form-actions">');
for( var x in window.formBtns )
{
if( !window.formBtns.hasOwnProperty(x) ) continue;
if( !window.formBtns[x] ) continue;
if( !window.formBtns[x].length ) window.formBtns[x] = '';
if( typeof sbutton[x.toLowerCase()] != 'undefined' )
text = sbutton[x.toLowerCase()];
else if( typeof eval('share.bridge') == 'undefined' )
text = eval('share.bridge');
else
text = x;
draw_button(window.formBtns[x], text);
}
document.write('</div>');
}());
</script>
</div>
</div>
</div>
</div>
<div class="container footer-content" id="footer">
<div class="row copyright">
<div class="col-md-12">
<p><script>Capture(wiz.copyright)</script></p>
</div>
</div>
</div>
<div class="modal" role="dialog" id="popModal" style="display:none;">
<div class="modal-dialog" role="document" id="popModalDialog">
<div class="modal-content" id="popModalContent">
<iframe id="popIframe" src="" sandbox="allow-same-origin allow-scripts allow-popups allow-forms" width="100%" height="auto" frameborder="0" scrolling="no" onload=""></iframe>
</div>
</div>
</div>
<div class="modal" role="dialog" id="wizardModal" style="display:none;">
<div class="modal-dialog" role="document" id="wizardModalDialog">
<div class="modal-content" id="wizardModalContent">
<iframe id="wizardIframe" src="" sandbox="allow-same-origin allow-scripts allow-popups allow-forms" width="100%" height="auto" frameborder="0" scrolling="no" onload=""></iframe>
</div>
</div>
</div>
<div>
<div class="modal fade in" role="diglog" id="helpModal">
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<button class="close" data-dismiss="modal" type="button" onclick="hideDialogHelp()">&#215;</button>
<h3 id="helpModalTitle"><script>Capture(share.help)</script></h3>
</div>
<div class="modal-body" id="helpModalBody">
<iframe id="helpIframe" src="" width="100%" height="auto" frameborder="0" scrolling="no" onload=""></iframe>
<!--<p>The System Information page shows basic information such as the MAC address, software version, and the time that has elapsed since the last restart etc.</p>-->
</div>
<div class="modal-footer">
<button type="button" data-dismiss="modal" class="btn" onclick="hideDialogHelp()"><script>Capture(sbutton.close)</script></button>
</div>
</div>
</div>
</div>
</div>
<div id="waitBox" style="display: none;">
<div class="modal" role="diglog" _v-f353fd1c="">
<div class="modal-dialog modal-sm">
<div class="modal-content">
<div class="loadingImg" _v-f353fd1c="">
<div class="row">
<div class="col-md-12">
<div class="v-spinner">
<div class="v-clip" style="height: 35px; width: 35px; border-width: 2px; border-style: solid; border-color: rgb(0, 104, 217) rgb(0, 104, 217) transparent; border-radius: 100%; background: transparent !important;">&nbsp;</div>
</div>
</div>
<div class="col-md-12">
<p><script>Capture(other.wait)</script></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<div id="waitReboot" style="display: none;">
<div class="modal" role="diglog" _v-f353fd1c="">
<div class="modal-dialog modal-sm">
<div class="modal-content">
<div class="loadingImg" _v-f353fd1c="">
<div class="row">
<div class="col-md-12">
<div class="v-spinner">
<div class="v-clip" style="height: 35px; width: 35px; border-width: 2px; border-style: solid; border-color: rgb(0, 104, 217) rgb(0, 104, 217) transparent; border-radius: 100%; background: transparent !important;">&nbsp;</div>
</div>
</div>
<div class="col-md-12">
<p><script>Capture(other.wait)</script></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</CENTER>
