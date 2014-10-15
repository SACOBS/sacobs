window.Views.Bookings ||= {}
window.Views.Bookings.Builder ||= {}
class Views.Bookings.Builder.ShowView extends Views.ApplicationView
  render: ->
    super()
    Widgets.DateTimePicker.enable()
    Widgets.TypeAhead.enable()

    $(document).on 'ajax:success', '#trip_search', (evt, data, status, xhr) ->
      $('.trips').html(data)


    $(document).on 'ajax:success', '#return_trip_search', (evt, data, status, xhr) ->
      $('.returns').html(data)

    $(document).on 'click', '#new_client',(e) ->
      e.preventDefault()
      $('.new_client_fields').fadeToggle 'slow'

    $(document).on 'change', '.amount', ->
      total = 0
      $('#line_items tr.line_item').each ->
        value = Number($(this).find('td.amount input').val())
        value = value * -1 if $(this).data('type') == 'credit'
        total += value if (!isNaN(value))
      $('.total').html("<strong> R" + total.toFixed(2) + "</strong>")
  cleanup: ->
    super()
    Widgets.DateTimePicker.cleanup()
    Widgets.TypeAhead.cleanup()

    $(document).off 'click', '#new_client'
    $(document).off 'change', '.amount'

