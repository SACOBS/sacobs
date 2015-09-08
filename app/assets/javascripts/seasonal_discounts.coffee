$(document).on "page:change", ->
  return unless $(".seasonal-discounts").length > 0
  $('#discounted-price, #original-price').on 'input',  ->
    discounted_price = Number($('#discounted-price').val())
    original_price = Number($('#original-price').val())
    if !isNaN(discounted_price) || !isNaN(original_price)
      difference_in_price = original_price - discounted_price
      percentage = ((difference_in_price / original_price) * 100).toFixed()
      $('#difference span').text(difference_in_price.toString())
      $('#percentage span').text('%' + percentage.toString())