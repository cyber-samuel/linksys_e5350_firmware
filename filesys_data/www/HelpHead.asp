<script type="text/javascript" src="../jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
var div = $('<div>'),
body = $('body');
body.removeAttr('bgColor');
div.append($('h1').siblings()).appendTo(body);
div.siblings().remove();
});
</script>