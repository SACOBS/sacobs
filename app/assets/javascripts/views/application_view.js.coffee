window.Views ||= {}
class Views.ApplicationView
  render: ->
    $.bootstrapSortable(applyLast=true)
    $('[rel~="tooltip"]').tooltip()
    $('#show_notes').click ->
      $('#notes').toggle();
    Widgets.DateTimePicker.enable()
    Widgets.TypeAhead.enable()



  cleanup: ->
    $('[rel~="tooltip"]').off()
    Widgets.DateTimePicker.cleanup()
    Widgets.TypeAhead.cleanup()


