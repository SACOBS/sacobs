window.Views.Trips ||= {}
class Views.Trips.EditView extends Views.ApplicationView
  render: ->
    super()
    Widgets.DateTimePicker.enable()
    Widgets.Tabs.enable()
  cleanup: ->
    super()
    Widgets.Tabs.cleanup()
    Widgets.DateTimePicker.cleanup()

