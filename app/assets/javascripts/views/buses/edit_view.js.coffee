window.Views.Buses ||= {}
class Views.Buses.EditView extends Views.ApplicationView
  render: ->
    super()
    Widgets.Tabs.enable()
  cleanup: ->
    super()
    Widgets.Tabs.cleanup()
