window.Widgets ||= {}
class Widgets.TypeAhead
  @enable: ->
   $('input.typeahead').each ->
    $(this).prop('autocomplete', 'off')
    $(this).prop('name', '')

   $('input.typeahead').keyup ->
    if($.trim($(this).val()) == '')
       $(this.data('target')).val('')

   $('input.typeahead').typeahead
    source: (query, process) ->
      $this = this
      url = $this.$element.data('source')

      return $.getJSON url, (data) ->
        objects = []
        $this['map'] = {}
        $.each data, (i, object) ->
          $this.map[object.name] = object
          objects.push(object.name)
        process(objects)

    updater: (item) ->
      if this.$element.data().hasOwnProperty('populate')
        field_container = this.$element.data('populate').toString()
        $.getJSON this.map[item].url, (data) ->
          $.each data,( key, value ) ->
           input = $(field_container).find('[name*=' + key + ']')
           $(input).val(value.toString()) if value


      item_id = this.map[item].id
      targets = this.$element.data('targets').split(',')
      $.each targets, (index, value) ->
        $(value).val(item_id)
      return item

  @cleanup: ->
    $('input.typeahead').off()




