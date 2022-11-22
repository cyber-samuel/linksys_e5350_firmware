</div>
<script>
(function(){
if( !hasFormActions() ) return;
var text = '',
link = '';
document.write('<div class="modal-footer">');
for( var x in window.formBtns )
{
if( !window.formBtns.hasOwnProperty(x) ) continue;
if( !window.formBtns[x] ) continue;
if( !window.formBtns[x].length ) window.formBtns[x] = '';
link = window.formBtns[x];
if( x == 'close' )
{
if( /^javascript:/.test(link) )
link += ';closePopout()';
else
link = 'javascript:closePopout()';
}
if( x == 'refresh' )
{
if( /^javascript:/.test(link) )
link += ';showWait()';
else
link = 'javascript:showWait()';
}
if( typeof sbutton != 'undefined' && typeof sbutton[x.toLowerCase()] != 'undefined' )
text = sbutton[x.toLowerCase()];
else if( typeof adbutton != 'undefined' && typeof adbutton[x.toLowerCase()] != 'undefined' )
text = adbutton[x.toLowerCase()];
else if( typeof eval(x) != 'undefined' )
text = eval(x);
else
text = x;
draw_button(link, text);
}
document.write('</div">');
})();
</script>
</div>
