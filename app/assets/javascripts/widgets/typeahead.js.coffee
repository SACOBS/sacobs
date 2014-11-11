window.Widgets ||= {}
class Widgets.TypeAhead
  @enable: ->
   $('input.typeahead').each ->
    $(this).prop('autocomplete', 'off')
    $(this).prop('name', '')

   $('input.typeahead').keyup ->
    if($.trim($(this).val()) == '')
      targets = $(this).data('targets').split(',')
      Utilities.updateCollectionValues(targets, '')


   $('input.typeahead').typeahead
    source: (query, process) ->
      $this = this
      url = $this.$element.data('source')
      objects = []
      map = {}

      if localStorage && localStorage.getItem(url)
        objects = JSON.parse(localStorage.getItem(url))
        process(objects)
        return
      else
        return $.getJSON url, (data) ->
          $.each data, (i, object) ->
            map[object.name] = object
            objects.push(object.name)

          localStorage.setItem(url, JSON.stringify(objects))
          localStorage.setItem($this.$element.id, JSON.stringify(map))

          process(objects)

#    matcher: (item) ->
#      condition = this.query.trim()
#      return (item.substr(0, condition.length).toLowerCase() == condition.toLowerCase())



    updater: (item) ->
      map = JSON.parse(localStorage.getItem(this.$element.id))

      if this.$element.data().hasOwnProperty('populate')
        field_container = this.$element.data('populate').toString()
        $.getJSON map[item].url, (data) ->
          $.each data,( key, value ) ->
           input = $(field_container).find('[name*=' + key + ']')
           $(input).val(value.toString()) if value


      item_id = map[item].id
      targets = this.$element.data('targets').split(',')
      $.each targets, (index, value) ->
        $(value).val(item_id)
      return item

  @cleanup: ->
    $('input.typeahead').off()





