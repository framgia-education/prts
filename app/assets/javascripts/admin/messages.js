$(document).ready(function(){
  $('.btn-new-message').on('click', function(){
    window.open('/admin/messages/new');
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
