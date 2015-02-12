class TracksController < ApplicationController

def index

end

def new
  @track = Track.new
end

def create
  @track = Track.new(track_params)

  if @track.save
    redirect_to track_url(@album)
  else
    render :new
  end
end

def show
  @track = Track.find(params[:id])
end


private
  def track_params
    params.require(:track).permit(:name, :album_id, :level, :lyrics)
  end

end
