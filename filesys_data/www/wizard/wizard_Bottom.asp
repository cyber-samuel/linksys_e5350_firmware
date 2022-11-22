</div>
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
if( 0 && typeof wiz != 'undefined' && typeof wiz[x.toLowerCase()] != 'undefined' )
text = sbutton[x.toLowerCase()];
else if( typeof eval(x) != 'undefined' )
text = eval(x);
else
text = x;
draw_button(link, text, '', 'btn-wiz');
}
document.write('</div">');
})();
</script>
</div>
