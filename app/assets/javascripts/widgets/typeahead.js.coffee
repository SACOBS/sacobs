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


  @cleanup: ->
    $('input.typeahead').off()





