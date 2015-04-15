window.Views.Bookings ||= {}
window.Views.Bookings.Archives ||= {}
class Views.Bookings.Archives.IndexView extends Views.ApplicationView
  render: ->
    super()
    Widgets.DateTimePicker.enable()
    $('#booking_search').on 'ajax:success', (evt, data, status, xhr) ->
      $('#bookings').html(data)
      return
  cleanup: ->
    super()
    Widgets.DateTimePicker.cleanup()
    $('#booking_search').off 'ajax:success'