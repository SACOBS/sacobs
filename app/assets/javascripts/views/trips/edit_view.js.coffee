window.Views.Trips ||= {}
class Views.Trips.EditView extends Views.ApplicationView
  render: ->
    super()
    Widgets.Tabs.enable()
  cleanup: ->
    super()
    Widgets.Tabs.cleanup()
