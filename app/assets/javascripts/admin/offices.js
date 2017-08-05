$(document).on('ready', function(){
  $('.btn-show-office').on('click', function(){
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
        alert('Oops!!! Cannot show this office!');
      }
    })
  })

  $('.btn-edit-office').on('click', function(){
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
        alert('Oops!!! Cannot display edit form for this office!');
      }
    })
  })

  $('.btn-new-office').on('click', function(){
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
        alert('Oops!!! Cannot display form for creating new office!');
      }
    })
  })
})
