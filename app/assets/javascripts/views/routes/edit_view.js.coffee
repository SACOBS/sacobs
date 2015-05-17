window.Views.Routes ||= {}
class Views.Routes.EditView extends Views.ApplicationView
  render: ->
    super()
    Widgets.Calculator.enable()
  cleanup: ->
    super()
    Widgets.Calculator.cleanup()

