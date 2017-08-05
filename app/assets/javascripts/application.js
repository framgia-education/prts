// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require chosen-jquery
//= require cable
//= require_tree ./admin

function set_up_chosen() {
  $('.chosen-select').chosen({
    allow_single_deselect: true,
    width: '160px'
  });
}

$(document).on('ready', function(){
  $('.flash-message').delay(3000).slideUp(500, function(){
    $(this).remove();
  });

  set_up_chosen();

  $('body').on('click', '.btn-generate-api-key', function(e){
    e.preventDefault();
    var form = $(this).parents('form');

    $.ajax({
      dataType: 'json',
      url: form[0].action,
      method: 'post',
      data: form.serialize(),
      success: function(data){
        $('.oauth-token-text').html(data.oauth_token);
        $('.oauth-token-text').css('background', 'pink');
      },
      error: function(){
        alert('Oops!!! Generate API key failed');
      }
    })
  })
})
