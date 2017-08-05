$(document).on('ready', function(){
  $('.btn-show-user').on('click', function(){
    $.ajax({
      dataType: 'html',
      url: $(this).attr('href'),
      method: 'get',
      success: function(data){
        $('.modal-content-outer').removeClass('col-md-12');
        $('.modal-content-outer').addClass('col-md-10 col-md-offset-1');
        $('.modal-content').html(data);
      },
      error: function(){
        alert('Oops!!! Cannot show this user!');
      }
    })
  })

  $('.btn-edit-user').on('click', function(){
    $.ajax({
      dataType: 'html',
      url: $(this).attr('href'),
      method: 'get',
      success: function(data){
        $('.modal-content-outer').removeClass('col-md-10 col-md-offset-1');
        $('.modal-content-outer').addClass('col-md-12');
        $('.modal-content').html(data);
      },
      error: function(){
        alert('Oops!!! Cannot display edit form for this user!');
      }
    })
  })
})
