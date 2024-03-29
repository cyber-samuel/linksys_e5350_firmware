/*
* jQuery Reveal Plugin 1.1
* www.ZURB.com
* Copyright 2010, ZURB
* Free to use under the MIT license.
* http://www.opensource.org/licenses/mit-license.php
*/
/*globals jQuery */
/*
*	Reveal modal usage:
*	To open a modal (any div with classes "large reveal-modal"), use this code (where selector is the jquery selector for that div):
*		$(selector).reveal();
*	To close the modal, do this:
*		$(selector).trigger('reveal:close'); 
*	NOTE: Opening a modal while another is open is OK. First modal will close and second will open.
*/
/*
Tom.Hung 2014-7-22, Change visibility:hidden to display:none because the height still exist when visibility:hidden.
*/
(function ($) {
var modalQueued = false;
$(document).on('click', 'a[data-reveal-id]', function (event) {
event.preventDefault();
var modalLocation = $(this).attr('data-reveal-id');
$('#' + modalLocation).reveal($(this).data());
});
$.fn.reveal = function (options) {
var defaults = {
animation: 'fade', // fade, fadeAndPop, none
animationSpeed: 300, // how fast animtions are
closeOnBackgroundClick: false, // if you click background will modal close?
closeOnESC: false, // if you press ESC will modal close?
dismissModalClass: 'unstyled-close-reveal-modal', // the class of a button or element that will close an open modal
open: $.noop,
opened: $.noop,
close: $.noop,
closed: $.noop
};
options = $.extend({}, defaults, options);
return this.each(function () {
var modal = $(this),
topMeasure = parseInt(modal.css('top'), 10),
topOffset = modal.height() + topMeasure,
locked = false,
modalBg = $('.reveal-modal-bg'),
closeButton;
if (modalBg.length === 0) {
modalBg = $('<div class="reveal-modal-bg" />').insertAfter(modal);
modalBg.fadeTo('fast', 0.8);
}
function unlockModal() {
locked = false;
}
function lockModal() {
locked = true;
}
function closeOpenModals(modal) {
var openModals = $(".reveal-modal.open");
if (openModals.length === 1) {
modalQueued = true;
$(".reveal-modal.open").trigger("reveal:close");
}
}
function openAnimation() {
if (!locked) {
lockModal();
closeOpenModals(modal);
modal.addClass("open");
if (options.animation === "fadeAndPop") {
modal.css({'top': $(document).scrollTop() - topOffset, 'opacity': 0, 'display': 'block'});
modalBg.fadeIn(options.animationSpeed / 2);
modal.delay(options.animationSpeed / 2).animate({
"top": $(document).scrollTop() + topMeasure + 'px',
"opacity": 1
}, options.animationSpeed, function () {
modal.trigger('reveal:opened');
});
}
if (options.animation === "fade") {
modal.css({'opacity': 0, 'display': 'block', 'top': $(document).scrollTop() + topMeasure});
modalBg.fadeIn(options.animationSpeed / 2);
modal.delay(options.animationSpeed / 2).animate({
"opacity": 1
}, options.animationSpeed, function () {
modal.trigger('reveal:opened');
});
}
if (options.animation === "none") {
modal.css({'display': 'block', 'top': $(document).scrollTop() + topMeasure});
modalBg.css({"display": "block"});
modal.trigger('reveal:opened');
}
}
}
modal.bind('reveal:open.reveal', openAnimation);
function closeAnimation() {
if (!locked) {
lockModal();
modal.removeClass("open");
if (options.animation === "fadeAndPop") {
modal.animate({
"top": $(document).scrollTop() - topOffset + 'px',
"opacity": 0
}, options.animationSpeed / 2, function () {
modal.css({'top': topMeasure, 'opacity': 1, 'display': 'none'});
});
if (!modalQueued) {
modalBg.delay(options.animationSpeed).fadeOut(options.animationSpeed, function () {
modal.trigger('reveal:closed');
});
} else {
modal.trigger('reveal:closed');
}
}
if (options.animation === "fade") {
modal.animate({
"opacity" : 0
}, options.animationSpeed, function () {
modal.css({'opacity': 1, 'display': 'none', 'top': topMeasure});
});
if (!modalQueued) {
modalBg.delay(options.animationSpeed).fadeOut(options.animationSpeed, function () {
modal.trigger('reveal:closed');
});
} else {
modal.trigger('reveal:closed');
}
}
if (options.animation === "none") {
modal.css({'display': 'none', 'top': topMeasure});
if (!modalQueued) {
modalBg.css({'display': 'none'});
}
modal.trigger('reveal:closed');
}
modalQueued = false;
}
}
function destroy() {
modal.unbind('.reveal');
modalBg.unbind('.reveal');
$('.' + options.dismissModalClass).unbind('.reveal');
$('body').unbind('.reveal');
}
modal.bind('reveal:close.reveal', closeAnimation);
modal.bind('reveal:opened.reveal reveal:closed.reveal', unlockModal);
modal.bind('reveal:closed.reveal', destroy);
modal.bind('reveal:open.reveal', options.open);
modal.bind('reveal:opened.reveal', options.opened);
modal.bind('reveal:close.reveal', options.close);
modal.bind('reveal:closed.reveal', options.closed);
modal.trigger('reveal:open');
closeButton = $('.' + options.dismissModalClass).bind('click.reveal', function () {
modal.trigger('reveal:close');
});
if (options.closeOnBackgroundClick) {
modalBg.css({"cursor": "pointer"});
modalBg.bind('click.reveal', function () {
modal.trigger('reveal:close');
});
}
if (options.closeOnESC) {
$('body').bind('keyup.reveal', function (event) {
if (event.which === 27) { // 27 is the keycode for the Escape key
modal.trigger('reveal:close');
}
});
}
});
};
} (jQuery));
