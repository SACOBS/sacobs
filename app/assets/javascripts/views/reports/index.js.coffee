window.Views.Reports ||= {}
class Views.Reports.IndexView extends Views.ApplicationView
  render: ->
    super()
    Widgets.TypeAhead.enable()
    Widgets.DateTimePicker.enable()
  cleanup: ->
    super()
    Widgets.TypeAhead.cleanup()
    Widgets.DateTimePicker.cleanup()