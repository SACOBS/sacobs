window.Views.Routes ||= {}
class Views.Routes.EditView extends Views.ApplicationView
  render: ->
    super()
    $( "#connections input[name*='cost']" ).on 'input', ->
      route_cost = $("input[name~='route[cost]']").val()
      cost = this.value
      $percentageInput = $(this).closest('tr').find("input[name*='percentage']")
      percentage = Math.round((cost / route_cost) * 100)
      $percentageInput.val(percentage);

    $( "#connections input[name*='percentage']" ).on 'input', ->
      route_cost = $("input[name~='route[cost]']").val()
      percentage = this.value
      $costInput = $(this).closest('tr').find("input[name*='cost']")

      cost = Math.ceil(((percentage / 100) * route_cost) / 5) * 5
      $costInput.val(cost);

  cleanup: ->
    super()

