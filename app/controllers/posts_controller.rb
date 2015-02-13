class PostsController < ApplicationController
  helper_method :current_post, :is_author?

  def new
    sub = Sub.find(params[:sub_id]) #go to subs/show.html.erb
    # takes sub_id from params hash and puts corresponding Sub object into
    # local variable to give to instance variable of post so that it can be
    # sent to posts/new.html.erb view
    @post = sub.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.sub_id = params[:sub_id]
    # sets @post.sub_id to the sub_id passed from the new.html.erb form
    # journey of sub_id:
    # sub show view => postscontroller#new action => posts new view => posts#create action
    if @post.save
      redirect_to post_url(@post)
    else
      render :new
    end
  end

  def show
    @post = current_post
  end

  def edit
    @post = current_post
  end

  def update
    @post = current_post

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      render :edit
    end
  end


private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id, :user_id)
  end

  def current_post
    Post.find(params[:id])
  end

  def is_author?
    current_post.user_id == current_user.id
  end
end
