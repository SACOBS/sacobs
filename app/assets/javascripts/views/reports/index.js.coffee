window.Views.Reports ||= {}
class Views.Reports.IndexView extends Views.ApplicationView
  render: ->
    super()
    Widgets.TypeAhead.enable()
  cleanup: ->
    super()
    Widgets.TypeAhead.cleanup()

