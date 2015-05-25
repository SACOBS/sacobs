window.Views.Bookings ||= {}
window.Views.Bookings.Builder ||= {}
class Views.Bookings.Builder.ShowView extends Views.ApplicationView
  render: ->
    super()

    $('.amount').on 'change', ->
      total = 0
      $('#line_items tr.line_item').each ->
        value = Number($(this).find('td.amount input').val())
        value = value * -1 if $(this).data('type') == 'credit'
        total += value if (!isNaN(value))
      $('.total').html("<strong> R" + total.toFixed(2) + "</strong>")

  cleanup: ->
    super()
    $('#return_trip_search').off 'ajax:success'
    $('.amount').off 'change'

