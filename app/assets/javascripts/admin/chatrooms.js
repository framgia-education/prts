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

  $('body').on('click', '.btn-edit-chatroom', function(e){

    // alert($(this).attr('href'));
    // e.preventDefault();
    // $('#edit-chatroom').css('display', 'block');
    $.ajax({
      dataType: 'html',
      url: $(this).attr('href'),
      method: 'get',
      success: function(data) {
        $('.modal-content-chatroom').html(data);
      },
      error: function() {
        alert('Oops!!! Cannot edit this chatroom!')
      }
    })
  })
})
