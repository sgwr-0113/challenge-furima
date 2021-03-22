class CommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id]) 
    @comment = Comment.new(comment_params)
    if @comment.save
      CommentsChannel.broadcast_to @item, {comment: @comment, user: @comment.user, item: @item}
    end
  end

  def destroy
    if params[:comment_id]
      @comment = Comment.find(params[:comment_id]) # 同期通信後
    else
      @comment = Comment.find(params[:id])         # 非同期通信後
    end
    if @comment.destroy
      ActionCable.server.broadcast 'delete_comment_channel', comment: @comment
    else
      redirect_to item_path(@comment.item_id)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
