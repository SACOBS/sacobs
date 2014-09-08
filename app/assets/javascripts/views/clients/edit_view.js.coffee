window.Views.Clients ||= {}
class Views.Clients.EditView extends Views.ApplicationView
  render: ->
    super()
    Widgets.DateTimePicker.enable()
  cleanup: ->
    super()
    Widgets.DateTimePicker.cleanup()
