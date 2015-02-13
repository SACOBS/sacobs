window.Views.Reports ||= {}
class Views.Reports.EditView extends Views.ApplicationView
  render: ->
    super()
    Widgets.TypeAhead.enable()
  cleanup: ->
    super()
    Widgets.TypeAhead.cleanup()
