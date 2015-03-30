class PostsController < ApplicationController
  helper_method :current_post, :is_author?

  def new
    @post = Post.new
    @subs = Sub.all
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      @post.sub_ids = params[:post][:sub_ids]
      redirect_to post_url(@post)
    else
      @subs = Sub.all
      render :new
    end
  end

  def show
    @post = current_post
    @comments = @post.comments_by_parent_id
  end

  def edit
    @post = current_post
    @subs = Sub.all
  end

  def update
    @post = current_post

    if @post.update(post_params)
      @post.sub_ids = params[:post][:sub_ids]
      redirect_to post_url(@post)
    else
      @subs = Sub.all
      render :edit
    end
  end


private

  def post_params
    params.require(:post).permit(:title, :url, :content, :user_id, :sub_ids)
  end

  def current_post
    Post.find(params[:id])
  end

  def is_author?
    current_post.user_id == current_user.id
  end
end
