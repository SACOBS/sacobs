window.Views ||= {}
class Views.ApplicationView
  render: ->
    $(document).on 'cocoon:after-insert', ->
      Widgets.Select2.enable()
    $('[rel~="tooltip"]').tooltip();

  cleanup: ->
    $(document).off 'cocoon:after-insert'
    $('[rel~="tooltip"]').off()


