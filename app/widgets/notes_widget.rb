class NotesWidget < Apotomo::Widget
  responds_to_event :submit
  responds_to_event :edit
  responds_to_event :destroy

  def display
    @notes = options[:notes]
    @user = options[:user]
    @note = @notes.new
    render
  end

  def form(note)
    render locals: { note: note }
  end

  def submit(event)
    note = Note.where(id: event[:note_id]).first_or_initialize
    note.content = event[:note][:content]
    note.context = event[:note][:context]
    note.user_id = options[:user].id
    note.save
    update '#notes', state: :display
  end

  def edit(event)
    note = Note.find(event[:note_id])
    replace '.note-form', text: render({ state: :form }, note)
  end

  def destroy(event)
    note = Note.find(event[:note_id])
    note.destroy
    update '#notes', state: :display
  end
end
