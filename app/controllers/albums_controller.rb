class AlbumsController < ApplicationController

  def index
    @albums = Album.where(band_id: params[:band_id])
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


  private
    def album_params
      params.require(:album).permit(:title, :band_id, :setting)
    end
end
