window.Views.Routes ||= {}
class Views.Routes.EditView extends Views.ApplicationView
  render: ->
    super()

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

  cleanup: ->
    super()


