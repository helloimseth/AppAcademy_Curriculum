class CommentsController < ApplicationController

  def create
    @comment = current_user.authored_comments.new(comment_params)

    @comment.save
    flash[:error] = @comment.errors.full_messages

    redirect_to parent_show_page
  end

  def destroy
    @comment = Comment.find(params[:id])

    @comment.destroy

    redirect_to parent_show_page
  end

  private

    def comment_params
      params.require(:comment).permit(:comment, :commentable_id, :commentable_type)
    end

    def parent_show_page
      @comment.commentable_type == "Goal" ? goal_url(@comment.commentable) :
                                           user_url(@comment.commentable)
    end
end
