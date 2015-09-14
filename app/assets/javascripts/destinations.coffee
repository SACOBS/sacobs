$(document).on "page:change", ->
  return unless $(".destinations").length > 0
  $('[data-behaviour~=sortable]').sortable(
    axis: 'y'
    items: '.destination'
    cursor: 'move'
    cancel: ".disable-sort-item, select"
    stop: (e, ui) ->
      ui.item.children('td').effect('highlight', {}, 1000)
    update: (e, ui) ->
      $('tr.destination').each (index, row) ->
        $(row).find("input[name*='sequence']" ).val(index + 1)
  )

  $('.route-destinations').on 'cocoon:after-insert',(event, destination) ->
    next_sequence = destination.parent('tbody').prop('rows').length
    destination.find("td input[name*='sequence']").val(next_sequence)
