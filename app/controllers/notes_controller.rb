class NotesController < ApplicationController
  def index
    @notes = Note.where(context: params[:context])
    if current_user.admin?
     @new_note = Note.new(context: params[:context])
    end
  end

  def create
    @note = Note.create(note_params)
  end

  private
   def note_params
     params.fetch(:note, {}).permit(:context, :content)
   end
end