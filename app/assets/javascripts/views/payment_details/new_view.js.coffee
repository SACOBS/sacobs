window.Views.PaymentDetails ||= {}
class Views.PaymentDetails.NewView extends Views.ApplicationView
  render: ->
    super()
    Widgets.DateTimePicker.enable()
  cleanup: ->
    super()
    Widgets.DateTimePicker.cleanup()
