window.Views.Bookings ||= {}
class Views.Bookings.IndexView extends Views.ApplicationView
  render: ->
    super()
    Widgets.DateTimePicker.enable()
    $('#booking_search').on 'ajax:success', (evt, data, status, xhr) ->
      $('#bookings').html(data)

    $(document).on 'hidden', '.modal', ->
      $(this).remove()
  cleanup: ->
    super()
    Widgets.DateTimePicker.cleanup()
    $('#booking_search').off 'ajax:success'
    $(document).off 'hidden', '.modal'
