#Client
$(document).on 'click', '#new_client', ->
  $('.new_client_fields').fadeToggle('slow', 'linear');

#Billing
$(document).on 'change', '.amount', ->
  line_item =  $(this).closest('tr')
  amount = Number(line_item.find('td.amount input').val())
  line_item.find('td.amount input').val(amount.toFixed(2))
  refresh_total()

$(document).on 'change', '.amount', ->
  refresh_total()


refresh_total = ()->
  total = 0
  $('#line_items tr.line_item').each ->
    value = Number($(this).find('td.amount input').val())
    value = value * -1 if $(this).data('type') == 'credit'
    total += value if (!isNaN(value))
  $('.total').html("<strong> R" + total.toFixed(2) + "</strong>")
