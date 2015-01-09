window.Views ||= {}
class Views.ApplicationView
  render: ->
    $.bootstrapSortable(applyLast=true)
    $('[rel~="tooltip"]').tooltip()
    $('#show_notes').click ->
      $('#notes').toggle();


  cleanup: ->
    $('[rel~="tooltip"]').off()


