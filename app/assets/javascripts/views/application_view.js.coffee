window.Views ||= {}
class Views.ApplicationView
  render: ->
    $.bootstrapSortable(applyLast=true)
    $('[rel~="tooltip"]').tooltip()
    $('#show_notes').click ->
      $('#notes').toggle();
    Widgets.DateTimePicker.enable()
    Widgets.TypeAhead.enable()
    $('a[data-toggle="tab"]').on 'click', (e) ->
      e.preventDefault()
      $(this).tab('show');

  cleanup: ->
    $('a[data-toggle="tab"]').off 'click'
    $('[rel~="tooltip"]').off()
    Widgets.DateTimePicker.cleanup()
    Widgets.TypeAhead.cleanup()


