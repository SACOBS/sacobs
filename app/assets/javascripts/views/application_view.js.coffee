window.Views ||= {}
class Views.ApplicationView
  render: ->
    $.bootstrapSortable(applyLast=true)
    $(document).on 'cocoon:after-insert', ->
      Widgets.Select2.enable()
    $('[rel~="tooltip"]').tooltip();

    $(document).on 'hidden', '.modal', ->
      $(this).remove()

  cleanup: ->
    $(document).off 'cocoon:after-insert'
    $('[rel~="tooltip"]').off()


