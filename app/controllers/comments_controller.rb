class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.create(comment_params)

    redirect_to post_url(@comment.post)
  end

  private

    def comment_params
      params.require(:comment).permit(:author_id, :post_id, :content)
    end
end
