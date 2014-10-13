class NotesController < ApplicationController
  def index
    @notes = Note.where(context: params[:context])
    @new_note = @notes.new if current_user.admin?
    render partial: 'notes', locals: { notes: @notes, new_note: @new_note }
  end

  def create
    @note = Note.create(note_params)
    render partial: 'note', locals: { note: @note }
  end

  def edit
    @note = Note.find(params[:id])
    render partial: 'notes/form', locals: { note: @note }

  end

  def update
    @note = Note.find(params[:id])
    @note.update(note_params)
    render partial: 'note', locals: { note: @note }
  end

  private

  def note_params
    params.fetch(:note, {}).permit(:context, :content)
  end
end
