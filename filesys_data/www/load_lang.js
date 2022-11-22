function LANG_EXTEND(name, data){
if( typeof window[name] == "undefined" ){
window[name] = data;
return;
}
for( var x in data ){
if( !data.hasOwnProperty(x) ) continue;
if( typeof window[name][x] == "undefined" ){
window[name][x] = data[x]
}
}
}
(function(){
var ej_lang = '<% get_lang(); %>',
lang_pkgs = [
ej_lang + '_lang_pack/capsec',
ej_lang + '_lang_pack/share',
ej_lang + '_lang_pack/help',
ej_lang + '_lang_pack/capapp',
ej_lang + '_lang_pack/capasg',
ej_lang + '_lang_pack/capsetup',
ej_lang + '_lang_pack/capstatus',
ej_lang + '_lang_pack/capwrt54g',
ej_lang + '_lang_pack/capadmin',
ej_lang + '_lang_pack/timezone',
ej_lang + '_lang_pack/layout',
ej_lang + '_lang_pack/storage',
ej_lang + '_lang_pack/ddns',
ej_lang + '_lang_pack/other'
];
if( ej_lang != 'en' ){
lang_pkgs = lang_pkgs.concat([
'enmg_lang_pack/capsec',
'enmg_lang_pack/share',
'enmg_lang_pack/help',
'enmg_lang_pack/capapp',
'enmg_lang_pack/capasg',
'enmg_lang_pack/capsetup',
'enmg_lang_pack/capstatus',
'enmg_lang_pack/capwrt54g',
'enmg_lang_pack/capadmin',
'enmg_lang_pack/timezone',
'enmg_lang_pack/layout',
'enmg_lang_pack/storage',
'enmg_lang_pack/ddns',
'enmg_lang_pack/other'
]);
}
lang_pkgs.push('no_lang');
var f;
while( lang_pkgs.length && (f = lang_pkgs.shift()) ){
if( !f ) continue;
document.write('\
<script type="text/javascript" charset="UTF-8" onerror="location.reload()" src="/' + f + '.js"></script>\
');
}
})();