window.Views.Reports ||= {}
class Views.Reports.NewView extends Views.ApplicationView
  render: ->
    super()
    Widgets.TypeAhead.enable()
  cleanup: ->
    super()
    Widgets.TypeAhead.cleanup()
