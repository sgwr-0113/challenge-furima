import consumer from "./consumer"

if(location.pathname.match(/items/) && location.pathname.match(/\d+/)){
  consumer.subscriptions.create({
    channel: "CommentsChannel",
    item_id: location.pathname.match(/\d+/)[0]
  }, {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      console.log(data);
      const html = `<p class="comment">${data.user.nickname}：  ${data.comment.text}　　<a class="delete-comment-btn" data-method="delete" href="/items/${data.item.id}/comments/${data.comment.id}">削除</a></p>`;
      const comments = document.getElementById('comments');
      const newComment = document.getElementById('comment_text');
      comments.insertAdjacentHTML('afterend', html);
      newComment.value='';
    }
  });
}
