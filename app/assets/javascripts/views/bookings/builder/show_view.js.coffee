window.Views.Bookings ||= {}
window.Views.Bookings.Builder ||= {}
class Views.Bookings.Builder.ShowView extends Views.ApplicationView
  render: ->
    super()
    Widgets.DateTimePicker.enable()
    Widgets.Select2.enable()

    $(document).on 'hidden', '.modal', ->
      $(this).remove()

    $(document).on 'click', '#new_client',(e) ->
      e.preventDefault()
      $('.new_client_fields').fadeIn 'slow'
      $('#new_client').hide()

    $(document).on 'change', '.amount', ->
      total = 0
      $('#line_items tr.line_item').each ->
        value = Number($(this).find('td.amount input').val())
        value = value * -1 if $(this).data('type') == 'credit'
        total += value if (!isNaN(value))
      $('.total').html("<strong> R" + total.toFixed(2) + "</strong>")
  cleanup: ->
    super()
    Widgets.Select2.cleanup()
    Widgets.DateTimePicker.cleanup()

    $(document).off 'click', '#new_client'
    $(document).off 'change', '.amount'
    $(document).off 'hidden', '.modal'

