$.fn.twitter_bootstrap_confirmbox.defaults.title = 'Sacobs'

refresh_total = ()->
  total = 0
  $('#line_items tr.line_item').each ->
   value = Number($(this).find('td.amount input').val())
   total += value if (!isNaN(value))
  $('.total').html("<strong> R" + total.toFixed(2) + "</strong>")

$ ->
  $('.datepicker').datetimepicker({pickTime: false});
  $('.datetimepicker').datetimepicker();

  $('select[rel="autocomplete"]').each ->
    $(this).select2({
      width: 'element',
      placeholder: $(this).data('default')
    });

  $(document).on 'change', '.discount', ->
    line_item =  $(this).closest('tr')
    discount = Number($(this).find('input').val())
    current_amount = Number(line_item.find('td.amount input').val())
    new_amount = current_amount - discount
    line_item.find('td.amount input').val(new_amount.toFixed(2))
    refresh_total()







