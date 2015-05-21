window.Views.Routes ||= {}
class Views.Routes.EditView extends Views.ApplicationView
  render: ->
    super()

    $( "#connections input[name*='cost']" ).on 'change', ->
      route_cost = $("input[name~='route[cost]']").val()
      cost = this.value
      $percentageInput = $(this).closest('tr').find("input[name*='percentage']")
      percentage = Math.round((cost / route_cost) * 100)
      $percentageInput.val(percentage)

    $( "#connections input[name*='percentage']" ).on 'change', ->
      route_cost = $("input[name~='route[cost]']").val()
      percentage = this.value
      $costInput = $(this).closest('tr').find("input[name*='cost']")

      cost = Math.ceil(((percentage / 100) * route_cost) / 5) * 5
      $costInput.val(cost)

    $("input[name~='route[cost]']").on 'change', ->
      cost = this.value
      $connections = $('#connections')
      $rows = $connections.find('tr')
      $.each $rows, (index, row) ->
        $(row).find("input[name*='percentage']").trigger('change')

  cleanup: ->
    super()


