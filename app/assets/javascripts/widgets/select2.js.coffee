window.Widgets ||= {}
class Widgets.Select2
  @enable: ->
    $('select[rel="autocomplete"]').select2
      width: 'element',
      placeholder: $(this).data('default')
  @cleanup: -> $('select[rel="autocomplete"]').off()