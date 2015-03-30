class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.create(comment_params)
    redirect_to post_url(@comment.post) unless @comment.parent
    redirect_to comment_url(@comment.parent)
  end

  def show
    @comment = Comment.find(params[:id])
    @comments = @comment.post.comments_by_parent_id
  end

  private

    def comment_params
      params.require(:comment).permit(:author_id, :post_id, :content, :parent_id)
    end
end
