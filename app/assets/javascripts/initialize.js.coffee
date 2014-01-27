$.fn.twitter_bootstrap_confirmbox.defaults.title = 'Sacobs'

$ ->
  $('.datepicker').datetimepicker({pickTime: false});
  $('.timepicker').datetimepicker({pickDate: false, pickSeconds: false});
  $('.datetimepicker').datetimepicker();

  $('select[rel="autocomplete"]').each ->
    $(this).select2({
      width: 'element',
      placeholder: $(this).data('default')
    });

  $(document).on 'hidden', '.modal', ->
    $(this).remove()

  $('#Tabbed a').click (e)->
    e.preventDefault()
    $(this).tab('show')


