$(document).on "page:change", ->
  return unless $(".bookings-wizard").length > 0

  $('.amount').on 'change', ->
    total = 0
    $('#line_items tr.line_item').each ->
      value = Number($(this).find('td.amount input').val())
      value = value * -1 if $(this).data('type') == 'credit'
      total += value if (!isNaN(value))
    $('.total').html("<strong> R" + total.toFixed(2) + "</strong>")
  $('.amount').trigger('change')