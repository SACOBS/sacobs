window.Widgets ||= {}
class Widgets.TypeAhead
  @enable:  ->
   $('input.typeahead').each ->
    $(this).prop('name','')

   $('input.typeahead').keyup ->
    if($.trim($(this).val()) == '')
       $("#" + $(this).prop('id') + '_id').val('')

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
      $("#" + this.$element.prop('id') + '_id').val(this.map[item].id)
      return item

  @cleanup: ->
    $('input.typeahead').off()




