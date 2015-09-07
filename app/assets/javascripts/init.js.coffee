$.fn.twitter_bootstrap_confirmbox.defaults.title = 'Sacobs'

$(document).on "page:change", ->
  $.bootstrapSortable(applyLast=true)
  $('[rel~="tooltip"]').tooltip()
  $('#show_notes').click ->
    $('#notes').toggle();
  $('a[data-toggle="tab"]').on 'click', (e) ->
    e.preventDefault()
    $(this).tab('show');

  $('.datepicker').datetimepicker({pickTime: false });
  $('.timepicker').datetimepicker({pickDate: false, pickSeconds: false});
  $('.datetimepicker').datetimepicker();

  $(document).on 'focus', '.datepicker, .timepicker, .datetimepicker',  ->
    $(this).datetimepicker('show')
    return

  $(document).on 'blur', '.datepicker, .timepicker, .datetimepicker',  ->
    if $(this).data('datetimepicker').viewMode == 0
      $(this).datetimepicker('hide')
    return

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