class NotesController < ApplicationController
  def index
    @notes = Note.for_context(params[:context])
  end

  def create
    @note = Note.create(note_params)
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
  end

  private

  def note_params
    params.fetch(:note, {}).permit(:context, :content)
  end
end
