class PostsController < ApplicationController

  def new
    sub = Sub.find(params[:sub_id]) #go to subs/show.html.erb
    # takes sub_id from params hash and puts corresponding Sub object into
    # local variable to give to instance variable of post so that it can be
    # sent to posts/new.html.erb view
    @post = sub.posts.new
  end

  def create
    @post = current_user.posts(post_params)
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

  end

  def edit

  end

  def update

  end


private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id, :user_id)
  end
end
