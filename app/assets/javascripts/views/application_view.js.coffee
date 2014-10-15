window.Views ||= {}
class Views.ApplicationView
  render: ->
    $.bootstrapSortable(applyLast=true)
    $('[rel~="tooltip"]').tooltip();

    $(document).on 'cocoon:after-insert', ->
      Widgets.Select2.enable()

    $(document).on 'ajax:success', '#edit_note', (evt, data, status, xhr) ->
      $('.note_form').html(data)

    $(document).on 'click', '#show_notes', ->
      $('#notes').toggle()


  cleanup: ->
    $(document).off 'ajax:success', '#edit_note'
    $(document).off 'cocoon:after-insert'
    $('[rel~="tooltip"]').off()


