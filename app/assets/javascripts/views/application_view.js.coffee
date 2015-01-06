window.Views ||= {}
class Views.ApplicationView
  render: ->
    $.bootstrapSortable(applyLast=true)
    $('[rel~="tooltip"]').tooltip()
    $(document).on 'click', '#show_notes', ->
      $('#notes').toggle()

  cleanup: ->
    $(document).off 'click', '#show_notes', ->
    $('[rel~="tooltip"]').off()


