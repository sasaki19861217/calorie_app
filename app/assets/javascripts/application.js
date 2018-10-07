// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .
//= require jquery-ui
$(window).bind("load", function(){

	// 現在ページのURL取得
	var path = location.pathname;
	var page = $('body').attr('class'),
	page = page.substr(-4);

	// 現在ページが http://example.com/ なら実行
	console.log(page);
  if (path == "/food_histories/new" || page == "home"){

  if ( $('#food_menu_field,#food_calorie').val().length == 0 ) {
    $('#food_input').attr('disabled', 'disabled');
  }
  $('#food_menu_field,#food_calorie').bind('keydown keyup keypress change', function() {
    if ( $(this).val().length > 0 ) {
      $('#food_input').removeAttr('disabled');
    } else {
      $('#food_input').attr('disabled', 'disabled');
    }
  });    // ドメイン以下のパス名が /sample/sample.html の場合に実行する内容 
  }
});
