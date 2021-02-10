import consumer from "./consumer"

consumer.subscriptions.create("DeleteCommentChannel", {
  connected() {
  },

  disconnected() {
  },

  received(data) {
    const comment = document.getElementById(`comment_${data.comment.id}`);
    comment.remove();
  }
});
