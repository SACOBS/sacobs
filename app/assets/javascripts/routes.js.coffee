$(document).on "page:change", ->
  return unless $(".routes").length > 0
  $(document).on 'cocoon:after-insert',(event, destination) ->
    destination.find("td input[name*='sequence']").val(destination.index() + 1)

    $('input.typeahead').each ->
      $(this).prop('autocomplete', 'off')
      $(this).prop('name', '')

    $('input.typeahead').keyup ->
      if($.trim($(this).val()) == '')
        targets = $(this).data('targets').split(',')
        $.each targets, (index, item) ->
          $(item).val('')
        if $(this).data().hasOwnProperty('populate')
          $(this).closest('form')[0].reset()


    $('input.typeahead').typeahead
      items: 20
      source: (query, process) ->
        data = $(this.$element.data('source'))
        objects = $.map(data, (item) -> return JSON.stringify(item) )
        process(objects)
        return

      highlighter: (item) ->
        return JSON.parse(item)[this.$element.data('filter').toString()]

      matcher: (item) ->
        return JSON.parse(item)[this.$element.data('filter').toString()].toLocaleLowerCase().indexOf(this.query.toLocaleLowerCase()) != -1;

      updater: (item) ->
        object = JSON.parse(item)

        if this.$element.data().hasOwnProperty('populate')
          field_container = this.$element.data('populate').toString()
          $.each object,( key, value ) ->
            unless key == 'id'
              input = $(field_container).find('[name*=' + key + ']')
              if value
                $(input).val(value.toString())
              else
                $(input).val('')


        item_id = object.id
        targets = this.$element.data('targets').split(',')
        $.each targets, (index, value) ->
          $(value).val(item_id)
        return JSON.parse(item)[this.$element.data('filter').toString()]

  $(document).on 'cocoon:after-remove',(event, destination) ->
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