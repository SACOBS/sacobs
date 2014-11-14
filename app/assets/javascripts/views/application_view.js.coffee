window.Views ||= {}
class Views.ApplicationView
  render: ->
    $.bootstrapSortable(applyLast=true)
    $('[rel~="tooltip"]').tooltip();

    $(document).on 'ajax:success', '#edit_note', (evt, data, status, xhr) ->
      $('.note_form').html(data)

    $(document).on 'click', '#show_notes', ->
      $('#notes').toggle()


  cleanup: ->
    $(document).off 'ajax:success', '#edit_note'
    $(document).off 'click', '#show_notes', ->
    $('[rel~="tooltip"]').off()


