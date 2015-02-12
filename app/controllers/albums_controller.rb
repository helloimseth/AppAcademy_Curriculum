class AlbumsController < ApplicationController

  def index

  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
  end


  private
    def album_params
      params.require(:album).permit(:title, :band_id, :setting)
    end
end
