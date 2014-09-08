window.Views.Bookings ||= {}
class Views.Bookings.IndexView extends Views.ApplicationView
  render: ->
    super()
    Widgets.DateTimePicker.enable()
    $(document).on 'hidden', '.modal', ->
      $(this).remove()
  cleanup: ->
    super()
    Widgets.DateTimePicker.cleanup()
    $(document).off 'hidden', '.modal'
