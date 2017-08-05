$(document).on('ready', function(){
  $('.new-chatroom-row').keyup(function(){
    var chatroom_name = $('#chatroom_name').val();
    var chatroom_chatroom_id = $('#chatroom_chatroom_id').val();

    if(chatroom_name == '' || chatroom_chatroom_id == '') {
      $('.btn-new-chatroom').attr('disabled', 'disabled');
    } else {
      $('.btn-new-chatroom').removeAttr('disabled');
    }
  })

  $('.btn-edit-chatroom').on('click', function(){
    $.ajax({
      dataType: 'html',
      url: $(this).attr('href'),
      method: 'get',
      success: function(data) {
        $('.modal-content-outer').removeClass('col-md-12');
        $('.modal-content-outer').addClass('col-md-10 col-md-offset-1');
        $('.modal-content').html(data);
      },
      error: function() {
        alert('Oops!!! Cannot edit this chatroom!');
      }
    })
  })

  $('body').on('click', '.btn-update-chatroom', function(){
    var count_error = 0;
    var error_message = '';

    if($('.edit-chatroom-name').val() == '') {
      count_error++;
      error_message += '<li class="text-danger">Name can\'t be blank</li>';
    }

    if($('.edit-chatroom-id').val() == '') {
      count_error++;
      error_message += '<li class="text-danger">Chatroom ID can\'t be blank</li>';
    }

    if(count_error > 0) {
      var singular_plural_form = '';

      if(count_error == 1) {
        singular_plural_form = 'error';
      } else {
        singular_plural_form = 'errors';
      }

      $('.error').html('');
      $('.error').append('<div id="error_explanation"><div class="alert alert-danger">The form contains: '
        + count_error + ' ' + singular_plural_form + '</div><ul>' + error_message + '</ul></div>');

      return false;
    }
  })
})
