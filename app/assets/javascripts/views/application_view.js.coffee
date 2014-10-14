window.Views ||= {}
class Views.ApplicationView
  render: ->
    $.bootstrapSortable(applyLast=true)
    $('[rel~="tooltip"]').tooltip();

    $(document).on 'cocoon:after-insert', ->
      Widgets.Select2.enable()

    $(document).on 'ajax:success', '#edit_note', (evt, data, status, xhr) ->
      $('.note_form').html(data)


  cleanup: ->
    $(document).off 'ajax:success', '#edit_note'
    $(document).off 'cocoon:after-insert'
    $('[rel~="tooltip"]').off()


