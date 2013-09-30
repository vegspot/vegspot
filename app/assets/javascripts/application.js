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
//= require turbolinks
//= require rails-timeago
//= require_tree .

// Start and stop spinner
document.addEventListener("page:fetch", startSpinner);
document.addEventListener("page:receive", stopSpinner);

function startSpinner() {
	$('.logo .icon-leaf').addClass('icon-spin')
}

function stopSpinner() {
	$('.logo .icon-leaf').removeClass('icon-spin')
}

$(document).ready(function(){
  $('.node-single-card').hover(function(){}, function(){
    $(this).find('.btn-node-share').popover('hide')
  })
})