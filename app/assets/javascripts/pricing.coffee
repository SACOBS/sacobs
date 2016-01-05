$(document).on "page:change", ->
  return unless $(".pricing").length > 0
  $connections = $('#connections-list').find('li')

  $("input[type='radio']").on "change", ->
    $connections.detach().filter('[data-route=' + parseInt(this.value) + ']').appendTo('#connections-list')

  $("input[type=radio]:first").trigger('click')


  $('#connection-search').on 'keyup', ->
    route_id = parseInt($("input[type='radio']:checked").val());
    search_term = this.value.toLowerCase()
    if(!!search_term)
      $connections.detach().filter(->
        console.log($(this).data('route') == route_id)
        $(this).data('route') == route_id  && $(this).text().toLowerCase().indexOf(search_term) != -1
      ).appendTo('#connections-list')

  $(document).on 'ajax:success', '#show_pricing' ,(evt, data, status, xhr) ->
    $('.quote').html(data)
