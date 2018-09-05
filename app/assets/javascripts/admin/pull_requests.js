$(document).ready(function(){
  $('body').on('click', '.pull-status span.ready', function(event) {
    event.preventDefault();

    if(confirm('Are you sure?') == false) return false;
    var spanElem = $(this);
    var tdElem = spanElem.parents('.pull-status');
    var form = spanElem.parents('form');
    var tr = form.parents('td').parents('tr');
    var current_reviewer = tr.children('td.current-reviewer');
    var updated_time = tr.children('td.updated-time');

    $.ajax({
      url: form[0].action,
      type: 'POST',
      dataType: 'json',
      data: form.serialize(),
      success: function (data){
        tdElem.html('<span class="' + data.status + '">' + data.status + '</span>');
        current_reviewer.removeClass('text-center');
        current_reviewer.html(data.current_reviewer);
        tdElem.attr('ready-to-reviewing', 1);
        updated_time.html("less than a minute ago");
        var win = window.open(data.url_files, '_blank');
        // win.focus();
      },
      errors: function(){
        alert('Update failed!!!');
      }
    });
  });

  $('body').on('change', '.office-classification', function(){
    $(this).closest('form').submit();
  })

  $('body').on('change', '.repository-classification', function(){
    $(this).closest('form').submit();
  })

  $('body').on('change', '.github-account-classification', function(){
    $(this).closest('form').submit();
  })

  $('body').on('click', '.pull-request-status-label label[role=button]', function(){
    $(this).closest('form').submit();
  })

  $('body').on('click', '.select-all-statuses', function(e){
    e.preventDefault();

    $('input[type=checkbox]').attr('checked', 'checked');
    $('input[type=checkbox]').prop('checked', true);

    $(this).closest('form').submit();
  })

  $('body').on('click', '.unselect-all-statuses', function(e){
    e.preventDefault();

    $('input[type=checkbox]').removeAttr('checked');
    $('input[type=checkbox]').prop('checked', false);

    $(this).closest('form').submit();
  })
})
