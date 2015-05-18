window.Views.Routes ||= {}
window.Views.Routes.Builder ||= {}
class Views.Routes.Builder.ShowView extends Views.ApplicationView
  render: ->
    super()
    $( "#connections input[name*='cost']" ).on 'input', ->
      route_cost = $("#connections").data('route-cost')
      cost = this.value
      $percentageInput = $(this).closest('tr').find("input[name*='percentage']")
      percentage = Math.round((cost / route_cost) * 100)
      $percentageInput.val(percentage);

    $( "#connections input[name*='percentage']" ).on 'input', ->
      route_cost = $("#connections").data('route-cost')
      percentage = this.value
      $costInput = $(this).closest('tr').find("input[name*='cost']")

      cost = Math.ceil(((percentage / 100) * route_cost) / 5) * 5
      $costInput.val(cost);

    $(document).on 'cocoon:after-insert',(event, destination) ->
      destination.find("td input[name*='sequence']").val(destination.index() + 1)
      Widgets.TypeAhead.enable()

    $(document).on 'cocoon:after-remove',(event, destination) ->
      $('#destinations').find('tr').each (index) ->
        $(this).find("td input[name*='sequence']").val(index)
  cleanup: ->
    super()
    $( "#connections input[name*='cost']" ).off 'input'
    $( "#connections input[name*='percentage']" ).off 'input'
    Widgets.TypeAhead.cleanup()
    $(document).off 'cocoon:after-insert'


