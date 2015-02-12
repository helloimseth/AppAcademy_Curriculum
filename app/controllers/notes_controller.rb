class NotesController < ApplicationController

  def create
    note = Note.new(note_params)
    note.user_id = current_user.id
    track = note.track
    note.save

    redirect_to track_url(track)
  end

  def destroy
    note = Note.find(params[:id])
    track = Track.find(note.track_id)

    if note.user_id = current_user.id
      note.destroy!
    else
      render status: 403
      return
    end
    
    redirect_to track_url(track)
  end

  private

    def note_params
      params.require(:note).permit(:track_id, :user_id, :body)
    end

end
