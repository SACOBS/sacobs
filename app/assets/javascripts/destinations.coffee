$(document).on "page:change", ->
  return unless $(".destinations.edit").length > 0
  $('[data-behaviour~=sortable]').sortable(
    axis: 'y'
    items: '.destination'
    cursor: 'move'
    cancel: ".disable-sort-item"
    stop: (e, ui) ->
      ui.item.children('tr').effect('highlight', {}, 1000)
    update: (e, ui) ->
      $('tr.destination').each (index, row) ->
       $(row).find("input[name*='sequence']" ).val(index + 1)
  )

  $('.route-destinations').on 'cocoon:after-insert',(event, destination) ->
    destination.find("td input[name*='city']").prop('enabled', true).focus()
    destination.find("td input[name*='sequence']").val(destination.index() + 1)
    typeAhead = new App.TypeAhead
    typeAhead.render()
