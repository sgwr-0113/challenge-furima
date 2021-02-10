class DeleteCommentChannel < ApplicationCable::Channel
  def subscribed
    stream_from "delete_comment_channel"
  end

  def unsubscribed
  end
end
