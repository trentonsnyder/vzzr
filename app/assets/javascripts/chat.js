$(document).ready(() => {
  var objDiv = document.getElementById("convo-body");
  if (objDiv) {
    objDiv.scrollTop = objDiv.scrollHeight
  }
  var url = window.location.pathname
  var stuff = url.split('/');
  var id = stuff[stuff.length-1]
  var chatItem = $('.chat-item[data-conversation-id="' + id + '"]')
  if (chatItem) {
    chatItem.addClass('current');
  }
})