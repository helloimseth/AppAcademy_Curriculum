class SubsController < ApplicationController
  before_action :mod_check, only: :edit
  helper_method :is_moderator?, :current_sub
  def index
    #show subs
  end

  def create
    @sub = current_user.moderated_subs.new(sub_params)

    if @sub.save
      redirect_to sub_url(@sub)
    else
      render :new
    end
  end

  def new
    @sub = Sub.new
  end

  def edit
    @sub = current_sub
  end

  def show
    @sub = current_sub
  end

  def update
    @sub = current_sub

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  def destroy
    @sub = current_sub
    @sub.destroy!
    redirect_to subs_url
  end

  private

    def sub_params
      params.require(:sub).permit(:title, :description, :moderator)
    end

    def mod_check
      redirect_to subs_url unless is_moderator?
    end

    def is_moderator?
      current_user.id == current_sub.mod_id
    end

    def current_sub
      Sub.find(params[:id]) if params[:id]
    end
end
