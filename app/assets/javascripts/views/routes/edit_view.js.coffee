window.Views.Routes ||= {}
class Views.Routes.EditView extends Views.ApplicationView
  render: ->
    super()
    Widgets.DateTimePicker.enable()
    Widgets.Tabs.enable()
    Widgets.Calculator.enable()
  cleanup: ->
    super()
    Widgets.DateTimePicker.cleanup()
    Widgets.Tabs.cleanup()
    Widgets.Calculator.cleanup()

