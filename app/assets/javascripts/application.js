// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//

//= require jquery
//= require jquery_ujs
//= require highcharts
//= require highstock
//= require twitter/bootstrap/bootstrap-tab.js
//= require twitter/bootstrap/bootstrap-transition.js
//= require twitter/bootstrap/bootstrap-collapse.js
//= require_tree .


$('li > a').click(function() {
    $('li').removeClass();
    $(this).parent().addClass('active');
});
$(function() {
    $('#plan_table .nav-pills li a').click(function(e) {
//        e.preventDefault();
        $(this).parent().addClass('active').siblings().removeClass('active');
    });
});
function fixDiv() {
  var $cache = $('.scroller');
  if ($(window).scrollTop() > 150){
    $cache.css({'position': 'fixed', 'top': '0px', 'width': '98%'});
    $cache.addClass("background");
}
  else{
    $cache.css({'position': 'relative', 'top': 'auto', 'width': '100%'});
    $cache.removeClass("background");
}
}

$(window).bind("keypress", function(e) {
    if (e.keyCode == 37) {
        $("a#prev_day").click();
    }

    if (e.keyCode == 39) {
        $("a#next_day").click();
    }
});

$(window).scroll(fixDiv);
fixDiv();
