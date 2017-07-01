App.room = App.cable.subscriptions.create('RoomChannel', {
  connected: function() {
  },

  disconnected: function() {
  },

  received: function(data) {
    var tdItem = $('td.pull-request-' + data.id);
    tdItem.html('<span class="' + data.status + '">' + data.status + '</span>');
  }
});
