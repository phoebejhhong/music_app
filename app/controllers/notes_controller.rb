class NotesController < ApplicationController

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @note.track_id = params[:track_id]
    @note.save
    redirect_to track_url(@note.track)
  end

  def destroy
    note = Note.find(params[:id])
    unless admin? || current_user.id == note.user_id
      render text: "You dare", status: 403
      return
    end
    track = note.track
    note.destroy
    redirect_to track_url(track)
  end

  private
  def note_params
    params.require(:note).permit(:user_id, :track_id, :body)
  end

end
