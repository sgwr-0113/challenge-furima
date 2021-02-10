import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const html = `<div class="mine">
                  <p class="my-message">${data.content.text}</p>
                  <br>
                  <small><p class="my-name"> あなた</p></small>
                  </div>`;
    const messages = document.getElementById('messages');
    const newMessage = document.getElementById('message_text');
    const messageBtn = document.getElementById('message-send-btn');
    const defaultMessage = document.getElementById('default-message');
    messages.insertAdjacentHTML('beforeend', html);
    newMessage.value='';
    messageBtn.removeAttribute("disabled");
    defaultMessage.remove();
  }
});
