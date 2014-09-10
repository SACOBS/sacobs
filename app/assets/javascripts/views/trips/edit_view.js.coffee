window.Views.Trips ||= {}
class Views.Trips.EditView extends Views.ApplicationView
  render: ->
    super()
    Widgets.DateTimePicker.enable()
    Widgets.Select2.enable()
    Widgets.Tabs.enable()
  cleanup: ->
    super()
    Widgets.Tabs.cleanup()
    Widgets.Select2.cleanup()
    Widgets.DateTimePicker.cleanup()

