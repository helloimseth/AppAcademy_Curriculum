class TracksController < ApplicationController
  before_action :ensure_logged_in
  def index

  end

  def new
    @track = Track.new
    @track.album_id = params[:album_id]
  end

  def create

    @track = Track.new(track_params)
    if @track.save
      redirect_to album_url(@track.album)
    else
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
  end

  def edit
    @track = Track.find(params[:id])
  end

  def update
    @track = Track.find(params[:id])

    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    album = @track.album
    @track.destroy!

    redirect_to album_url(album)
  end


  private
    def track_params
      params.require(:track).permit(:name, :album_id, :level, :lyrics)
    end

end
