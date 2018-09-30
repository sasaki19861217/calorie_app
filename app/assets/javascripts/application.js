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

$(function(){
    var date = new Date();
    
    var yyyy = date.getFullYear();
    var mm = ("0" + (date.getMonth() + 1)).slice(-2);
    var dd = ("0" + date.getDate()).slice(-2);
    var hh = date.getHours();
    var mm = date.getMinutes();
    
    var today = yyyy + '-' + mm + '-' + dd + 'T' + hh + ':' + mm;
    
    console.log(today)
    
    $('.action input').on('click', function(){
       if($('#food_history_ate_at').val() == "") {
           $(this).val(today);
       }
    }); 
});