/*!
 * Materialize v1.0.0-rc.2 (http://materializecss.com)
 * Copyright 2014-2017 Materialize
 * MIT License (https://raw.githubusercontent.com/Dogfalo/materialize/master/LICENSE)
 */

// Centring function:
jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + 
                                                $(window).scrollTop()) + "px");
    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + 
                                                $(window).scrollLeft()) + "px");
    return this;
}

// Centring element:
$('.container').center();

// toggling classes
$('a.btn-like').on('click', function() {
  $(this).toggleClass('liked');
  $('.like-text,.unlike-text').toggle();
});

$('a.btn-favorite').on('click', function() {
  $(this).toggleClass('liked');
  $('.favorite-text,.unfavorite-text').toggle();
});