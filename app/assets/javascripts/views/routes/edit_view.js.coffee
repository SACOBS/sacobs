window.Views.Routes ||= {}
class Views.Routes.EditView extends Views.ApplicationView
  render: ->
    super()
    Widgets.Calculator.enable()
    Widgets.DateTimePicker.enable()
    Widgets.Tabs.enable()
  cleanup: ->
    super()
    Widgets.Calculator.cleanup()
    Widgets.DateTimePicker.cleanup()
    Widgets.Tabs.cleanup()

