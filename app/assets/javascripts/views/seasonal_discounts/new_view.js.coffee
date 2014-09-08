window.Views.SeasonalDiscounts ||= {}
class Views.SeasonalDiscounts.NewView extends Views.ApplicationView
  render: ->
    super()
    Widgets.DateTimePicker.enable()
  cleanup: ->
    super()
    Widgets.DateTimePicker.cleanup()
