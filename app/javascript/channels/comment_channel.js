import consumer from "./consumer"

if(location.pathname.match(/items/) && location.pathname.match(/\d+/)){
  consumer.subscriptions.create({
    channel: "CommentsChannel",
    item_id: location.pathname.match(/\d+/)[0]
  }, {
    connected() {
      console.log("connected channnel")
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      console.log("miss");
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      console.log(data);
      const html = `<p class="comment">${data.user.nickname}：  ${data.comment.text}</p>`;
      const comments = document.getElementById('comments');
      const newComment = document.getElementById('comment_text');
      console.log(html);
      comments.insertAdjacentHTML('afterend', html);
      newComment.value='';
    }
  });
}
