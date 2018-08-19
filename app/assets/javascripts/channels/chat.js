$(document).ready(() => {
  if ($('meta[name=action-cable-url]').length) {
    App.chat = App.cable.subscriptions.create({
      channel: "ChatChannel",
      company_id: $("#chat-grid").data("company-id")
    }, {
      connected: function() {
        // Called when the subscription is ready for use on the server
        
      },
  
      disconnected: function() {
        // Called when the subscription has been terminated by the server
      },
  
      received: function(data) {
        var message = data.message
        var user = data.user
        var current = false
        if (message.conversation_id == $("#convo-body").data("conversationId")) {
          current = true
          var html = '<div>'
          html += '<div class="convo-item-container inbound">'
          html += '<small>' + user.name + '</small>'
          html += '<div class="convo-item-bubble inbound">' + message.body + '</div>'
          html += '<span><small>' + message.message_time +'</small></span>'
          html += '</div>'
          html += '</div>'
          $("#convo-body").append( html );
          var objDiv = document.getElementById("convo-body");
          objDiv.scrollTop = objDiv.scrollHeight;
        }
        var company_id = $("#chat-grid").data("company-id")
        var pickName = message.company_names.filter(co => co.id !== company_id).map(co => co.name).join(', ')

        var convoItem ='<div class="chat-item" id="chat-item-' + message.conversation_id + '" data-conversation-id="' + message.conversation_id + '">'
        convoItem += '<a href="/' + message.to_kind + '/conversations/' + message.id + '" >'
        convoItem += '<div><span><strong>' + pickName + '</strong></span></div>'
        convoItem += '<div><span>' + user.name + ': ' + message.body + '</span></div>'
        convoItem += '</a></div>'
        
        // user current for read/unread
        $("#chat-item-" + message.conversation_id).remove();

        $("#conversation-overview").prepend(convoItem)
      }
    });
  }
})
