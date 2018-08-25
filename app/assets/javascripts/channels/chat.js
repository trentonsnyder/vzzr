$(document).ready(() => {
  if ($('meta[name=action-cable-url]').length) {
    App.chat = App.cable.subscriptions.create({
      channel: "ChatChannel",
      company_id: $("#the-app").data("company-id")
    }, {
      connected: function() {
        // Called when the subscription is ready for use on the server
        
      },
  
      disconnected: function() {
        // Called when the subscription has been terminated by the server
      },
  
      received: function(data) {
        var message = data.message
        if (message.conversation_id == $("#convo-body").data("conversationId")) {
          var html = '<div>'
          html += '<div class="convo-item-container inbound">'
          html += '<div class="convo-item-bubble inbound">' + message.body + '</div>'
          html += '</div>'
          html += '</div>'
          $("#convo-body").append( html );
          var objDiv = document.getElementById("convo-body");
          if (objDiv) {
            objDiv.scrollTop = objDiv.scrollHeight
          }
        }
        var convoItem = '<a id="chat-item-' + message.conversation_id + '" href="/' + message.to_kind + '/conversations/' + message.conversation_id + '" >'
        convoItem += '<div class="chat-item " data-conversation-id="' + message.conversation_id + '">'
        convoItem += '<img src="' + message.cover_image_url + '" />'
        convoItem += '<div class="chat-item-details">'
        convoItem += '<div><span><strong>' + message.company_name + '</strong></span></div>'
        convoItem += '<div><span class="chat-item-text">' + data.user.name + ': ' + message.body + '</span></div></div>'
        convoItem += '</div></a>'

        $("#chat-link").append('<span id="chat-bubble"></span>');
        
        $("#chat-item-" + message.conversation_id).remove();

        $("#conversation-overview").prepend(convoItem)
        var url = window.location.pathname
        var stuff = url.split('/');
        var id = stuff[stuff.length-1]
        var chatItem = $('.chat-item[data-conversation-id="' + id + '"]')
        if (chatItem) {
          chatItem.addClass('current');
        } else {
          // add a bubble to the thing
        }
      }
    });
  }
})
