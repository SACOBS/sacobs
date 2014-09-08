window.Views.Routes ||= {}
window.Views.Routes.Builder ||= {}
class Views.Routes.Builder.ShowView extends Views.ApplicationView
  render: ->
    super()
    Widgets.DateTimePicker.enable()
    Widgets.Calculator.enable()
  cleanup: ->
    super()
    Widgets.DateTimePicker.cleanup()
    Widgets.Calculator.cleanup()


