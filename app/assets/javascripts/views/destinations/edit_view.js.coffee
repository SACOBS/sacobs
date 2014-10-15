window.Views.Destinations ||= {}
class Views.Destinations.EditView extends Views.ApplicationView
  render: ->
    super()
    Widgets.TypeAhead.enable()
  cleanup: ->
    super()
    Widgets.TypeAhead.cleanup()
