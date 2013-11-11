$.fn.twitter_bootstrap_confirmbox.defaults.title = 'Sacobs'

$ ->
  $('.datepicker').datetimepicker({pickTime: false});
  $('.datetimepicker').datetimepicker();

  $('select[rel="autocomplete"]').each ->
    $(this).select2({
      width: 'element',
      placeholder: $(this).data('default')
    });

  $(document).on 'change', '.discount, .gross', ->
    line_item =  $(this).closest('tr')
    discount = Number(line_item.find('td.discount input').val())
    current_gross = Number(line_item.find('td.gross input').val())
    percentage = (discount / current_gross) * 100
    nett = current_gross - discount
    line_item.find('td.percentage').text(percentage.toFixed() + '%')
    line_item.find('td.nett input').val(nett.toFixed(2))
    refresh_total()

  $(document).on 'change', '.nett', ->
    refresh_total()


  refresh_total = ()->
    total = 0
    $('#line_items tr.line_item').each ->
      value = Number($(this).find('td.nett input').val())
      total += value if (!isNaN(value))
    $('.total').html("<strong> R" + total.toFixed(2) + "</strong>")







