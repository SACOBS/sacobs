class BookingsBuilderController
  init: ->
    $('.journey_return_date').hide()

  new: ->
    $(document).on 'click', 'input[name= "journey[return]"]', ->
      if $(this).is(':checked')
        $('.journey_return_date').show()
      else
        $('.journey_return_date').hide()
        $('input[name="journey[return_date]"]').val('')

  show: ->
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



this.Sacobs.bookings_builder = new BookingsBuilderController()
