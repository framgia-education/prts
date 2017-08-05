$(document).ready(function(){
  $('.btn-new-message').on('click', function(){
    window.open('/admin/messages/new');
  })

  $('.chatrooms-list').on('change', function(){
    var room_id = $(this).val();

    if(room_id == ''){
      $('.confirm-send-message-div').hide();
      $('.send-messge-div').show();
    } else {
      $('.chatroom-name').html($(this).find('option:selected').text());
    }
  })

  $('.btn-send-message').on('click', function(e){
    if($('.chatrooms-list').val() != '' && $('.input-message-area').val() != '') {
      $('.chatroom-name').html($('.chatrooms-list option:selected').text());
      $('.send-messge-div').hide();
      $('.confirm-send-message-div').show();
      e.preventDefault();
    }
  })

  $('.btn-cancel-send-message').on('click', function(){
    $('.confirm-send-message-div').hide();
    $('.send-messge-div').show();
  })

  $('.input-message-area').on('keyup', function(){
    var chat_text = $(this).val();
    var start = /@/ig;

    a = chat_text.lastIndexOf('@');
    atmarks = chat_text.match(start);
    // alert(atmarks);
    // if(atmarks) alert('aaa');
  })
})
