window.Views ||= {}
class Views.ApplicationView
  render: ->
    $.bootstrapSortable(applyLast=true)
    $(document).on 'cocoon:after-insert', ->
      Widgets.Select2.enable()
    $('[rel~="tooltip"]').tooltip();

    $(document).on 'ajax:success', '#view_notes', (evt, data, status, xhr) ->
      $('body').append(data)
      $('#notes').modal('show')

    $(document).on 'ajax:success', '#edit_note_link', (evt, data, status, xhr) ->
      $('.note_form').html(data)

    $(document).on 'ajax:success', '.edit_note', (evt, data, status, xhr) ->
      $($(this).data('note')).replaceWith(data)
      $(this).reset()

    $(document).on 'ajax:success', '#new_note', (evt, data, status, xhr) ->
      $('ul.notes').append(data)
      $(this)[0].reset()

    $(document).on 'hidden', '.modal', ->
      $(this).remove()

  cleanup: ->
    $(document).off 'ajax:success', '#view_notes'
    $(document).off 'cocoon:after-insert'
    $(document).off 'hidden', '.modal'
    $('[rel~="tooltip"]').off()


