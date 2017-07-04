App.room = App.cable.subscriptions.create('RoomChannel', {
  connected: function() {
  },

  disconnected: function() {
  },

  received: function(data) {
    var tdItem = $('td.pull-request-' + data.id);
    var th_current_reviewer = $('.th-current-reviewer');
    var td_update_time = tdItem.siblings('.updated-time');

    if(th_current_reviewer.length > 0){
      var span_status = tdItem.find('span.ready');
      var td_current_reviewer = tdItem.siblings('.current-reviewer');
      var ready_to_reviewing = tdItem.attr('ready-to-reviewing');

      if(span_status.length > 0 || (ready_to_reviewing && (data.status == 'reviewing'))) {
        td_current_reviewer.removeClass('text-center');
        td_current_reviewer.html(data.current_reviewer);
      } else {
        td_current_reviewer.addClass('text-center');
        td_current_reviewer.html('-');
      }

      if(data.status == 'ready') {
        tdItem.html('<form class="edit_pull_request" id="edit_pull_request_' + data.id + '" ' +
          'action="/admin/pull_requests/' + data.id + '" accept-charset="UTF-8" method="post">' +
          '<input name="utf8" type="hidden" value="✓">' +
          '<input type="hidden" name="_method" value="patch">' +
          '<input type="hidden" name="authenticity_token" value="' + $('meta[name="csrf-token"]').attr('content') + '">' +
          '<input value="reviewing" type="hidden" name="pull_request[status]" id="pull_request_status">' +
          '<span role="button" class="ready">ready</span></form>');
      } else {
        tdItem.html('<span class="' + data.status + '">' + data.status + '</span>');
      }
    } else {
      tdItem.html('<span class="' + data.status + '">' + data.status + '</span>');
    }
    td_update_time.html('<td class="updated-time">less than a minute ago</td>');
  }
});
