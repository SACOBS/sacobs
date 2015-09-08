$(document).on "page:change", ->
  $.bootstrapSortable(applyLast=true)
  $('[rel~="tooltip"]').tooltip()
  $('#show_notes').click ->
    $('#notes').toggle();
  $('a[data-toggle="tab"]').on 'click', (e) ->
    e.preventDefault()
    $(this).tab('show');


