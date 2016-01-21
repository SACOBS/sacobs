$(document).on "page:change", ->
  return unless $(".routes").length > 0
  $('.route-destinations').on 'cocoon:after-insert', (event, destination) ->
    console.log(destination.index())
    destination.find("td input[name*='city']").prop('enabled', true).focus()
    destination.find("td input[name*='sequence']").val(destination.index() + 1)
    $('[data-behaviour~=dropdown]').select2(
       theme: "bootstrap",
       minimumResultsForSearch: 15
    );


  $('.route-destinations').on 'cocoon:after-remove',(event, destination) ->
    $('#destinations').find('tr').each (index) ->
      $(this).find("td input[name*='sequence']").val(index)


  $( "#connections input[name*='cost']" ).on 'change', ->
    route_cost = $("input[name~='route[cost]']").val()
    $percentageInput = $(this).closest('tr').find("input[name*='percentage']")
    $percentageInput.val(calculatePercentage(this.value, route_cost))

  $( "#connections input[name*='percentage']" ).on 'change', ->
    route_cost = $("input[name~='route[cost]']").val()
    $costInput = $(this).closest('tr').find("input[name*='cost']")
    $costInput.val(calculateCost(this.value, route_cost ))

  $("input[name~='route[cost]']").on 'change', ->
    route_cost = this.value
    $connections = $('#connections')
    $rows = $connections.find('tr')
    $.each $rows, (index, row) ->
      percentage = $(row).find("input[name*='percentage']").val()
      $costInput = $(row).find("input[name*='cost']")
      $costInput.val(calculateCost(percentage, route_cost ))

  calculateCost = (percentage, amount) ->
    Math.ceil(((percentage / 100 * amount) / 5) * 5)

  calculatePercentage = (amount, total) ->
    Math.round((amount / total) * 100)