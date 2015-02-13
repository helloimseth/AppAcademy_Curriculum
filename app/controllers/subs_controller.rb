class SubsController < ApplicationController
  def index
    #show subs
  end

  def create
    @sub = Sub.new
  end

  def new

  end

  def edit

  end

  def show

  end

  def update

  end

  def destroy

  end

  private

    def sub_params
      params.require(:sub).permit(:title, :description, :moderator)
    end
end
