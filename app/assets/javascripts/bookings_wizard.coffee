$(document).on "page:change", ->
  return unless $(".bookings-wizard").length > 0

  $("[data-behaviour='show-prices']").on 'ajax:success', (evt, data, status, xhr) ->
    $(this).popover({ container: 'body', content: data, html: true, trigger: 'hover'});
    $(this).trigger('mouseenter');

  $("[data-behaviour~=select-client]").change ->
    $.getJSON "/clients/" + $(this).val(), (client) ->
      for key, value of client
          $input = $('.new-client-fields').find("[name*=#{key}]")
          if $input.is(':checkbox')
            $input.prop('checked', value)
          else
            $input.val(value)

  $('.amount').on 'change', ->
    total = 0
    $('#line_items tr.line_item').each ->
      value = Number($(this).find('td.amount input').val())
      value = value * -1 if $(this).data('type') == 'credit'
      total += value if (!isNaN(value))
    $('.total').html("<strong> R" + total.toFixed(2) + "</strong>")
  $('.amount').trigger('change')
