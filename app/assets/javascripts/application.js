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

$(document).on('ready', function(){
  $('.flash-message').delay(2000).slideUp(500, function(){
    $(this).remove();
  });

  $('span.ready').on('click', function() {
    var spanElem = $(this);
    var tdElem = spanElem.parents('.pull-status');
    var form = spanElem.parents('form');

    $.ajax({
      url: $('form')[0].action,
      type: "POST",
      dataType: 'json',
      data: $('form').serialize(),
      success: function (data) {
        tdElem.html('<span class="' + data.status + '">' + data.status + '</span>')
        var win = window.open(data.url_files, '_blank');
        win.focus();
      },
      errors: function() {
        alert('Update failed!!!');
      }
    });
  });
})
