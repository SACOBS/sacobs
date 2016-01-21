$(document).on "page:change", ->
  return unless $(".destinations").length > 0
  $('[data-behaviour~=sortable]').sortable(
    appendTo: 'body'
    helper: 'clone'  
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

  $('.route-destinations').on 'cocoon:before-insert',(event, destination) ->
    destination.find("td input[name*='sequence']").val(parseInt($(this).find('tr:last').find("td input[name*='sequence']").val()) + 1)
