window.Views.Trips ||= {}
class Views.Trips.SearchView extends Views.ApplicationView
  render: ->
    super()
    Widgets.DateTimePicker.enable()
  cleanup: ->
    super()
    Widgets.DateTimePicker.cleanup()
