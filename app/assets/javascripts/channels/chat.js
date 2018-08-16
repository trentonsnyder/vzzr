if ($('meta[name=action-cable-url]').length) {
  var messages = $("#chat-grid")
  App.chat = App.cable.subscriptions.create({
    channel: "ChatChannel",
    conmpany_id: messages.data("company-id")
  }, {
    connected: function() {
      // Called when the subscription is ready for use on the server
      
    },

    disconnected: function() {
      // Called when the subscription has been terminated by the server
    },

    received: function(data) {
      // determine if it goes in sidebar or chat
      $('#chat-body').append(data['message']);
    }
  });
}
